import numpy as np, glob, os
v = r"D:\4D\4d-gaussian-splatting\videos"
a = np.load(os.path.join(v, "poses_bounds.npy"))
print("poses_bounds shape:", a.shape, "dtype:", a.dtype)
print("num rows (cameras):", a.shape[0])
poses = a[:, :15].reshape(-1, 3, 5)
for i in range(a.shape[0]):
    H, W, fl = poses[i, :, -1]
    near, far = a[i, -2:]
    print(f"  row{i}: H={H:.0f} W={W:.0f} fl={fl:.2f} near={near:.3f} far={far:.3f}")
print("videos sorted:", sorted(os.path.basename(x) for x in glob.glob(os.path.join(v, "*.mp4"))))
try:
    import cv2
    for mp4 in sorted(glob.glob(os.path.join(v, "*.mp4"))):
        c = cv2.VideoCapture(mp4)
        print(os.path.basename(mp4), "fps=%.3f" % c.get(cv2.CAP_PROP_FPS),
              "frames=%d" % int(c.get(cv2.CAP_PROP_FRAME_COUNT)),
              "res=%dx%d" % (int(c.get(cv2.CAP_PROP_FRAME_WIDTH)), int(c.get(cv2.CAP_PROP_FRAME_HEIGHT))))
        c.release()
except Exception as e:
    print("cv2 probe unavailable:", repr(e))
