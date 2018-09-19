Shader "Unlit/yUnit"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Spec1Power("Specular Power", Range(0, 30)) = 1
		_Spec1Color("Specular Color", Color) = (0.5,0.5,0.5,1)
	}
	SubShader
		{

			Tags { "RenderType" = "Opaque" }
			Pass
			{
				Tags{
					"LightMode" = "ForwardBase"
				}

				Cull Back

				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

 //#pragma multi_compile_shadowcaster
 				#include "UnityCG.cginc"
				#include "Lighting.cginc"
				#include "AutoLight.cginc"

				struct appdata
				{
					float4 vertex : POSITION;
					float3 normal : NORMAL;
					float2 texcoord	  : TEXCOORD0;
				};

				struct v2f
				{
					float4 vertex : SV_POSITION;
					float4 vertexW: TEXCOORD0;
					float2 uv	  : TEXCOORD1;
					float3 normalWorld : TEXCOORD2;
                    UNITY_SHADOW_COORDS(3)
				};

				uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
				uniform float _Spec1Power;
				uniform float4 _Spec1Color;


				v2f vert(appdata_full v)
				{
					v2f o;
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.vertexW = mul(unity_ObjectToWorld, v.vertex);

                    o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
                    o.normalWorld = UnityObjectToWorldNormal(v.normal);

                    half3 eyeVec = normalize(o.vertexW.xyz - _WorldSpaceCameraPos);
                  //  o.normalWorld.xyz = normalWorld;

                    TRANSFER_SHADOW(o);
//                    UNITY_TRANSFER_SHADOW(o, v.texcoord);

					return o;
				}

				float4 frag(v2f i) : SV_Target
				{
					float3 L = normalize(_WorldSpaceLightPos0.xyz);
					float3 V = normalize(_WorldSpaceCameraPos - i.vertexW.xyz);
					float3 N = i.normalWorld;
					float3 H = normalize(L + V);


					//LightColor
					float3 lightCol = _LightColor0.rgb * LIGHT_ATTENUATION(i);

					//Ambient
					float3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb;
					
					// texture albedo
					float4 tex = tex2D(_MainTex, i.uv);

					// Diffuse(HalfLambert)
					float3 NdotL = dot(N, L);
					float3 diffuse = (NdotL*0.5 + 0.5) * lightCol * SHADOW_ATTENUATION(i);
//                    SHADOW_ATTENUATION
					// Speculer
				//	float3 specular = pow(max(0.0, dot(reflect(-L, N), V)), _Spec1Power) * _Spec1Color.xyz;  // reflection
					float3 specular = pow(max(0.0, dot(H, N)), _Spec1Power) * _Spec1Color.xyz * lightCol;  // Half vector

//                    return SHADOW_ATTENUATION(i);
					return float4( (ambient + diffuse) * tex + specular, 1.0);
				}
				ENDCG
			}


            
			Pass
				{
					Tags{
					"LightMode" = "ForwardAdd"
				}

				Cull Back
				Blend One One

				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"
				#include "Lighting.cginc"
				#include"AutoLight.cginc"

				struct appdata
				{
					float4 vertex : POSITION;
					float3 normal : NORMAL;
					float2 uv	  : TEXCOORD0;
				};

				struct v2f
				{
					float4 vertex : SV_POSITION;
					float4 vertexW: TEXCOORD0;
					float2 uv	  : TEXCOORD1;
					float3 normal : TEXCOORD2;
				};

				uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
				uniform float _Spec1Power;
				uniform float4 _Spec1Color;


				v2f vert(appdata v)
				{
					v2f o;
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.vertexW = mul(unity_ObjectToWorld, v.vertex);

					o.uv = TRANSFORM_TEX(v.uv, _MainTex);
					o.normal = UnityObjectToWorldNormal(v.normal);
					return o;
				}

				float4 frag(v2f i) : SV_Target
				{
					float3 L = normalize(_WorldSpaceLightPos0.xyz);
					float3 V = normalize(_WorldSpaceCameraPos - i.vertexW.xyz);
					float3 N = i.normal;
					float3 H = normalize(L + V);


					//LightColor
					float3 lightCol = _LightColor0.rgb * LIGHT_ATTENUATION(i);

					// texture albedo
					float4 tex = tex2D(_MainTex, i.uv);

					// Diffuse(HalfLambert)
					float3 NdotL = dot(N, L);
					float3 diffuse = (NdotL*0.5 + 0.5) * lightCol;

					// Speculer
					//	float3 specular = pow(max(0.0, dot(reflect(-L, N), V)), _Spec1Power) * _Spec1Color.xyz;  // reflection
					float3 specular = pow(max(0.0, dot(H, N)), _Spec1Power) *  _Spec1Color.xyz * lightCol;  // Half vector


					return float4( diffuse * tex + specular, 1.0 );
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



            #pragma shader_feature _ _ALPHATEST_ON _ALPHABLEND_ON _ALPHAPREMULTIPLY_ON
            #pragma shader_feature _METALLICGLOSSMAP
            #pragma shader_feature _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            #pragma skip_variants SHADOWS_SOFT
            #pragma multi_compile_shadowcaster

            //#include "UnityStandardShadow.cginc"


            struct VertexInput {
 //V2F_SHADOW_CASTER_NOPOS
                 float4 vertex : POSITION;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION ;
            };

            VertexOutput vertShadowCaster (VertexInput v) {

                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }

            float4 fragShadowCaster(VertexOutput i) : SV_TARGET {
           // SHADOW_CASTER_FRAGMENT(i)
                return 0;
            }


            ENDCG



        }


        }

        FallBack "Diffuse"
//            FallBack "Transparent/Cutout/Diffuse"


}
