using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class TestMenu : EditorWindow
{
    [MenuItem("Test/Menu %a")]
    public static void ShowMenu()
    {
        TestMenu window = (TestMenu)EditorWindow.GetWindow(typeof(TestMenu));
        window.Show();
    }

    string myString = "Hello World";
    bool groupEnabled;
    bool myBool = true;
    bool start = false;
    float myFloat = 1.23f; void OnGUI()
    {
        GUILayout.Label("Label", EditorStyles.boldLabel);
        myString = EditorGUILayout.TextField("Text Field", myString);

        groupEnabled = EditorGUILayout.BeginToggleGroup("Optional Settings", groupEnabled);
        myBool = EditorGUILayout.Toggle("Toggle", myBool);
        myFloat = EditorGUILayout.Slider("Slider", myFloat, -3, 3);
        EditorGUILayout.EndToggleGroup();


        if (GUILayout.Button("Start"))
        {
            Debug.Log("Start Push");
        }
    }

}
