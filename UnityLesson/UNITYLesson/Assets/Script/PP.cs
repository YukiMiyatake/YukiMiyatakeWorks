using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PP : MonoBehaviour {

    public Material mat;


//    private RenderTexture camTarget;
//    private RenderTexture[] buf = new RenderTexture[8];
//    private RenderTexture depth;

    //    public RenderTexture camTarget;

 //   private Camera cam;
 //   private const CameraEvent EVENT_TIMING = CameraEvent.BeforeImageEffectsOpaque;
//    private CommandBuffer cmd;
    /*
    private void Awake()
    {
        cam = GetComponent<Camera>();
        cam.depthTextureMode = DepthTextureMode.Depth;

        for (int i = 0; i < 8; i++)
        {
            buf[i] = new RenderTexture(Screen.width, Screen.height, 0);
            buf[i].Create();
        }

        // 深度バッファを生成
        depth = new RenderTexture(Screen.width, Screen.height, 24, RenderTextureFormat.Depth);
        depth.Create();

        //  Shader.SetGlobalTexture("_MainTex", buf[0]);



        //    cmd = new CommandBuffer();

        //      RenderTargetIdentifier tar = new RenderTargetIdentifier(camTarget);
        mat.SetTexture("_MainTex", buf[0]);
        mat.SetTexture("_RT1", buf[1]);

        ///        customImgEff.name = "CunstomImageEffect";
        //        customImgEff.Blit(tar, tar, cmd);

        //        cam.AddCommandBuffer(EVENT_TIMING, customImgEff);
        cam.SetTargetBuffers(new RenderBuffer[8] {
            buf[0].colorBuffer, buf[1].colorBuffer
            , buf[2].colorBuffer, buf[3].colorBuffer
            , buf[4].colorBuffer, buf[5].colorBuffer
            , buf[6].colorBuffer, buf[7].colorBuffer
            }, buf[0].depthBuffer);
    }
    */
    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        Graphics.Blit(src, dest, mat);
    }

    /*
    void OnPostRender()
    {
        // RenderTarget無し：画面に出力される
        Graphics.SetRenderTarget(null);

    }
*/


}
