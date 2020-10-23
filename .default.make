CC ?= gcc
CFLAGS = -Wall -Werror -Wextra \
	-std=c99 -pedantic -Wstrict-prototypes
CFLAGS_MEM = -fsanitize=address
CFLAGS_DEBUG = -g -DDEBUG=1

CPPFLAGS = -Iinclude

TEST_LDLIBS = -lcriterion -L. -lstudent
TEST_LDFLAGS = -Wl,-rpath,.

SOURCES=${wildcard *.c}
OBJECTS=${SOURCES:.c=.o}
HELPERS=${wildcard *.h}
TEST_OBJECTS = tests/test.o

LIB = libstream.a libstudent.so
TARGET = a.out

# All makes library and executable
all: library
all: CFLAGS += ${CFLAGS_MEM}
all: build

# Libraby makes only the libraries
library: CFLAGS += -fPIC
library: ${OBJECTS} ${LIB}
#
# Compiles with the debug flags
debug: CFLAGS += ${CFLAGS_DEBUG} ${CFLAGS_MEM}
debug: build

# Clean the repo
clean:
	rm -f *.o ${TARGET} ${LIB} ${TEST_OBJECTS} testsuite

# Is use to make a criterion program
check: CFLAGS += -fPIC
check: testsuite
	./testsuite --verbose

# The criterion executable
testsuite: ${LIB}
testsuite: ${TEST_OBJS}
	${LINK.o} $^ ${TEST_LDFLAGS} -o $@ ${TEST_LDLIBS}

# Formats all sources and helpers
format:
	clang-format -i ${SOURCES} ${HELPERS}

# Build an exe
build: ${OBJECTS}
	${CC} -o ${TARGET} $^ ${CFLAGS} ${LDFLAGS}

# ALL EXTENSION RULES
# %.o: %.c %.h
# 	${CC} ${CFLAGS} -c $<
# 
# %.o: %.c
# 	${CC} ${CFLAGS} -c $<

%.so: ${OBJECTS}
	${CC} -shared ${LDFLAGS} -o $@ $^ ${LD_LIBS}

%.a: ${OBJECTS}
	ar crs $@ $^

.PHONY = clean all library debug check
