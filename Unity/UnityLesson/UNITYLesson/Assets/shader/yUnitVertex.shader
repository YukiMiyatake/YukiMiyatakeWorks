Shader "Unlit/yUnitVertex"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
	_Spec1Power("Specular Power", Range(0, 30)) = 1
		_Spec1Color("Specular Color", Color) = (0.5,0.5,0.5,1)
	}
		SubShader
	{
		Tags{ "RenderType" = "Opaque" }

		Pass
	{
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

	float3 frag(v2f i) : SV_Target
	{
		float3 L = normalize(_WorldSpaceLightPos0.xyz);
		float3 V = normalize(_WorldSpaceCameraPos - i.vertexW.xyz);
		float3 N = i.normal;
		float3 H = normalize(L + V);


		//LightColor
		float3 lightCol = _LightColor0.rgb * LIGHT_ATTENUATION(i);

		//Ambient
		float3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb;

		// texture albedo
		float4 tex = tex2D(_MainTex, i.uv);

		// Diffuse(HalfLambert)
		float3 NdotL = dot(N, L);
		float3 diffuse = (NdotL*0.5 + 0.5) * lightCol;

		// Speculer
		//	float3 specular = pow(max(0.0, dot(reflect(-L, N), V)), _Spec1Power) * _Spec1Color.xyz;  // reflection
		float3 specular = pow(max(0.0, dot(H, N)), _Spec1Power) * _Spec1Color.xyz * lightCol;  // Half vector


		return (ambient + diffuse) * tex + specular;
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
		float2 uv	  : TEXCOORD1;

		float3 diffuse : TEXCOORD2;
		float3 specular : TEXCOORD3;
	};

	uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
	uniform float _Spec1Power;
	uniform float4 _Spec1Color;


	v2f vert(appdata v)
	{
		v2f o;
		o.vertex = UnityObjectToClipPos(v.vertex);
		float4 vertexW = mul(unity_ObjectToWorld, v.vertex);

		o.uv = TRANSFORM_TEX(v.uv, _MainTex);
		float3 normal = UnityObjectToWorldNormal(v.normal);


		float3 L = normalize(_WorldSpaceLightPos0.xyz);
		float3 V = normalize(_WorldSpaceCameraPos - vertexW.xyz);
		float3 N = normal;
		float3 H = normalize(L + V);
		float3 lightCol = _LightColor0.rgb * LIGHT_ATTENUATION(i);
		float3 NdotL = dot(N, L);

		o.diffuse = (NdotL*0.5 + 0.5) * lightCol;
		o.specular = pow(max(0.0, dot(H, N)), _Spec1Power) *  _Spec1Color.xyz * lightCol;  // Half vector

		return o;
	}

	float3 frag(v2f i) : SV_Target
	{

		// texture albedo
		float4 tex = tex2D(_MainTex, i.uv);

		return i.diffuse * tex + i.specular;
	}
		ENDCG
	}
	}
}
