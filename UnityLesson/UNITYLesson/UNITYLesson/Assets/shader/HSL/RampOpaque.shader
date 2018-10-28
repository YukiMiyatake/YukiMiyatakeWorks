/*
  HerritageShaderLibrary
  Happy sugar life for you!
*/

Shader "HSL/RampOpaque"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		[Toggle(_USE_NORMALMAP)] _useNormalMap("UseNormalMap", Float) = 0
		_NormalMap("NormalMap", 2D) = "bump" {}

		[Header(Toon )]
		[KeywordEnum(Normal, Multiply, LinearDodge,Screen)] _BlendMode("Blend Mode", Float) = 0
		_RampTex ("RampTexture", 2D) = "white" {}
		_RampV("Ramp V", Range(0.0, 1.0)) = 0.5
			_ToonPower("ToonPower", Range(0.0, 1.0)) = 0.5
		_ToonColor("ToonColor", Color) = (0.0, 0.0, 0.0, 0.0)
		_ToonThreshold("ToonThreshold", Range(0.0,1.0)) = 0.0

		[Header(Hatching Shadow)]
		_ShadowPower ("ShadowPower", Range(0.0, 1.0)) = 0.5
        _ShadowTex ("ShadowTexture", 2D) = "white" {}
        _ShadowTexPower ("ShadowTexPower", Range(0.0, 1.0)) = 0.5
		
		[Header(Specular)]
		_Spec1Power("Specular Power", Range(0, 30)) = 1
		_Spec1Color("Specular Color", Color) = (0.5,0.5,0.5,1)

		[Header(Outline)]
		[Toggle(_USE_VERTEX_OUTLINE)] _useVertexOutline("頂点カラーのAをアウトライン太さにする", Float) = 0
		_OutlineWidth("Outline Width", Range(0.2, 10.0)) = 1
		_OutlineColor("Outline Color", Color) = (0.0, 0.0, 0.0, 1.0)

		[Header(Clip)]
		[Toggle(_USE_CLIP)] _useClip("テクスチャのAでクリップ", Float) = 0
		_ClipThreshold("ClipThreshold", Range(0.0,1.1)) = 0.05
	}

	SubShader{
		Tags{ "Queue" = "Geometry" "RenderType" = "Opaque" }


		UsePass "Hidden/HSL/Ramp/RAMP"
		UsePass "Hidden/HSL/ShadowCaster/SHADOW_CASTER"
		UsePass "Hidden/HSL/Outline/OUTLINE"

    }
    FallBack "Diffuse"

}
