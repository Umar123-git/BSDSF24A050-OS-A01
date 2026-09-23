REPORT.md

# Operating Systems Assignment 1
## BSDSF24A050

# Module 2 – Multi-file Build

## Report Questions

### 1. Explain the linking rule in this part's Makefile: $(TARGET): $(OBJECTS). How does it differ from a Makefile rule that links against a library?

The rule:

$(TARGET): $(OBJECTS)

means that the final executable depends on all the object files listed in $(OBJECTS).

For example, the object files in this project are:

obj/main.o
obj/mystrfunctions.o
obj/myfilefunctions.o

The linker combines these object files to create the final executable:

bin/client

The Makefile can link them directly using a command such as:

$(CC) $(CFLAGS) $(OBJECTS) -o $(TARGET)

In this approach, the individual object files are directly supplied to the linker.

A Makefile rule that links against a library is different. Instead of passing all library object files directly, the linker is given the library location and library name. For example:

$(CC) $(CFLAGS) obj/main.o -Llib -lmyutils -o bin/client_static

Here:

obj/main.o is linked directly.
-Llib tells the linker where to search for the library.
-lmyutils tells the linker to use libmyutils.a.

Therefore, in the multi-file build, the object files are linked directly, while in the static-library build, the reusable object files are packaged inside a library and the executable links against that library.

### 2. What is a Git tag and why is it useful in a project? What is the difference between a simple tag and an annotated tag?

A Git tag is a named reference to a specific commit in a Git repository. Tags are useful for marking important points in the project's history, such as completed versions or releases.

For example, this project used:

v0.1.1-multifile

to identify the completed multi-file build.

There are two common types of Git tags:

Lightweight tag:

A lightweight tag is simply a name pointing to a particular commit. It does not contain additional tag information.

Example:

git tag v0.1.1-multifile

Annotated tag:

An annotated tag is a separate Git object that contains additional information such as the tag message, tagger, and date.

Example:

git tag -a v0.2.1-static -m "Version 0.2.1 - Static Library Build"

Annotated tags are useful for project versions and releases because they provide additional information about what the tag represents.

### 3. What is the purpose of creating a "Release" on GitHub? What is the significance of attaching binaries (like your client executable) to it?

A GitHub Release provides a convenient way to publish a specific version of a project based on a Git tag.

For example, a release can be associated with:

v0.1.1-multifile

or:

v0.2.1-static

A release can contain a title, description, source code associated with the tag, and downloadable files.

Attaching binaries such as bin/client or bin/client_static is useful because users do not have to compile the project themselves. They can download the already-built executable and use it directly, provided it is compatible with their system.



# Module 3 – Static Library

## Report Questions

### 1. Compare the Makefile from Part 2 and Part 3. What are the key differences in the variables and rules that enable the creation of a static library?

In Part 2, the Makefile was mainly responsible for compiling the source files into object files and linking them directly to create the client executable.

In Part 3, the Makefile was modified to introduce variables for the library directory and static library:

LIB_DIR = lib
LIBRARY = $(LIB_DIR)/libmyutils.a

It also introduced separate object files for the library:

LIB_OBJECTS = $(OBJ_DIR)/mystrfunctions.o \
              $(OBJ_DIR)/myfilefunctions.o

A new rule was added to create the static library using ar:

$(LIBRARY): $(LIB_OBJECTS)
	@mkdir -p $(LIB_DIR)
	ar rcs $(LIBRARY) $(LIB_OBJECTS)

The executable rule was also changed so that main.o links against the static library using:

-L$(LIB_DIR) -lmyutils

Therefore, the main difference is that Part 3 separates the reusable functions into a static library (libmyutils.a) and then links the main program with that library.

### 2. What is the purpose of the ar command? Why is ranlib often used immediately after it?

The ar command is used to create and manipulate archive files. In this assignment, it is used to combine the object files mystrfunctions.o and myfilefunctions.o into the static library:

ar rcs lib/libmyutils.a obj/mystrfunctions.o obj/myfilefunctions.o

The resulting libmyutils.a is a static library containing the compiled object files.

ranlib is traditionally used to generate or update the symbol index inside an archive. This index helps the linker quickly find the required symbols when linking the static library with an executable.

With the GNU ar rcs command used in this assignment, the s option already creates or updates the archive's symbol index. Therefore, a separate ranlib command is normally not required in this case.

### 3. When you run nm on your client_static executable, are the symbols for functions like mystrlen present? What does this tell you about how static linking works?

Yes. When nm was run on bin/client_static, the custom functions were present. For example:

00000000000016d8 T mystrlen
0000000000001712 T mystrcpy
0000000000001786 T mystrncpy
0000000000001818 T mystrcat

The T symbol type indicates that these functions are present in the executable's text/code section.
