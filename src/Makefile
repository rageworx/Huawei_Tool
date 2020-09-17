PLATFORM ?= $(shell uname -s)
NO_STATIC_C_LIB ?= 0
RELEASE ?= 0
DEBUG ?= 0
OPTIMIZE ?= 3
LTO ?= 0
STD ?= c++0x

OUTBIN=huawei_band_tool
OUTDIR=bin/
OBJDIR=obj/
SRCDIR=src/
INSTALLDIR=/usr/local/bin

include download.conf

override COMPILER= $(shell echo $(CXX) | awk -F- '{print $NF}')
override CPP= $(shell echo $(CXX) | sed 's/$(COMPILER)/cpp)/')

override PLATFORM:= $(shell echo $(PLATFORM) | tr '[:upper:]' '[:lower:]')
override CFLAGS   = -std=$(STD) -O$(OPTIMIZE) -Wno-deprecated
override CFLAGS  += -Ires -Isrc -Irapidxml -Iconfig4cpp/include
override CFLAGS  += -Wall -Wextra -Werror=format
override USR_LFLAGS += -Lconfig4cpp/lib

ELIBS = -lcryptopp -lconfig4cpp -lSDL2_net -lSDL2

ifeq (1, $(DEBUG))
    override CFLAGS+= -DDEBUG -g3
else
	override OPT_FLAGS+= -O3 -s
endif

#ifneq (1, $(RELEASE))
    override CFLAGS+= -DWORK_IN_PROGRESS
#endif

ifeq (, $(findstring clang, $(CXX)))
    override LTOFLAG= -flto=8
else
    override LTOFLAG= -flto
endif

ifeq (1, $(LTO))
    override CFLAGS+= $(LTOFLAG)
endif

ifneq (, $(LIBS))
    ifeq (, $(findstring darwin, $(PLATFORM)))
        ifneq (1, $(DEBUG))
            override PRE_LFLAGS+= -Wl,-s
        endif
        ifeq (0, $(NO_STATIC_C_LIB))
            override PRE_LFLAGS+= -static
        endif
        override USR_LFLAGS+= -static-libgcc -static-libstdc++
        override USR_LFLAGS+= -Wl,--gc-sections
       # override LFLAGS+= -Wl,--as-needed
    else
        override LFLAGS+= -Wl,-dead_strip
    endif
endif

ifneq (, $(LIBS))
    override CFLAGS+= -isystem $(LIBS)/include
    override PRE_LFLAGS+= -L $(LIBS)/lib
endif

ifneq (, $(findstring darwin, $(PLATFORM)))
    override CFLAGS+= -DUSE_GETTIMEOFDAY
	override USR_LFLAGS+= -lcurl -lz
endif

ifneq (, $(findstring linux, $(PLATFORM)))
    override EXTRA_LIBS+= -lrt
	override USR_LFLAGS+= -lcurl -lz
endif

ifneq (, $(findstring android, $(PLATFORM)))
    override CFLAGS+=-fPIE
    override USR_LFLAGS+=-pie
	override USR_LFLAGS+=-lcurl -lz
    override EXTRA_LIBS+=-ldl -llog
endif

ifneq (, $(findstring mingw, $(PLATFORM)))
	override CFLAGS+= -DCURL_STATICLIB
	override CFLAGS+= -I$(DIRDEST)/$(DIROPENSSL)/include
	override CFLAGS+= -I$(DIRDEST)/$(DIRBROTLI)/include
	override CFLAGS+= -I$(DIRDEST)/$(DIRSSH2)/include
	override CFLAGS+= -I$(DIRDEST)/$(DIRNGHTTP2)/include
	override CFLAGS+= -I$(DIRDEST)/$(DIRCURL)/include
	override PRE_LFLAGS+= -L$(DIRDEST)/$(DIROPENSSL)/lib
	override PRE_LFLAGS+= -L$(DIRDEST)/$(DIRBROTLI)/lib
	override PRE_LFLAGS+= -L$(DIRDEST)/$(DIRSSH2)/lib
	override PRE_LFLAGS+= -L$(DIRDEST)/$(DIRNGHTTP2)/lib
	override PRE_LFLAGS+= -L$(DIRDEST)/$(DIRCURL)/lib

	# local libraries ..
	override PRE_LFLAGS+= -mwindows -static -lmingw32 -lSDL2main
	override USR_LFLAGS+= -lcurl -lssh2 -lssl -lnghttp2
	override USR_LFLAGS+= -lbrotlidec-static -lbrotlicommon-static

	# about windows ....
	override EXTRA_LIBS+= -ldxerr8 -ldinput8 
	override EXTRA_LIBS+= -lshell32 -lsetupapi -ladvapi32 -luuid -lversion
	override EXTRA_LIBS+= -loleaut32 -lole32 -limm32
	override EXTRA_LIBS+= -lcrypto -lcrypt32 -lwldap32 
	override EXTRA_LIBS+= -lm -lgdi32 -lwinmm -luser32 -liphlpapi
	override EXTRA_LIBS+= -lz -lzstd -lws2_32 -lpthread

    override EXE_SUFFIX= .exe

	WRC=windres
	WROBJ = $(OBJDIR)/resource.o
endif

################################################################################

TARGETBIN = $(OUTDIR)$(OUTBIN)$(EXE_SUFFIX)

SRCS += $(SRCDIR)at_tcp.cpp 
SRCS += $(SRCDIR)huawei_tools.cpp 
SRCS += $(SRCDIR)tools.cpp 
SRCS += $(SRCDIR)web.cpp 
SRCS += $(SRCDIR)cli_tools.cpp
SRCS += $(SRCDIR)main.cpp 

OBJS=$(SRCS:$(SRCDIR)%.cpp=$(OBJDIR)%.o)

LFLAGS+= $(PRE_LFLAGS)
LFLAGS+= $(ELIBS)
LFLAGS+= $(USR_LFLAGS)
LFLAGS+= $(EXTRA_LIBS)

.PHONY: clean prepare release

all: prepare $(TARGETBIN)

prepare:
	@echo "Preparing target platform: $(PLATFORM)"
	@mkdir -p $(OUTDIR)
	@mkdir -p $(OBJDIR)

$(OBJS): $(OBJDIR)%.o: $(SRCDIR)%.cpp
	@echo "Compiling $< ..."
	@$(CXX) $(CFLAGS) -c -o $@ $<

$(TARGETBIN): $(OBJS) $(WROBJ)
	@echo "Linking $@ ..."
	@$(CXX) $(CFLAGS) $(OBJS) $(WROBJ) $(LFLAGS) $(OPT_FLAGS) -o $@

$(WROBJ): res/resource.rc
	@echo "Building windows resource ..."
	@$(WRC) -i $< -Ires -o $@

install: $(TARGETBIN)
	@echo "Installing $< ..."
	@cp -f $(TARGETBIN) $(INSTALLDIR)

release: $(TARGETBIN)
	@echo "Publishing $< ..."
	@cp -f $(TARGETBIN) ../pub

clean:
	@echo "Cleaning ..."
	@rm -f $(OBJDIR)*.o
	@rm -f $(TARGETBIN)
