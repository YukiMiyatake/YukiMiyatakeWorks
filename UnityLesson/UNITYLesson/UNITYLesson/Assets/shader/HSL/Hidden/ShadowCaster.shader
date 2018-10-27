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
			#pragma multi_compile_shadowcaster


			struct v2f {
				V2F_SHADOW_CASTER;
			};

			v2f vertShadowCaster(appdata_base v) {
				v2f o = (v2f)0;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
					return o;
			}

			float4 fragShadowCaster(v2f i) : SV_TARGET{
				SHADOW_CASTER_FRAGMENT(i)
			}


			ENDCG


		}
	}
}
