using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Text;
using UnityEngine.UI;

public class DebugText : MonoBehaviour
{
    private Text text_;

    // Start is called before the first frame update
    void Start()
    {
        text_ = GetComponent<Text>();

    }

// Update is called once per frame
void Update()
    {
        var frameTimings = new FrameTiming[1];
        FrameTimingManager.CaptureFrameTimings();
        uint numReturened = FrameTimingManager.GetLatestTimings(1, frameTimings);
        var ft = frameTimings[0];

        text_.text = string.Format(  "Screen  Width:{0,-4} Height:{1,-4}\n" 
                                   + "cpuFrameTime  {2}\n"
                                   + "gpuFrameTime  {3}\n"
                                   + "cpuTiminePresentCalled  {4}\n"
                                   + "cpuTimeFrameComplete  {5}\n"
                                   + "heightScale  {6}\n"
                                   + "widthScale  {7}\n"
                                   + "syncInterval  {8}\n"
                                   , Screen.width, Screen.height
                                   , ft.cpuFrameTime, ft.gpuFrameTime, ft.cpuTimePresentCalled, ft.cpuTimeFrameComplete
                                   , ft.heightScale, ft.widthScale, ft.syncInterval);


    }
}
