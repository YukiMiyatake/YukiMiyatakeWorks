using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Text;
using UnityEngine.UI;

public class DebugText : MonoBehaviour
{
    private Text text_;
    public FrameTiming ft;

    // Start is called before the first frame update
    void Start()
    {
        text_ = GetComponent<Text>();
 //       frameTimings = new FrameTiming[2];

    }

// Update is called once per frame
void Update()
    {
/*
        var frameTimings = new FrameTiming[2];
        FrameTimingManager.CaptureFrameTimings();
        uint numReturened = FrameTimingManager.GetLatestTimings(2, frameTimings);
        var ft = frameTimings[1];
*/
        text_.text = string.Format(  "FPS {9}\n"
                                   + "Screen  Width:{0,-4} Height:{1,-4}\n" 
                                   + "cpuFrameTime  {2:F8}\n"
                                   + "gpuFrameTime  {3}\n"
                                   + "cpuTiminePresentCalled  {4}\n"
                                   + "cpuTimeFrameComplete  {5}\n"
                                   + "heightScale  {6}\n"
                                   + "widthScale  {7}\n"
                                   + "syncInterval  {8}\n"
                                   , Screen.width, Screen.height
                                   , ft.cpuFrameTime, ft.gpuFrameTime, ft.cpuTimePresentCalled, ft.cpuTimeFrameComplete
                                   , ft.heightScale, ft.widthScale, ft.syncInterval
                                   , 1f / Time.deltaTime
                                   );


    }
}
