using UnityEngine;

public class SampleWebView : MonoBehaviour
{
    public string url = "http://www.google.com/";
    WebViewObject webViewObject;

    void Start()
    {
        webViewObject =
            (new GameObject("WebViewObject")).AddComponent<WebViewObject>();
        webViewObject.Init((msg) => {
            if (msg == "clicked")
            {
                webViewObject.SetVisibility(false);
            }
        });

        webViewObject.LoadURL(url);
        webViewObject.SetMargins(50, 100, 50, 50);
        webViewObject.SetVisibility(true);

        webViewObject.EvaluateJS(
            "window.addEventListener('load', function() {" +
            "	window.addEventListener('click', function() {" +
            "		Unity.call('clicked');" +
            "	}, false);" +
            "}, false);");

    }

    
    void OnGUI()
    {
        Rect textArea = new Rect(100, 0, 400, 100);
        url = GUI.TextArea(textArea, url);

        if (GUI.Button(new Rect(500, 0, 100, 100), "GO"))
        {
            webViewObject.LoadURL(url);
            webViewObject.SetVisibility(true);
        }
    }
    
}
