# NaviCL

AMD OpenCL Runtime for Navi Cards with Debian.

This branch is used for `Debian 12`.

## Thanks

Thanks to [AMD Yes! ROCm Team](https://salsa.debian.org/rocm-team)!

Most of packages are avaiable on Debian official repository.

But OpenCL support seems not ready for Debian 12, so the repository is used for reolving it.

Thanks to [AMD ROCm](https://github.com/ROCm) make AMD Radeon work on maching learning tasks.

## Warning

Please uninstall `mesa-opencl-icd` due to conflicting AMD ROCm OpenCL.

```sh
apt-get purge mesa-opencl-icd
```

## Installtion

Install AMD ROCm OpenCL Runtime on your Debian.

### Run autobuild.sh

There is a `autobuild.sh`, it will help you install build dependencies, and build OpenCL automaticlly.

```sh
bash autobuild.sh
```

Therefore, it will a directory `dist` created, install all the `rocm-*.deb` package.

```sh
cd dict/
deb -i rocm-*.deb
```

Try `clifo` to verify the installiation.

```sh
clinfo
```
