## Huawei Tool ##

* A forked repository to supporting MinGW-W64 and Linux better.

### Description: ###

* (German) https://www.lteforum.at/mobilfunk/huawei-band-tool.7970

### Releases: ###

* https://drive.google.com/open?id=0B2hB5md6Sd_vVWlHekl2MDI4NkE

### Supported Devices: ###

* B618s-22d
* e3372, e5573 (HiLink)
* And others supporting WebUI.

### Supported platforms

* Linux
* MacOSX
* Windows (MinGW-W64)

### Dependencies:

* compiler: g++ higher then 4.7, or clang++
* external libraries : 
    - curl
    - rapidxml (included)
    - crypto++
    - config4cpp (included)
    - sdl2_net

### Tip: MinGW-W64 required packages with MSYS2

* rapidxml : included in src directory.
* crypto++ : pacman -S mingw-w64-x86_64-crypto++
* config4cpp : included in src directory.

### Building:
```
$ cd src
$ cd config4cpp
$ make
$ cd ..
$ make 
$ make install
```