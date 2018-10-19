using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ScreenScale : MonoBehaviour
{
    private Slider slider_;

    // Start is called before the first frame update
    void Start()
    {
        slider_ = GetComponent<Slider>();

        slider_.onValueChanged.AddListener(delegate { onValueChange(slider_.value); });
    }

    public void onValueChange(float val)
    {
//        var scale = slider_.value;
        ScalableBufferManager.ResizeBuffers( val, val );
    }

}
