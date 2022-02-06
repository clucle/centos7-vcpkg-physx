# centos7-vcpkg-physx
Run cmake project using physx

## Usage
```
# build
docker build --tag centos7-vcpkg-physx:1.0 .

# run
docker run -i -t --rm --name centos7-vcpkg-physx centos7-vcpkg-physx:1.0
```

## build & run
```
[root@ffff src]# pwd
/home/src

[root@ffff src] mkdir build
[root@ffff src] cd build
[root@ffff build] cmake ..
[root@ffff build] make
[root@ffff build] ./VcpkgPhysX
```
