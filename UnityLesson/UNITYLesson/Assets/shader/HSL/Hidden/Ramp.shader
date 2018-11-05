/*
HerritageShaderLibrary
Happy sugar life for you!
*/

Shader "Hidden/HSL/Ramp" {
			
	SubShader{
		Pass
		{
			Name "RAMP"
			Tags{ "LightMode" = "ForwardBase" }
			Cull Back
			Blend[_SrcBlend][_DstBlend]

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "AutoLight.cginc"
//			#include "Shaders/Include/HSL.cginc"
			#pragma multi_compile_fwdbase
			#pragma multi_compile _BLENDMODE_NONE _BLENDMODE_NORMAL _BLENDMODE_MULTIPLY _BLENDMODE_LINEARDODGE _BLENDMODE_SCREEN 
			#pragma multi_compile _ _USE_NORMALMAP
			#pragma multi_compile _ _USE_CLIP

			#pragma multi_compile _ _USE_HATCHING
			#pragma multi_compile _ _USE_RIM
			#pragma multi_compile _ _USE_RAMP
//#pragma multi_compile _ _USE_OUTLINE
//#pragma multi_compile _ _USE_VERTEX_OUTLINE
			#pragma multi_compile _ _USE_SPECULAR


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
#ifdef _USE_NORMALMAP
				float3 tangentDir : TEXCOORD4;
				float3 bitangentDir : TEXCOORD5;
#endif
			};


			struct v2f_in
			{
				UNITY_VPOS_TYPE vpos : VPOS;
				float4 vertexW: TEXCOORD0;
				float2 uv     : TEXCOORD1;
				float3 normalWorld : TEXCOORD2;
				SHADOW_COORDS(3)
#ifdef _USE_NORMALMAP
				float3 tangentDir : TEXCOORD4;
				float3 bitangentDir : TEXCOORD5;
#endif
			};

			uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
			uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;

			uniform sampler2D _RampTex; uniform float4 _RampTex_ST;
			uniform float _RampV;
			uniform float _ToonIntensity;
			uniform float4 _ToonColor;
			uniform float _ToonThreshold;

#ifdef _USE_HATCHING
			uniform sampler2D _ShadowTex; uniform float4 _ShadowTex_ST;
			uniform float _ShadowTexPower;
			uniform float _ShadowTexRepeatU;
			uniform float _ShadowTexRepeatV;
#endif 
			uniform float _ShadowPower;

#ifdef _USE_SPECULAR
			uniform float _SpecularIntensity;
			uniform float _Spec1Power;
			uniform float4 _Spec1Color;
#endif

#ifdef _USE_RIM
			uniform float _RimColorIntensity;
			uniform float3 _RimColor;
			uniform float _RimPower;
#endif

#ifdef _USE_CLIP
			uniform float _ClipThreshold;
#endif

			v2f vert(appdata_full v) {
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
				float4 tex = tex2D(_MainTex, i.uv);
#ifdef _USE_CLIP
				clip(tex.a - _ClipThreshold);
#endif
				float3 L = normalize(_WorldSpaceLightPos0.xyz);
				float3 V = normalize(_WorldSpaceCameraPos - i.vertexW.xyz);
				float3 H = normalize(L + V);

#ifdef _USE_NORMALMAP
				float3x3 tangentTransform = float3x3(i.tangentDir, i.bitangentDir, i.normalWorld);
				float3 _NormalMap_var = UnpackNormal(tex2D(_NormalMap, TRANSFORM_TEX(i.uv, _NormalMap)));
				float3 normalLocal = _NormalMap_var.rgb;
				float3 N = normalize(mul(normalLocal, tangentTransform));
#else
				float3 N = i.normalWorld;
#endif

				//LightColor
				float3 lightCol = _LightColor0.rgb * lerp((1 - _ShadowPower), 1.0,  LIGHT_ATTENUATION(i));
//				float3 lightCol = LIGHT_ATTENUATION(i);

				//Ambient
			//	float3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb;


				// Diffuse(HalfLambert)
				float3 NdotL = dot(N, L);
				float3 diffuse = (NdotL*0.5 + 0.5);
				
				// rim
#ifdef _USE_RIM
//				float rim = 1.0 - saturate(dot(L, N));
				float3 rimColor = pow(1.0 - dot(V,N), _RimPower) * _RimColor * _RimColorIntensity;
#else
				float3 rimColor = 0;
#endif



				// Speculer
#ifdef _USE_SPECULAR
				float3 specular = pow(max(0.0, dot(H, N)), _Spec1Power) * _Spec1Color.xyz * lightCol * _SpecularIntensity;  // Half vector
#else
				float3 specular = 0;
#endif


				// Hatching
#ifdef _USE_HATCHING
				i.vpos.xy /= _ScreenParams.xy;
				i.vpos.xy *= float2(_ShadowTexRepeatU, _ShadowTexRepeatV);
				float3 shadowTex = lerp(lerp(1 - _ShadowTexPower, 1.0, tex2D(_ShadowTex, i.vpos.xy)), 1.0, SHADOW_ATTENUATION(i)* diffuse);
#else
				float3 shadowTex = SHADOW_ATTENUATION(i);
#endif


				// Ramp
				float3 ramp = tex2D(_RampTex, float2(diffuse.x, _RampV));
				float3 ramp2 = (diffuse.x >= _ToonThreshold) ? float3(1.0, 1.0, 1.0) : _ToonColor.xyz;
				float3 ramp3 = ramp * ramp2;

				float3  albedo;
#ifdef _BLENDMODE_NONE
				albedo = tex;
#elif _BLENDMODE_NORMAL
				albedo = tex*(1 - _ToonIntensity) + ramp3 * _ToonIntensity;
#elif _BLENDMODE_MULTIPLY
				albedo = lerp( tex, tex * ramp3, _ToonIntensity);
#elif _BLENDMODE_LINEARDODGE
				albedo = tex + ramp * ramp2 * _ToonIntensity;
#elif _BLENDMODE_SCREEN
				albedo = lerp(tex, tex + ramp3 - (tex*ramp3), _ToonIntensity);
#else
				albedo = tex*(1 - _ToonIntensity) + ramp3 * _ToonIntensity;
#endif

				return float4(saturate(/* ambient* */ albedo * shadowTex * lightCol +  rimColor + specular), 1.0);
			}
			ENDCG

		}
	}
}
