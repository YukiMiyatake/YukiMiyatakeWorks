using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using UnityEngine.UI;


public class Test : MonoBehaviour
{
    public DebugText text_;
    public ScreenScale screenScale_;
    public UnitychanScale unitychanScale_;
    public FrameTiming[] frameTimings_;

    private  double DOUBLE_EPSILON = 1e-10;

    void Start()
    {
        Application.targetFrameRate = 60;
        frameTimings_ = new FrameTiming[1];
    }

    // Update is called once per frame
    void Update()
    {
//        var frameTimings_ = new FrameTiming[1];

        FrameTimingManager.CaptureFrameTimings();
        uint numReturened = FrameTimingManager.GetLatestTimings(1, frameTimings_);




        //        _text.ft = frameTimings[0];

        if (numReturened > 0)
        {
            var ft = frameTimings_[0];
            text_.ft = ft;


            // GPU負荷をみて解像度を変更する
            // UNITY社サンプルでは FrameTimingManager.GetCpuTimerFrequency() が取れない端末がある
            // ネイティブプラグインなどからクロックをとれると思うが deltaTimeかcpuFrameTimeあたりと比較すれば良いかもしれない
            // 今はCPU負荷が高いので固定値にしている
            if (ft.gpuFrameTime > 0.2)
//            if (ft.gpuFrameTime/ft.cpuFrameTime > 0.5)
            {
                    ChangeResolution(ft.heightScale * 0.8f);
                //               _screenScale.Val *= 0.9f;
            }
            else
            {
                ChangeResolution(ft.heightScale * 1.2f);
                //      _screenScale.Val *= 1.1f;
            }

            /*
                        if (Math.Abs(ft.gpuFrameTime) > DOUBLE_EPSILON)
                        {

                            var diff = ft.cpuTimeFrameComplete - ft.cpuTimePresentCalled;
                            var latencyms = diff * 1000.0 / FrameTimingManager.GetCpuTimerFrequency();
                            double latencyFrames = latencyms / ft.gpuFrameTime;

                            Debug.Log( "cpuTime" + FrameTimingManager.GetCpuTimerFrequency() +  "    latencyms" + latencyms + "    gpuFrame=" + ft.gpuFrameTime + "    latency=" + latencyFrames);

                            if (latencyFrames > 2.0)
                            { // GPU Bound
                                _screenScale.value *= 0.9f;
                            }
                            if (latencyFrames < 1.0)
                            { // in
                                _screenScale.value *= 1.1f;
                            }
                        }
            */
        }

    }

    private void ChangeResolution( float val )
    {
        val = Mathf.Clamp(val, 0.01f, 1.0f);
        ScalableBufferManager.ResizeBuffers(val, val);
    }

}
