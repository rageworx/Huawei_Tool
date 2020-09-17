## Huawei Tool (MinGW-W64, static)

* A forked repository to supporting MinGW-W64 and Linux better.

### Descriptions

### Original Descriptions:

* (German) https://www.lteforum.at/mobilfunk/huawei-band-tool.7970
* https://drive.google.com/open?id=0B2hB5md6Sd_vVWlHekl2MDI4NkE

### Supported Devices:

* B618s-22d
* e3372, e5573 (HiLink)
* And others supporting WebUI.

### Supported platforms

* Windows (MinGW-W64)
* Linux
* MacOSX

### Dependencies:

* compiler: g++ higher then 4.7, or clang++
* external libraries : 
    - curl (included to downlaoding static build)
    - rapidxml (included)
    - crypto++ (use pacman for download)
    - config4cpp (included)
    - sdl2_net (use pacman for download)

### Tip: MinGW-W64 required packages with MSYS2

* rapidxml : included in src directory.
* crypto++ : pacman -S mingw-w64-x86_64-crypto++
* config4cpp : included in src directory.
* curl : use download_curl.sh in src directory.

### First to do:
* It is need to download libcurl and depended libraries for build static.
```
$ cd src
$ ./download_curl.sh
```
* Also it need to build config4cpp once.
```
$ cd src
$ cd config4cpp
$ make
```

### Building:
* Must be check libcurl and depended libraries downloaded and extracted.
* Also need to build config4cpp once.
* Then,
```
$ cd src
$ make 
```

### Install
```
$ cd src
$ make install
```

### Release(publish)
* built EXE file may copy in 'pub' directory.
```
$ cd src
$ make release
```