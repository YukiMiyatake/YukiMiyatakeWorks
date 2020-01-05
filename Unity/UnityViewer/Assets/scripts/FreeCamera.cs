using UnityEngine;

/// <summary>
/// GameビューにてSceneビューのようなカメラの動きをマウス操作によって実現する
/// </summary>
[RequireComponent(typeof(Camera))]
public class FreeCamera : MonoBehaviour
{
    [SerializeField]
    private Transform freeCameraTarget = null;

    [SerializeField, Range(0.1f, 10f)]
    private float wheelSpeed = 1f;

    [SerializeField, Range(0.1f, 10f)]
    private float moveSpeed = 0.3f;

    [SerializeField, Range(0.1f, 10f)]
    private float rotateSpeed = 0.3f;

 //   [SerializeField]
//    private DebugModelViewer modelViewer = null;

    [SerializeField]
    private Camera targetCamera = null;

    private Transform targetObjectTransform = null;

    //private Camera myCamera = null;

    private bool isFirstSet = false;

    private Vector3 preMousePos;

    private const float MOUSE_WHEEL_MOVE_SENSITIVITY = 0.001f;

    private const float WLEEL_DISTANCE_MIN = 1.0f;

    private void Awake()
    {
        if (freeCameraTarget == null)
        {
            GameObject createCameraTargetObject = new GameObject("Create CameraTargetObject");
            freeCameraTarget = createCameraTargetObject.transform;
            freeCameraTarget.transform.position = Vector3.zero;
        }
        //myCamera = GetComponent<Camera>();
        isFirstSet = false;
    }

    private void Update()
    {
        if (!freeCameraTarget) return;

        MouseUpdate();
        return;
    }

    private void MouseUpdate()
    {
        // Altキー + α
        if (Input.GetKey(KeyCode.LeftAlt) || Input.GetKey(KeyCode.RightAlt))
        {
            if (Input.GetMouseButtonDown(0) ||
            Input.GetMouseButtonDown(1) ||
            Input.GetMouseButtonDown(2))
            {
                preMousePos = Input.mousePosition;
            }

            MouseDrag(Input.mousePosition);
        }
        else
        {
            float scrollWheel = Input.GetAxis("Mouse ScrollWheel");
            if (!Mathf.Approximately( scrollWheel, 0.0f))
            {
                MouseWheel(scrollWheel);
            }
        }
    }

    private void MouseDrag(Vector3 mousePos)
    {
        Vector3 diff = mousePos - preMousePos;

        if (diff.magnitude < Vector3.kEpsilon)
        {
            return;
        }

        if (Input.GetMouseButton(0))
        {
            CameraRotateMove(new Vector2(-diff.y, diff.x) * rotateSpeed);
        }
        else if (Input.GetMouseButton(2))
        {
            transform.Translate(-diff * Time.deltaTime * moveSpeed);
            freeCameraTarget.transform.forward = transform.forward;
            freeCameraTarget.transform.Translate(-diff * Time.deltaTime * moveSpeed);
        }
        else if (Input.GetMouseButton(1))
        {
            float moveValue = (diff.x - diff.y) * MOUSE_WHEEL_MOVE_SENSITIVITY;
            float scrollWheel = Mathf.Clamp(moveValue, -1.0f, 1.0f);
            if ( !Mathf.Approximately(scrollWheel, 0.0f))
            {
                MouseWheel(scrollWheel);
            }
        }
        preMousePos = mousePos;
    }

    private void MouseWheel(float delta)
    {
        transform.position += transform.forward * delta * wheelSpeed;
        var dist = Vector3.Distance(freeCameraTarget.position, transform.position);
        if (WLEEL_DISTANCE_MIN >= dist)
        {
            freeCameraTarget.transform.position += transform.forward * delta * wheelSpeed;
        }
    }

    public void CameraRotateMove(Vector2 angle)
    {
        transform.RotateAround(freeCameraTarget.position, transform.right, angle.x);
        transform.RotateAround(freeCameraTarget.position, Vector3.up, angle.y);
    }

    public void CameraRotate(Vector2 angle)
    {
        transform.RotateAround(transform.position, transform.right, angle.x);
        transform.RotateAround(transform.position, Vector3.up, angle.y);
    }

    public void OnChangeCamera(UnityEngine.UI.Toggle target)
    {
        if (isFirstSet == false && target.isOn)
        {
            OnSetPosition();
            isFirstSet = true;
        }
        gameObject.SetActive(target.isOn);
    }

    public void SetTargetObjectTransform(Transform target)
    {
        if (target)
            targetObjectTransform = target;
    }

    public void SetTargetCamera(Camera camera)
    {
        targetCamera = camera;
    }

    public void OnSetPosition()
    {
        if (freeCameraTarget)
        {
            if (targetObjectTransform)
            {
                freeCameraTarget.position = targetObjectTransform.position;
            }
            else
            {
                /*
                if (modelViewer && modelViewer.ModelObject)
                {
                    SetTargetObjectTransform(modelViewer.ModelObject.transform);
                    freeCameraTarget.position = targetObjectTransform.position;
                }
                */
            }
        }

        if (targetCamera)
        {
            transform.position = targetCamera.transform.position;
            transform.rotation = targetCamera.transform.rotation;
        }
    }
}
