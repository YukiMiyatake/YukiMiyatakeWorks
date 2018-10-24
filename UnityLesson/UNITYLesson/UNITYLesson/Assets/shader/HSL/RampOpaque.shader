/*
  HerritageShaderLibrary
  Happy sugar life for you!
*/

Shader "HSL/RampOpaque"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}

		_RampTex ("RampTexture", 2D) = "white" {}
		_ToonPower("ToonPower", Range(0.0, 1.0)) = 0.5
		_ToonColor("ToonColor", Color) = (0.0, 0.0, 0.0, 0.0)
		_ToonThreshold("ToonThreshold", Range(0.0,1.0)) = 0.0

        _ShadowPower ("ShadowPower", Range(0.0, 1.0)) = 0.5
        _ShadowTex ("ShadowTexture", 2D) = "white" {}
        _ShadowTexPower ("ShadowTexPower", Range(0.0, 1.0)) = 0.5
		
		_Spec1Power("Specular Power", Range(0, 30)) = 1
		_Spec1Color("Specular Color", Color) = (0.5,0.5,0.5,1)

		_OutlineWidth("Outline Width", Range(0.0002, 0.01)) = 0.001
		_OutlineColor("Outline Color", Color) = (0.0, 0.0, 0.0, 1.0)
	}

	SubShader{
		Tags{ "Queue" = "Geometry" "RenderType" = "Opaque" }
//        Tags{ "Queue" = "Geometry" "RenderType" = "Opaque" "IgnoreProjector" = "True" }
    	Pass{
			Tags{
				"LightMode" = "ForwardBase"
			}

			Cull Back

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "AutoLight.cginc"
            #pragma multi_compile_fwdbase

 //          #pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight
			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 texcoord	  : TEXCOORD0;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float4 vertexW: TEXCOORD0;
				float2 uv	  : TEXCOORD1;
				float3 normalWorld : TEXCOORD2;
                SHADOW_COORDS(3)
			};


            struct v2f_in
            {
                UNITY_VPOS_TYPE vpos : VPOS;
                float4 vertexW: TEXCOORD0;
                float2 uv     : TEXCOORD1;
                float3 normalWorld : TEXCOORD2;
                SHADOW_COORDS(3)
            };

            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;

            uniform sampler2D _RampTex; uniform float4 _RampTex_ST;
			uniform float _ToonPower;
			uniform float4 _ToonColor;
			uniform float _ToonThreshold;

			uniform sampler2D _ShadowTex; uniform float4 _ShadowTex_ST;
            uniform float _ShadowPower;
            uniform float _ShadowTexPower;
			uniform float _Spec1Power;
			uniform float4 _Spec1Color;


			v2f vert(appdata_full v){
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.vertexW = mul(unity_ObjectToWorld, v.vertex);

                o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
                o.normalWorld = UnityObjectToWorldNormal(v.normal);

                half3 eyeVec = normalize(o.vertexW.xyz - _WorldSpaceCameraPos);

                TRANSFER_SHADOW(o);

				return o;
			}

			float4 frag(v2f_in i) : SV_Target{
				float3 L = normalize(_WorldSpaceLightPos0.xyz);
				float3 V = normalize(_WorldSpaceCameraPos - i.vertexW.xyz);
				float3 N = i.normalWorld;
				float3 H = normalize(L + V);


				//LightColor
				float3 lightCol = _LightColor0.rgb * lerp( (1-_ShadowPower), 1.0,  LIGHT_ATTENUATION(i));

				//Ambient
				float3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb;
				
				// texture albedo
				float4 tex = tex2D(_MainTex, i.uv);

				// Diffuse(HalfLambert)
				float3 NdotL = dot(N, L);
				float3 diffuse = (NdotL*0.5 + 0.5);
				float4 ramp = tex2D(_RampTex, float2(diffuse.x, 0));
//				float4 ramp2 = lerp(float4(1.0, 1.0, 1.0, 1.0), float4(_ToonColor.xyz, 1.0), step( diffuse.x, _ToonThreshold ));
				float4 ramp2 = (diffuse.x >= _ToonThreshold) ? float4(1.0, 1.0, 1.0, 1.0): float4(_ToonColor.xyz, 1.0);


				// Speculer
				float3 specular = pow(max(0.0, dot(H, N)), _Spec1Power) * _Spec1Color.xyz * lightCol;  // Half vector
                            
                i.vpos.xy /= _ScreenParams.xy;

				float3 shadowTex = lerp(lerp(1 - _ShadowTexPower, 1.0, tex2D(_ShadowTex, i.vpos.xy)), 1.0, SHADOW_ATTENUATION(i)* diffuse);
				return float4(saturate(ambient* (tex*(1 - _ToonPower) + ramp*_ToonPower ) * shadowTex * ramp2 + specular), 1.0);
			}
			ENDCG
		}
        


        // ------------------------------------------------------------------
        //  Shadow rendering pass
        Pass {
            Name "ShadowCaster"
            Tags { "LightMode" = "ShadowCaster" }

            Offset 1, 1
            Cull Off

            ZWrite On ZTest LEqual

            CGPROGRAM
            #pragma target 3.0

  
            #pragma vertex vertShadowCaster
            #pragma fragment fragShadowCaster


            #include "UnityCG.cginc"
            #pragma multi_compile_shadowcaster

 
             struct v2f {
                V2F_SHADOW_CASTER;
            };
    
            v2f vertShadowCaster (appdata_base v) {
                v2f o = (v2f)0;
                TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
                return o;
            }

            float4 fragShadowCaster(v2f i) : SV_TARGET {
                SHADOW_CASTER_FRAGMENT(i)
            }


            ENDCG

        }

		Pass
		{

			Name "OUTLINE"

			Lighting Off
			Cull Front
			ZWrite On
			ColorMask RGB

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"


			uniform float _OutlineWidth;
			uniform float4 _OutlineColor;


			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 texcoord	  : TEXCOORD0;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				fixed4 outlineColor : COLOR;
			};


			// アウトラインの頂点計算
			v2f vert(appdata v)
			{
				v2f o;
				//UNITY_INITIALIZE_OUTPUT(v2f,o);
				float3 norm = normalize(mul((float3x3)UNITY_MATRIX_IT_MV, v.normal));
				float2 offset = TransformViewToProjection(norm.xy);


				o.pos = UnityObjectToClipPos(v.vertex);
				o.pos.xy += offset  * _OutlineWidth;

				o.outlineColor = _OutlineColor;

				return o;
			}

			// アウトライン面レンダリング
			fixed4 frag(v2f i) : SV_Target
			{
				// 計算済みのアウトライン色を返す
				return i.outlineColor;
			}

			ENDCG
		}
    }
    FallBack "Diffuse"

}
