/*
HerritageShaderLibrary
Happy sugar life for you!
*/

Shader "Hidden/HSL/ShadowCaster" {
			
	SubShader{
		Pass
		{
			Name "SHADOW_CASTER"
			Tags{ "LightMode" = "ShadowCaster" }

			Lighting Off
			ColorMask RGB
			Fog{ Mode Off }

			Offset 1, 1
			Cull Off

			ZWrite On ZTest LEqual

			CGPROGRAM
			#pragma target 3.0


			#pragma vertex vertShadowCaster
			#pragma fragment fragShadowCaster


			#include "UnityCG.cginc"

#ifdef _USE_CLIP
			uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
			uniform float _ClipThreshold;
#endif

			#pragma multi_compile_shadowcaster


			struct v2f {
				V2F_SHADOW_CASTER;
#ifdef _USE_CLIP
				float2 uv	  : TEXCOORD;
#endif
			};

			v2f vertShadowCaster(appdata_base v) {
				v2f o = (v2f)0;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
#ifdef _USE_CLIP
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
#endif
				return o;
			}

			float4 fragShadowCaster(v2f i) : SV_TARGET{
#ifdef _USE_CLIP
				float4 tex = tex2D(_MainTex, i.uv);
				clip(tex.a - _ClipThreshold);
#endif
				SHADOW_CASTER_FRAGMENT(i)
			}


			ENDCG


		}
	}
}
