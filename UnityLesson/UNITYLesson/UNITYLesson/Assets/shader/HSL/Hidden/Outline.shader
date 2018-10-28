/*
HerritageShaderLibrary
Happy sugar life for you!
*/

Shader "Hidden/HSL/Outline" {
			
	SubShader{
		Pass
		{
			Tags{ "Queue" = "Geometry" "RenderType" = "Opaque" }
			Name "OUTLINE"

			Lighting Off
			Cull Front
			ZWrite On
			ColorMask RGB

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile _ _USE_VERTEX_OUTLINE

			#include "UnityCG.cginc"


			uniform float _OutlineWidth;
			uniform float4 _OutlineColor;


			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float2 texcoord	  : TEXCOORD0;
#ifdef _USE_VERTEX_OUTLINE
				fixed4 outline : COLOR0;
#endif
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				fixed4 outlineColor : COLOR;
			};


			v2f vert(appdata v)
			{
				v2f o;
				//UNITY_INITIALIZE_OUTPUT(v2f,o);
				float3 norm = normalize(mul((float3x3)UNITY_MATRIX_IT_MV, v.normal));
				float2 offset = TransformViewToProjection(norm.xy);


				o.pos = UnityObjectToClipPos(v.vertex);

#ifdef _USE_VERTEX_OUTLINE
				o.pos.xy += offset i.outline * _OutlineWidth* 0.001;
				o.outlineColor = _OutlineColor;
#else
				o.pos.xy += offset  * _OutlineWidth * 0.001;
				o.outlineColor = _OutlineColor;
#endif
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				return i.outlineColor;
			}

			ENDCG
		}
	}
}
