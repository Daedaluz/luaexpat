T= lxp
V= 1.0.2
CONFIG= ./config

include $(CONFIG)


lib: src/$(LIBNAME)

src/$(LIBNAME) : src/lxplib.o $(COMPAT_DIR)/compat-5.1.o
	export MACOSX_DEPLOYMENT_TARGET="10.3"; $(CC) -o src/$(LIBNAME) $(LIB_OPTION) src/lxplib.o $(COMPAT_DIR)/compat-5.1.o -lexpat

$(COMPAT_DIR)/compat-5.1.o: $(COMPAT_DIR)/compat-5.1.c
	$(CC) -c $(CFLAGS) -o $@ $(COMPAT_DIR)/compat-5.1.c

install:
	mkdir -p $(LUA_LIBDIR)
	cp src/$(LIBNAME) $(LUA_LIBDIR)
	cd $(LUA_LIBDIR); ln -f -h -s $(LIBNAME) $T.so
	mkdir -p $(LUA_DIR)/$T
	cp src/$T/lom.lua $(LUA_DIR)/$T

clean:
	rm -f src/$(LIBNAME) src/lxplib.o $(COMPAT_DIR)/compat-5.1.o

# $Id: makefile,v 1.31 2005-06-24 01:43:43 tomas Exp $
