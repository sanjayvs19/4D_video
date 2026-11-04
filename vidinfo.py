import imageio, numpy as np, os
from PIL import Image
VD = r"D:\4D\4d-gaussian-splatting\videos"
def fr(p, n):
    r = imageio.get_reader(p)
    a = r.get_data(n); r.close()
    return np.asarray(Image.fromarray(a).convert("L").resize((128,128)), dtype="float32")
def ncc(x, y):
    x = x - x.mean(); y = y - y.mean()
    return float((x*y).sum() / np.sqrt((x*x).sum()*(y*y).sum()))
for v in ["vid01","vid02","vid03"]:
    p = os.path.join(VD, v + ".mp4")
    r = imageio.get_reader(p)
    n = r.count_frames()
    meta = r.get_meta_data()
    r.close()
    print(v, "frames=", n, "fps=", meta.get("fps"), "size=", meta.get("size"))
for n in [0, 120, 300]:
    a = fr(os.path.join(VD,"vid01.mp4"), n)
    b = fr(os.path.join(VD,"vid02.mp4"), n)
    print("f%-4d vid01~vid02 NCC=%.3f" % (n, ncc(a, b)))
a = fr(os.path.join(VD,"vid01.mp4"), 0)
c = fr(os.path.join(VD,"vid03.mp4"), 0)
print("vid01~vid03 NCC=%.3f" % ncc(a, c))
