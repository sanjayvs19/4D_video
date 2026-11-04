#
# Copyright (C) 2023, Inria
# GRAPHDECO research group, https://team.inria.fr/graphdeco
# All rights reserved.
#
# This software is free for non-commercial, research and evaluation use 
# under the terms of the LICENSE.md file.
#
# For inquiries contact  george.drettakis@inria.fr
#

from setuptools import setup
from torch.utils.cpp_extension import CUDAExtension, BuildExtension
import os
os.path.dirname(os.path.abspath(__file__))

glm_include = "-I" + os.path.join(os.path.dirname(os.path.abspath(__file__)), "third_party/glm/")

cxx_flags = ['-g']
# NOTE: upstream passes "-G" (device debug). It is dropped here because it disables
# all device-code optimization and makes the rasterizer kernels run several times
# slower at train/render time, which matters on a 6GB RTX 3050.
nvcc_flags = [glm_include]
if os.name == 'nt':
    # CUDA 11.6 rejects MSVC >= 19.40 (VS 2022 17.10+/VS 2026). Bypass the
    # host_config.h version check for both the cl.exe and nvcc host passes.
    cxx_flags += ['-D__NV_NO_HOST_COMPILER_CHECK=1', '-D_ALLOW_COMPILER_AND_STL_VERSION_MISMATCH']
    nvcc_flags += ['-allow-unsupported-compiler', '-D__NV_NO_HOST_COMPILER_CHECK=1', '-D_ALLOW_COMPILER_AND_STL_VERSION_MISMATCH']

setup(
    name="diff_gaussian_rasterization",
    packages=['diff_gaussian_rasterization'],
    ext_modules=[
        CUDAExtension(
            name="diff_gaussian_rasterization._C",
            sources=[
            "cuda_rasterizer/rasterizer_impl.cu",
            "cuda_rasterizer/forward.cu",
            "cuda_rasterizer/backward.cu",
            "rasterize_points.cu",
            "ext.cpp"],
            extra_compile_args={"cxx": cxx_flags, "nvcc": nvcc_flags})
        ],
    cmdclass={
        'build_ext': BuildExtension
    }
)
