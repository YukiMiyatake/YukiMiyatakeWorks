﻿/*
  HerritageShaderLibrary
  Happy sugar life for you!
*/

Shader "HSL/RampOpaque"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}

		_RampTex ("RampTexture", 2D) = "white" {}

        _ShadowPower ("ShadowPower", Range(0.0, 1.0)) = 0.5
        _ShadowTex ("ShadowTexture", 2D) = "white" {}
        _ShadowTexPower ("ShadowTexPower", Range(0.0, 1.0)) = 0.5
		
		_Spec1Power("Specular Power", Range(0, 30)) = 1
		_Spec1Color("Specular Color", Color) = (0.5,0.5,0.5,1)
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
//				float3 diffuse = (NdotL*0.5 + 0.5) * lightCol ;

				// Speculer
				float3 specular = pow(max(0.0, dot(H, N)), _Spec1Power) * _Spec1Color.xyz * lightCol;  // Half vector
                            
                i.vpos.xy /= _ScreenParams.xy;
//                float3 shadowTex = tex2D(_ShadowTex, i.vpos.xy) * lerp( _ShadowTexPower, 0.0,  ( SHADOW_ATTENUATION(i)*(diffuse+0.8) ) );
                float3 shadowTex =  lerp( tex2D(_ShadowTex, i.vpos.xy), 1.0, SHADOW_ATTENUATION(i)*diffuse );
				return float4( saturate((ambient ) * tex * ramp * (shadowTex) + specular), 1.0);
			}
			ENDCG
		}
        


		Pass
		{
			Name "Outline"
			Cull Front

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag

#include "UnityCG.cginc"

			struct appdata
		{
			float4 vertex : POSITION;
			float3 normal : NORMAL;
		};

		struct v2f
		{
			float4 vertex : SV_POSITION;
		};

		v2f vert(appdata v)
		{
			v2f o;
			v.vertex += float4(v.normal * 0.004f, 0);
			o.vertex = UnityObjectToClipPos(v.vertex);
			return o;
		}

		fixed4 frag(v2f i) : SV_Target
		{
			fixed4 col = fixed4(0.1,0.1,0.1,1);
		return col;
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

            /*
            struct appdata_base {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

             struct v2f {
                float4 pos : SV_POSITION;
            };
            */

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

    }
    FallBack "Diffuse"

}
