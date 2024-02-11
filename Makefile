CC = gcc
SRCS = $(wildcard src/run*.c)

ifeq ($(OS),Windows_NT)
	SRCW = src/win.c
	CFLAGS = -static -fopenmp -march=native -O3 -D_WIN32 -I $(SRCW)
else
	CFLAGS = -static -std=gnu11 -fopenmp -march=native -O3
endif

OBJS = $(patsubst %.c,%.o,$(SRCS))

%.o: %.c
	$(CC) $(CFLAGS) $< -o $@ -lm
	mv $@ .

.PHONY: all
all: $(OBJS)

run:
	python3 main.py

.PHONY: clean
clean:
	-rm -f *.o
