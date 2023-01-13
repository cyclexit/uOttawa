EXES += $(basename $(shell ls *.c))

%: %.c
	gcc $< -o $@ $(LIBS)

all: $(EXES)

clean:
	rm $(EXES)

.PHONY: all clean