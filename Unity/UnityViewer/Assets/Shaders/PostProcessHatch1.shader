Shader "PostProcess/Hatch1" {
    Properties {
        _MainTex("MainTex", 2D) = ""{}
        _HatchTex("HatchTex", 2D) = ""{}
    }

    SubShader {
        Pass {
            CGPROGRAM

            #include "UnityCG.cginc"

            #pragma vertex vert_img
            #pragma fragment frag

            sampler2D _MainTex;
            sampler2D _HatchTex;

            fixed4 frag(v2f_img i) : COLOR {
                fixed4 c = tex2D(_MainTex, i.uv);
                fixed4 h = tex2D(_HatchTex, i.uv);
  //              c = clamp(c*(h+1.0),0.0,1.0);
                c = c * lerp( 0.5, 1.3, h );
                return c;
            }

            ENDCG
        }
    }
}