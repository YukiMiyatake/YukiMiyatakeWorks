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


		UsePass "Hidden/HSL/Ramp/RAMP"
		UsePass "Hidden/HSL/ShadowCaster/SHADOW_CASTER"
		UsePass "Hidden/HSL/Outline/OUTLINE"

    }
    FallBack "Diffuse"

}
