.POSIX:


# paths
PREFIX = /usr/local
X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib
PKG_CONFIG = pkg-config


# includes and libs
INCS = -I$(X11INC) \
       `$(PKG_CONFIG) --cflags fontconfig` \
       `$(PKG_CONFIG) --cflags freetype2`
LIBS = -L$(X11LIB) -lm -lrt -lX11 -lutil -lXft \
       `$(PKG_CONFIG) --libs fontconfig` \
       `$(PKG_CONFIG) --libs freetype2`

# flags
STCFLAGS = $(INCS)  $(CPPFLAGS) $(CFLAGS)
STLDFLAGS = $(LIBS) $(LDFLAGS)

SRC = st.c x.c
OBJ = $(SRC:.c=.o)

all: options st

options:
	@echo st build options:
	@echo "CFLAGS  = $(STCFLAGS)"
	@echo "LDFLAGS = $(STLDFLAGS)"
	@echo "CC      = $(CC)"


.c.o:
	$(CC) $(STCFLAGS) -c $<

st.o: config.h st.h win.h
x.o:  config.h st.h win.h

$(OBJ): config.h 

st: $(OBJ)
	$(CC) -o $@ $(OBJ) $(STLDFLAGS)



.PHONY: all options clean dist install uninstall
