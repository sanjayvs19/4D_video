import numpy as np, os, sys
sys.path.insert(0, r"D:\4D\4d-gaussian-splatting")
from scene.dataset_readers import storePly

scene = r"D:\4D\4d-gaussian-splatting\data\N3V\hacknex"
rng = np.random.default_rng(0)

# n3v2blender normalization puts the look-at center at the origin and scales camera
# distance to ~4, so foreground content sits within a few units of the origin.
n_fg, n_bg = 150_000, 50_000

# foreground: gaussian blob around origin, clipped to radius 3
fg = rng.normal(0, 1.0, size=(n_fg * 2, 3))
fg = fg[np.linalg.norm(fg, axis=1) < 3.0][:n_fg]

# background: uniform shell radius 3..8 (walls / far scene)
dirs = rng.normal(0, 1, size=(n_bg, 3)); dirs /= np.linalg.norm(dirs, axis=1, keepdims=True)
rad = (rng.uniform(3.0**3, 8.0**3, size=(n_bg, 1))) ** (1/3)
bg = dirs * rad

xyz = np.concatenate([fg, bg], axis=0).astype(np.float32)
rgb = np.full((xyz.shape[0], 3), 128, dtype=np.uint8)  # neutral grey init

out = os.path.join(scene, "points3d.ply")
storePly(out, xyz, rgb)
print(f"wrote {xyz.shape[0]} points to {out}")
print("bounds min/max:", xyz.min(0), xyz.max(0))
