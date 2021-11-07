using System.Runtime.InteropServices;
using UnityEngine;

public static class SafariView
{
#if UNITY_IOS
    [DllImport ("__Internal")]
    extern static void launchUrl(string url);
#endif

    public static void LaunchURL(string url)
    {
#if UNITY_EDITOR
        Application.OpenURL(url);
#elif UNITY_IOS
        launchUrl(url);
#endif
    }
}
