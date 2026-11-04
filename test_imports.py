import os, sys, importlib.util
import torch
print("torch", torch.__version__, "cuda", torch.version.cuda, "avail", torch.cuda.is_available())

import simple_knn._C
print("[OK] simple_knn._C")

import pointops2_cuda
print("[OK] pointops2_cuda")

# Trigger the rasterizer JIT build without importing the whole gaussian_renderer package.
path = os.path.join("gaussian_renderer", "diff_gaussian_rasterization.py")
spec = importlib.util.spec_from_file_location("dgr_test", path)
m = importlib.util.module_from_spec(spec)
print("Building diff_gaussian_rasterization via JIT load()... (first time is slow)")
spec.loader.exec_module(m)
print("[OK] diff_gaussian_rasterization JIT _C:", type(m._C))
print("    has rasterize_gaussians:", hasattr(m._C, "rasterize_gaussians"))
print("    has rasterize_gaussians_backward:", hasattr(m._C, "rasterize_gaussians_backward"))
print("    has mark_visible:", hasattr(m._C, "mark_visible"))
print("ALL THREE EXTENSIONS OK")
