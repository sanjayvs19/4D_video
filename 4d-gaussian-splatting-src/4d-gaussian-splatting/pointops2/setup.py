import os
from setuptools import setup
from torch.utils.cpp_extension import BuildExtension, CUDAExtension
from distutils.sysconfig import get_config_vars

# (opt,) = get_config_vars('OPT')
# os.environ['OPT'] = " ".join(
#     flag for flag in opt.split() if flag != '-Wstrict-prototypes'
# )

src = 'src'
sources = [os.path.join(root, file) for root, dirs, files in os.walk(src)
           for file in files
           if file.endswith('.cpp') or file.endswith('.cu')]

cxx_flags = ['-g']
nvcc_flags = ['-O2']
if os.name == 'nt':
    # CUDA 11.6 rejects MSVC >= 19.40 (VS 2022 17.10+/VS 2026). Bypass the
    # host_config.h version check for both the cl.exe and nvcc host passes.
    cxx_flags = ['-D__NV_NO_HOST_COMPILER_CHECK=1', '-D_ALLOW_COMPILER_AND_STL_VERSION_MISMATCH']
    nvcc_flags += ['-allow-unsupported-compiler', '-D__NV_NO_HOST_COMPILER_CHECK=1', '-D_ALLOW_COMPILER_AND_STL_VERSION_MISMATCH']

setup(
    name='pointops2',
    version='1.0',
    install_requires=["torch", "numpy"],
    packages=["pointops2"],
    package_dir={"pointops2": "functions"},
    ext_modules=[
        CUDAExtension(
            name='pointops2_cuda',
            sources=sources,
            extra_compile_args={'cxx': cxx_flags, 'nvcc': nvcc_flags}
        )
    ],
    cmdclass={'build_ext': BuildExtension}
)

