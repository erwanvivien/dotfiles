CC ?= gcc
CFLAGS = -Wall -Werror -Wextra \
	-std=c99 -pedantic -Wstrict-prototypes
CFLAGS_MEM = -fsanitize=address
CFLAGS_DEBUG = -g -DDEBUG=1
LDFLAGS= -lasan

TEST_LDLIBS = -lcriterion -L. -lstudent
TEST_LDFLAGS = -Wl,-rpath,.

SOURCES=${wildcard *.c}
OBJECTS=${SOURCES:.c=.o}
HELPERS=${wildcard *.o}
TEST_OBJECTS = tests/test.o

LIB = libdlist.a libstudent.so
TARGET = a.out

library: ${LIB}

all: CFLAGS += ${CFLAGS_MEM}
all: ${OBJECTS} ${LIB}

test: debug

debug: CFLAGS += ${CFLAGS_DEBUG}
debug: ${TARGET} build

format:
	clang-format -i ${SOURCES} ${HELPERS}

build:
	${CC} -o ${TARGET} ${OBJECTS} ${CFLAGS} ${LDFLAGS}

${TARGET}: ${OBJECTS}
	${CC} -o $@ $^ ${LDFLAGS}

%.o: %.c %.h
	${CC} ${CFLAGS} -c $<

%.o: %.c
	${CC} ${CFLAGS} -c $<

clean:
	rm -f *.o ${TARGET} ${LIB} ${TEST_OBJECTS} testsuite

check: CFLAGS += -fPIC
check: testsuite
	./testsuite --verbose

testsuite: ${LIB}
testsuite: ${TEST_OBJS}
	${LINK.o} $^ ${TEST_LDFLAGS} -o $@ ${TEST_LDLIBS}

%.so:
	${CC} -shared ${LDFLAGS} -o $@ $^ ${LD_LIBS}

%.a: ${OBJECTS}
	ar crs $@ $^

.PHONY = clean all test library debug check
