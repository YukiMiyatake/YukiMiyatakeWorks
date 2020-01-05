using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;

public class PP_HatchShadow : MonoBehaviour {
    
    public Material mat;


    private RenderTexture camTarget;
    private RenderTexture[] buf = new RenderTexture[8];
    private RenderTexture depth;



    private Camera cam;
    private const CameraEvent EVENT_TIMING = CameraEvent.BeforeImageEffectsOpaque;
  //  private CommandBuffer cmd;

    private void Awake()
    {
        cam = GetComponent<Camera>();
        cam.depthTextureMode = DepthTextureMode.Depth;

        for (int i = 0; i < 8; i++){
            buf[i] = new RenderTexture(Screen.width, Screen.height, 0);
            buf[i].Create();
        }

        // 深度バッファを生成
     //   depth = new RenderTexture(Screen.width, Screen.height, 24, RenderTextureFormat.Depth);
   //     depth.Create();

      //  Shader.SetGlobalTexture("_MainTex", buf[0]);



    //    cmd = new CommandBuffer();

  //      RenderTargetIdentifier tar = new RenderTargetIdentifier(camTarget);

///        customImgEff.name = "CunstomImageEffect";
//        customImgEff.Blit(tar, tar, cmd);

//        cam.AddCommandBuffer(EVENT_TIMING, customImgEff);
/*
        mat.SetTexture("_MainTex", buf[0]);
        mat.SetTexture("_RT1", buf[1]);
        mat.SetTexture("_RT2", buf[2]);

        cam.SetTargetBuffers(new RenderBuffer[8] { 
            buf[0].colorBuffer, buf[1].colorBuffer
            , buf[2].colorBuffer, buf[3].colorBuffer
            , buf[4].colorBuffer, buf[5].colorBuffer
            , buf[6].colorBuffer, buf[7].colorBuffer
            }, buf[0].depthBuffer);
*/






        CommandBuffer cmd = new CommandBuffer();
      //  RenderTargetIdentifier[] ids = new RenderTargetIdentifier[2] { buf1, buf2 };
       // RenderTargetIdentifier tar = new RenderTargetIdentifier(camTarget);

       // RenderTargetIdentifier[] ids = new RenderTargetIdentifier[8] { buf[0], buf[1], buf[2], buf[3], buf[4], buf[5], buf[6], buf[7] };
//         RenderTargetIdentifier tar = new RenderTargetIdentifier(camTarget);
        RenderTargetIdentifier tar = new RenderTargetIdentifier(BuiltinRenderTextureType.CurrentActive);

        /*
        cam.SetTargetBuffers(new RenderBuffer[8] {
            buf[0].colorBuffer, buf[1].colorBuffer
            , buf[2].colorBuffer, buf[3].colorBuffer
            , buf[4].colorBuffer, buf[5].colorBuffer
            , buf[6].colorBuffer, buf[7].colorBuffer
            }, buf[0].depthBuffer);


//        cam.SetTargetBuffers(new RenderBuffer[2] { buf1.colorBuffer, buf2.colorBuffer }, buf1.depthBuffer);
//int tmp = Shader.PropertyToID("_PostEffectTempTexture");
//cmd.GetTemporaryRT(tmp, -1, -1);

        mat.SetTexture("_MainTex", buf[0]);
        mat.SetTexture("_RT1", buf[1]);
        mat.SetTexture("_RT2", buf[2]);
        mat.SetTexture("_RT3", buf[3]);

        cmd.name = "PPHatchingShadow";
       // cmd.Blit(tar, tmp);
        cmd.Blit(tar, tar, mat);

//        cmd.Blit(BuiltinRenderTextureType.CurrentActive, tar, mat);
//cmd.ReleaseTemporaryRT(tmp);

        cam.AddCommandBuffer(CameraEvent.BeforeImageEffects, cmd);
*/

        // 一時テクスチャを解放
      //  cmd.ReleaseTemporaryRT(tar);

    //    cam.AddCommandBuffer(CameraEvent.AfterEverything, cmd);

    }
    void OnPreRender(){

        cam.SetTargetBuffers(new RenderBuffer[8] {
            buf[0].colorBuffer, buf[1].colorBuffer
            , buf[2].colorBuffer, buf[3].colorBuffer
            , buf[4].colorBuffer, buf[5].colorBuffer
            , buf[6].colorBuffer, buf[7].colorBuffer
            }, buf[0].depthBuffer);


        mat.SetTexture("_MainTex", buf[0]);
        mat.SetTexture("_RT1", buf[1]);
        mat.SetTexture("_RT2", buf[2]);
        mat.SetTexture("_RT3", buf[3]);


    }

    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
    //    RenderTargetIdentifier tar = new RenderTargetIdentifier(BuiltinRenderTextureType.CurrentActive);

        Graphics.Blit(src, dest, mat);
    }

    void OnPostRender()
    {
        // RenderTarget無し：画面に出力される
        Graphics.SetRenderTarget(null);
        GL.Clear(true, true, new Color(0, 0, 0, 0));
//        Graphics.Blit(buf, mat, 0);
    }
}


