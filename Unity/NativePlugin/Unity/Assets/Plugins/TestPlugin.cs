using UnityEngine;
using System;
using System.Runtime.InteropServices;

[StructLayout(LayoutKind.Sequential)]
public class CS_Rect{
    public float x;
    public float y;
    public float width;
    public float height;
};


public class TestPlugin : MonoBehaviour
{

#if UNITY_ANDROID
    [DllImport("myplugin")]
    public static extern void TestNative();

    const string ANDROID_NATIVE_PLUGIN_CLASS = "com.example.myplugin";


    public static void TestStatic()
    {
        using (AndroidJavaClass cls = new AndroidJavaClass(ANDROID_NATIVE_PLUGIN_CLASS))
        {
            cls.CallStatic("test_static");
        }

        Debug.Log("TestStatic");
    }
    public static void TestInstance()
    {
        using (AndroidJavaObject obj = new AndroidJavaObject(ANDROID_NATIVE_PLUGIN_CLASS))
        {
            obj.Call("test_instance");
        }

        Debug.Log("TestInstance");
    }

    public static void Test()
    {
        Debug.Log("Test");
    }
    public static long TestLong(long v)

    {
        Debug.Log("Long");
        return v;
    }
    public static float TestFloat(float v)
    {
        Debug.Log("Float");
        return v;
    }
    public static void TestString0(string v)
    {
        Debug.Log("String0");
    }
    public static string TestString(string v)
    {
        Debug.Log("String");
        return v;
    }
    public static string TestStringIn(in string v)
    {
        Debug.Log("StringIn");
        return v;
    }
    public static string TestStringOut(out string v)
    {
        Debug.Log("StringOut");
        v = "new string";
        return v;
    }
    public static string TestStringRef(ref string v)
    {
        Debug.Log("StringRef");
        return v + "Ref";
    }

    public static void TestIntArray(int[] hoge, int num)
    {
        Debug.Log("IntArray");
    }
    public static void TestIntArrayRef([In, Out] int[] hoge, ref int num)
    {
        Debug.Log("IntArrayRef");
    }
    public static void TestIntArrayRef2([In, Out] IntPtr hoge, ref int num)
    {
        Debug.Log("IntArrayRef2");
    }

    public static IntPtr TestPointer(IntPtr ptr)
    {
        return (ptr);
    }
    public static IntPtr TestPointer2Get(int n)
    {
        return IntPtr.Zero;
    }
    public static int TestPointer2(IntPtr v)
    {
        return (2);
    }

    public static CS_Rect TestRect(CS_Rect v)
    {
        return (v);
    }
    //#endif

#elif UNITY_IOS
    [DllImport("__Internal")]
    private static extern void test_();
    [DllImport("__Internal")]
    private static extern long test_long_(long v);
    [DllImport("__Internal")]
    private static extern float test_float_(float v);

    [DllImport("__Internal")]
    private static extern string test_string_(string v);
    [DllImport("__Internal")]
    private static extern void test_string0_(string v);
    [DllImport("__Internal")]
    private static extern string test_string_in_(in string v);
    [DllImport("__Internal")]
    private static extern string test_string_out_(out string v);
    [DllImport("__Internal")]
    private static extern string test_string_ref_(ref string v);
    [DllImport("__Internal")]
    private static extern void test_intarray_(int[] hoge, int num);
    [DllImport("__Internal")]
    private static extern void test_intarray_ref_([In,Out] int[] hoge, ref int num);
    [DllImport("__Internal")]
    private static extern void test_intarray_ref2_([In,Out] IntPtr hoge, ref int num);
    [DllImport("__Internal")]
    private static extern IntPtr test_pointer_(IntPtr ptr);
    [DllImport("__Internal")]
    private static extern IntPtr test_pointer2_get_(int n);
    [DllImport("__Internal")]
    private static extern int test_pointer2_(IntPtr v);
    [DllImport("__Internal")]
    private static extern CS_Rect test_rect_(CS_Rect v);

    public static void Test()
    {
        test_();
    }
    public static long TestLong(long v)
    {
        Debug.Log("UNITY TestLong");
        return test_long_(v);
    }

    public static float TestFloat(float v)
    {
        return test_float_(v);
    }

    public static void TestString0(string v)
    {
        test_string0_(v);
    }
    public static string TestString( string v)
    {
        return test_string_(v);
    }
    public static string TestStringIn(in string v)
    {
        return test_string_in_(v);
    }
    public static string TestStringOut(out string v)
    {
        return test_string_out_(out v);
    }
    public static string TestStringRef(ref string v)
    {
        return test_string_ref_(ref v);
    }


    public static void TestIntArray(int[] v, int num)
    {
        test_intarray_(v, num);
    }
    public static void TestIntArrayRef([In, Out] int[] v, ref int num)
    {
        test_intarray_ref_( v, ref num);
    }
    public static void TestIntArrayRef2([In, Out] IntPtr v, ref int num)
    {
        test_intarray_ref2_( v, ref num);
    }
    public static IntPtr TestPointer(IntPtr ptr)
    {
        return(test_pointer_(ptr));
    }

    public static IntPtr TestPointer2Get(int n)
    {
        return(test_pointer2_get_(n));
    }
    public static int TestPointer2(IntPtr v)
    {
        return (test_pointer2_(v));
    }

    public static CS_Rect TestRect(CS_Rect v)
    {
        return (test_rect_(v));
    }

#else
    public static void Test()
    {
        Debug.Log("Test");
    }
    public static long TestLong(long v)

    {
        Debug.Log("Long");
        return v;
    }
    public static float TestFloat(float v)
    {
        Debug.Log("Float");
        return v;
    }
    public static void TestString0(string v)
    {
        Debug.Log("String0");
    }
    public static string TestString(string v)
    {
        Debug.Log("String");
        return v;
    }
    public static string TestStringIn(in string v)
    {
        Debug.Log("StringIn");
        return v;
    }
    public static string TestStringOut(out string v)
    {
        Debug.Log("StringOut");
        v = "new string";
        return v;
    }
    public static string TestStringRef(ref string v)
    {
        Debug.Log("StringRef");
        return v + "Ref";
    }

    public static void TestIntArray(int[] hoge, int num)
    {
        Debug.Log("IntArray");
    }
    public static void TestIntArrayRef([In, Out] int[] hoge, ref int num)
    {
        Debug.Log("IntArrayRef");
    }
    public static void TestIntArrayRef2([In, Out] IntPtr hoge, ref int num)
    {
        Debug.Log("IntArrayRef2");
    }

    public static IntPtr TestPointer(IntPtr ptr)
    {
        return (ptr);
    }
    public static IntPtr TestPointer2Get(int n)
    {
        return IntPtr.Zero;
    }
    public static int TestPointer2(IntPtr v)
    {
        return (2);
    }

    public static CS_Rect TestRect(CS_Rect v)
    {
        return (v);
    }
#endif


}

