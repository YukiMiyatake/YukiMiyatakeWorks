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
#if UNITY_EDITOR
    private static void test_()
    {
        Debug.Log("Test");
    }
    private static long test_long_(long v)
    {
        Debug.Log("Long");
        return v;
    }
    private static float test_float_(float v)
    {
        Debug.Log("Float");
        return v;
    }
    private static void test_string0_(string v)
    {
        Debug.Log("String0");
    }
    private static string test_string_(string v)
    {
        Debug.Log("String");
        return v;
    }
    private static string test_string_in_(in string v)
    {
        Debug.Log("StringIn");
        return v;
    }
    private static string test_string_out_(out string v)
    {
        Debug.Log("StringOut");
        v = "new string";
        return v;
    }
    private static string test_string_ref_(ref string v)
    {
        Debug.Log("StringRef");
        return v+"Ref";
    }

    private static void test_intarray_(int[] hoge, int num)
    {
        Debug.Log("IntArray");
    }
    private static void test_intarray_ref_([In,Out] int[] hoge, ref int num)
    {
        Debug.Log("IntArrayRef");
    }
    private static void test_intarray_ref2_([In, Out] IntPtr hoge, ref int num)
    {
        Debug.Log("IntArrayRef2");
    }

    private static IntPtr test_pointer_(IntPtr ptr)
    {
        return (ptr);
    }
    private static IntPtr test_pointer2_get_(int n)
    {
        return IntPtr.Zero;
    }
    private static int test_pointer2_(IntPtr v)
    {
        return (2);
    }

    private static CS_Rect test_rect_(CS_Rect v)
    {
        return (v);
    }

#elif UNITY_IPHONE
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

#else
    [DllImport("TestPlugin")]
    private static extern void test_();
    [DllImport("TestPlugin")]
    private static extern long test_long_(long v);
    [DllImport("TestPlugin")]
    private static extern float test_float_(float v);
    [DllImport("TestPlugin")]
    private static extern string test_string_(string v);
#endif

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
}

