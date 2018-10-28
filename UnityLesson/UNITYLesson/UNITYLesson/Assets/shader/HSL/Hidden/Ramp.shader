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

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "AutoLight.cginc"
//			#include "Shaders/Include/HSL.cginc"
			#pragma multi_compile_fwdbase
			#pragma multi_compile _BLENDMODE_NORMAL _BLENDMODE_MULTIPLY _BLENDMODE_LINEARDODGE _BLENDMODE_SCREEN 
			#pragma multi_compile _ _USE_NORMALMAP
			#pragma multi_compile _ _USE_CLIP


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
			uniform float _ToonPower;
			uniform float4 _ToonColor;
			uniform float _ToonThreshold;

			uniform sampler2D _ShadowTex; uniform float4 _ShadowTex_ST;
			uniform float _ShadowPower;
			uniform float _ShadowTexPower;
			uniform float _Spec1Power;
			uniform float4 _Spec1Color;

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



				float3 ramp = tex2D(_RampTex, float2(diffuse.x, _RampV));
				float3 ramp2 = (diffuse.x >= _ToonThreshold) ? float3(1.0, 1.0, 1.0) : _ToonColor.xyz;


				// Speculer
				float3 specular = pow(max(0.0, dot(H, N)), _Spec1Power) * _Spec1Color.xyz * lightCol;  // Half vector

				i.vpos.xy /= _ScreenParams.xy;

				float3 shadowTex = lerp(lerp(1 - _ShadowTexPower, 1.0, tex2D(_ShadowTex, i.vpos.xy)), 1.0, SHADOW_ATTENUATION(i)* diffuse);

				float3  albedo;
				float3 ramp3 = ramp * ramp2;
#ifdef _BLENDMODE_NORMAL
				albedo = tex*(1 - _ToonPower) + ramp3 * _ToonPower;
#elif _BLENDMODE_MULTIPLY
				albedo = lerp( tex, tex * ramp3, _ToonPower);
#elif _BLENDMODE_LINEARDODGE
				albedo = tex + ramp * ramp2 * _ToonPower;
#elif _BLENDMODE_SCREEN
				albedo = lerp(tex, tex + ramp3 - (tex*ramp3), _ToonPower);
#else
				albedo = tex*(1 - _ToonPower) + ramp3 * _ToonPower;
#endif
				return float4(saturate(/* ambient* */ albedo * shadowTex + specular), 1.0);
			}
			ENDCG

		}
	}
}
