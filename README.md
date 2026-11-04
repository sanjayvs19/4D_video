# 4D Video

Windows-oriented pipeline and deliverables for 4D Gaussian-splatting video reconstruction.

## Repository layout

- `4d-gaussian-splatting-src/4d-gaussian-splatting/` — patched upstream source (Windows/CUDA build fixes, `build_ext.bat`, `env_4dgs.bat`, `run.bat`, configs).
- `4dv_ours/`, `sftest/` — COLMAP-format sparse reconstructions and assets.
- `deliverables/` — rendered videos, `.4dv` captures and the 4D viewer.
- `*.bat`, `*.ps1`, `*.py` — preprocessing, training, rendering and sanitizer scripts.
- `*.4dv` — 4D video captures (HackNeX and ours).

## Required dependency (not included)

The full upstream project with datasets/checkpoints is **excluded** from this repo because it is ~18 GB:

```bash
git clone https://github.com/fudan-zvg/4d-gaussian-splatting.git 4d-gaussian-splatting
```

Clone it into `4d-gaussian-splatting/` at the repository root before running the training/rendering scripts. Datasets, pretrained weights and build outputs stay local.

The patched source used on Windows lives in `4d-gaussian-splatting-src/4d-gaussian-splatting/`.

## Large file (Git LFS)

`4d-gaussian-splatting.zip` (225 MB) is stored with Git LFS:

```bash
git lfs install
git clone https://github.com/sanjayvs19/4D_video.git
```

## Setup

1. Clone this repo (with Git LFS installed).
2. Clone the upstream repo into `4d-gaussian-splatting/`.
3. Run `4d-gaussian-splatting-src\4d-gaussian-splatting\build_ext.bat` (or `env_4dgs.bat`) to build the CUDA extensions on Windows.
4. Use `run_preprocess.bat`, `run_train_ours.bat`, `run_ours10s.bat`, etc.
