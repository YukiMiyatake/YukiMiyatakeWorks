using UnityEngine;
using System;
using System.Collections;
using System.Runtime.InteropServices;

public class TestGUI : MonoBehaviour
{
    void Start()
    {
    }
    void OnGUI()
    {
        GUIStyle gs = new GUIStyle(GUI.skin.button);
        gs.fontSize = 38;

        if (GUI.Button(new Rect(50f, 50f, 150f, 80f), "Test", gs))
        {
            TestPlugin.Test();
        }
        if (GUI.Button(new Rect(250f, 50f, 150f, 80f), "Long", gs))
        {
            Debug.Log("UNITY Long Button Click");
            Debug.Log( TestPlugin.TestLong(1));
        }
        if (GUI.Button(new Rect(450f, 50f, 150f, 80f), "Float", gs))
        {
            Debug.Log(TestPlugin.TestFloat(1.2f));
        }

        if (GUI.Button(new Rect(50f, 150f, 150f, 80f), "String", gs))
        {
            Debug.Log(TestPlugin.TestString("Hoge"));
        }
        if (GUI.Button(new Rect(250f, 150f, 150f, 80f), "Str In", gs))
        {
            string v = "string in";
            Debug.Log(TestPlugin.TestStringIn(in v));
            Debug.Log(v);
        }
        if (GUI.Button(new Rect(450f, 150f, 150f, 80f), "Str out", gs))
        {
//            string v;
            Debug.Log(TestPlugin.TestStringOut(out string v));
            Debug.Log(v);
        }
        if (GUI.Button(new Rect(650f, 150f, 150f, 80f), "Str ref", gs))
        {
            string v="str ";
            Debug.Log(TestPlugin.TestStringRef(ref v));
            Debug.Log(v);
        }

        if (GUI.Button(new Rect(50f, 250f, 150f, 80f), "int array", gs))
        {
            int[] v = new int[] { 1,2,3 };
            int n = v.Length;
            TestPlugin.TestIntArray(v,n);
        }

        if (GUI.Button(new Rect(250f, 250f, 150f, 80f), "int ref", gs))
        {
            int[] v = new int[] { 4, 5, 6 };
            int n = v.Length;
            TestPlugin.TestIntArrayRef( v, ref n);

            Debug.LogFormat("C# num={0}", n);
            Debug.LogFormat("C#:: length={0}, val={1},{2},{3}", n, v[0], v[1], v[2]);
            Debug.LogFormat("C#:: length={0}, val={1},{2},{3},{4}", n, v[0], v[1], v[2], v[3]);
        }

        if (GUI.Button(new Rect(450f, 250f, 150f, 80f), "int ref2", gs))
        {
            int[] v = new int[] { 4, 5, 6 };
            int n = v.Length;

            IntPtr ptr = Marshal.AllocCoTaskMem(Marshal.SizeOf(typeof(int)) * n);
            Marshal.Copy(v, 0, ptr, n);


            TestPlugin.TestIntArrayRef2( ptr, ref n);

            var vv = new int[n];

            Marshal.Copy(ptr, vv, 0, n);

            Marshal.FreeCoTaskMem(ptr);

            Debug.LogFormat("C# num={0}", n);
            Debug.LogFormat("C#:: length={0}, val={1},{2},{3}", n, vv[0], vv[1], vv[2]);
            Debug.LogFormat("C#:: length={0}, val={1},{2},{3},{4}", n, vv[0], vv[1], vv[2], vv[3]);
        }

        if (GUI.Button(new Rect(50f, 350f, 150f, 80f), "ptr", gs))
        {
            GCHandle gchOrg = GCHandle.Alloc(new Rect(1f, 2f, 3f, 4f));
            IntPtr ptr = GCHandle.ToIntPtr(gchOrg);

            IntPtr h = TestPlugin.TestPointer(ptr);

            GCHandle gch = GCHandle.FromIntPtr(h);
            Rect rc = (Rect)gch.Target;
            Debug.LogFormat("RECT({0},{1},{2},{3})", rc.x, rc.y, rc.width, rc.height);
            gch.Free();
            gchOrg.Free();
        }

        if (GUI.Button(new Rect(250f, 350f, 150f, 80f), "ptr2 get", gs))
        {
            IntPtr ptr = TestPlugin.TestPointer2Get(1234);
            Debug.Log( TestPlugin.TestPointer2(ptr));
        }


        if (GUI.Button(new Rect(450f, 350f, 150f, 80f), "ptr2 get", gs))
        {
            CS_Rect rc0 = new CS_Rect();
            rc0.x = 1; rc0.y = 2; rc0.width = 3; rc0.height = 4;

            CS_Rect rc = TestPlugin.TestRect(rc0);
            Debug.LogFormat("RECT({0},{1},{2},{3})", rc.x, rc.y, rc.width, rc.height);
        }


    }
}