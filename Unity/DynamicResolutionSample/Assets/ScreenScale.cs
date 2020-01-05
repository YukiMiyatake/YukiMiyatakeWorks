using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ScreenScale : MonoBehaviour
{
    private Slider slider_;

    public float Val
    {
        set => slider_.value = Mathf.Clamp(value, 0.01f, 1.0f);
        get => slider_.value;
    }


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