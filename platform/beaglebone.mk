SOURCES += platform/beaglebone.c
LDFLAGS += -lSDL2_mixer -lm -lrt
CFLAGS += -DAPKENV_GLES -DAPKENV_GLES2 -DMESA_EGL_NO_X11_HEADERS -DNO_IMGLIB_JPEG_MEM_SRC
LDFLAGS += -lGLES_CM -lGLESv2 -lEGL

BIONIC_LIBS := $(wildcard libs/harmattan/*.so)

CFLAGS += -DAPKENV_LOCAL_BIONIC_PATH=\"./libs/harmattan/\"

# only install bionic libs if we actually have them
ifneq ($(BIONIC_LIBS),)
install_beaglebone:
	$(SILENTMSG) -e "\tINSTALL\tBIONIC"
	$(SILENTCMD)mkdir -p $(DESTDIR)$(PREFIX)/lib/$(TARGET)/bionic
	$(SILENTCMD)install -m644 $(BIONIC_LIBS) $(DESTDIR)$(PREFIX)/lib/$(TARGET)/bionic

PLATFORM_INSTALL_TARGETS += install_beaglebone
.PHONY: install_beaglebone
endif

