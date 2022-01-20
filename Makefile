all:
	gcc -fPIC -c sha256.c -o sha256.o
	gcc -shared -Wl,-soname,libshagit.so.0 -o libshagit.so.0 sha256.o -lc
	sudo cp -uf libshagit.so.0 /usr/local/lib
	sudo ldconfig
main:
	gcc -fsanitize=address,undefined main.c sha256.c
