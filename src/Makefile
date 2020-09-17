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

override COMPILER= $(shell echo $(CXX) | awk -F- '{print $NF}')
override CPP= $(shell echo $(CXX) | sed 's/$(COMPILER)/cpp)/')

override PLATFORM:= $(shell echo $(PLATFORM) | tr '[:upper:]' '[:lower:]')
override CFLAGS  += -std=$(STD) -O$(OPTIMIZE) -Wno-deprecated -Wcpp
override CFLAGS  += -Isrc -Irapidxml -Iconfig4cpp/include
override CFLAGS  += -Wall -Wextra -Werror=format
override LFLAGS  += -Lconfig4cpp/lib

ifeq (1, $(DEBUG))
    override CFLAGS+= -DDEBUG -g3
else
	override LFLAGS+= -O2
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
            override LFLAGS+= -Wl,-s
        endif
        ifeq (0, $(NO_STATIC_C_LIB))
            override LFLAGS+= -static
        endif
        override LFLAGS+= -static-libgcc -static-libstdc++
        override LFLAGS+= -Wl,--gc-sections
       # override LFLAGS+= -Wl,--as-needed
    else
        override LFLAGS+= -Wl,-dead_strip
    endif
endif

ifneq (, $(LIBS))
    override CFLAGS+= -isystem $(LIBS)/include
    override LFLAGS+= -L $(LIBS)/lib
endif

ifneq (, $(findstring darwin, $(PLATFORM)))
    override CFLAGS+= -DUSE_GETTIMEOFDAY
endif

ifneq (, $(findstring linux, $(PLATFORM)))
    override EXTRA_LIBS+= -lrt
endif

ifneq (, $(findstring android, $(PLATFORM)))
    override CFLAGS+=-fPIE
    override LFLAGS+=-pie
    override EXTRA_LIBS+=-ldl -llog
endif

ifneq (, $(findstring mingw, $(PLATFORM)))
	#override CFLAGS+= -DCURL_STATICLIB -D__USE_MINGW_ANSI_STDIO
	#override LFLAGS+= -static-libgcc -static-libstdc++
	override EXTRA_LIBS+= -lpthread
    override EXE_SUFFIX= .exe
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

override LFLAGS+= $(PRE_LFLAGS)
override LFLAGS+= -lcryptopp -lconfig4cpp -lcurl -lz -lSDL2_net -lSDL2
override LFLAGS+= $(EXTRA_LIBS)

.PHONY: clean prepare release

all: prepare $(TARGETBIN)

prepare:
	@echo "Preparing target platform: $(PLATFORM)"
	@mkdir -p $(OUTDIR)
	@mkdir -p $(OBJDIR)

$(OBJS): $(OBJDIR)%.o: $(SRCDIR)%.cpp
	@echo "Compiling $< ..."
	@$(CXX) $(CFLAGS) -c -o $@ $<

$(TARGETBIN): $(OBJS)
	@echo "Linking $@ ..."
	@$(CXX) $(CFLAGS) $(OBJS) $(LFLAGS) -o $@

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
