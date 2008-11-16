EXTRACFLAGS=-Wall -O2 -fPIC
CC=gcc $(EXTRACFLAGS)
STRIP=strip

STRIPFLAGS=--strip-unneeded --remove-section=.comment

OBJS = clc.o cmd.o info.o main.o msg.o net.o peer.o svc.o sys.o

qwfwd: $(OBJS) qwfwd.h
	$(CC) $(CFLAGS) $(OBJS) $(LDFLAGS) -o $@.db -lm
	$(STRIP) $(STRIPFLAGS) $@.db -o $@.bin

qwfwd.exe: *.c *.h
	$(MAKE) qwfwd CFLAGS=-mno-cygwin LDFLAGS="-lwsock32 -lwinmm"
	mv qwfwd qwfwd.exe

qwfwd-dl: $(OBJS) qwfwd.h
	$(CC) $(CFLAGS) $(OBJS) $(LDFLAGS) -shared -Wl,-soname,qwfwd-db.so -o qwfwd-db.so -lm
	$(STRIP) $(STRIPFLAGS) qwfwd-db.so -o qwfwd.so

clean:
	rm -rf qwfwd.bin qwfwd.exe qwfwd.db *.o qwfwd.so qwfwd-db.so
