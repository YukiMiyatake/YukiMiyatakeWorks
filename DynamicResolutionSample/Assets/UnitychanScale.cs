using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System;


public class UnitychanScale : MonoBehaviour
{
    public GameObject model_;
    private GameObject[] models_;

 //   int modelCount_;
    private Slider slider_;

    // Start is called before the first frame update
    void Start()
    {

        slider_ = GetComponent<Slider>();
        models_ = new GameObject[1];

        slider_.onValueChanged.AddListener(delegate { onValueChange(slider_.value); });
    }

    public void onValueChange(float val)
    {
        int newVal = (int)val;
        int oldVal = models_.Length;

        if ( newVal < oldVal ){
            for (int n = newVal; n < oldVal; n++){
                Destroy(models_[n]);
            }
        }

        Array.Resize(ref models_, newVal);

        if(newVal > oldVal)
        {
            for (int n = oldVal; n < newVal; n++)
            {
                models_[n] = Instantiate(model_, getPos(n), Quaternion.identity);
            }

        }

    }

    Vector3 getPos(int n){
        Vector3 pos;
        const int RAW = 16;
        pos.x = n % RAW * 0.2f * ((n%2 == 0)?1.0f:-1.0f);
        pos.z = n/RAW * 2.0f;

        return (new Vector3(pos.x, 0.0f, pos.z));
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
