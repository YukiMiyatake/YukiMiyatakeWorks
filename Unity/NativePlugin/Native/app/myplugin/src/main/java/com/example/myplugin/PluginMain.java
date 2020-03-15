package com.example.myplugin;

import com.unity3d.player.UnityPlayerActivity;

import android.util.Log;

public class PluginMain /*extends UnityPlayerActivity*/ {
    public static void test_static(){
        Log.i("PluginMain","test_static");
    }

    public void test_instance(){
        Log.i("PluginMain","test_instance");
    }
}
