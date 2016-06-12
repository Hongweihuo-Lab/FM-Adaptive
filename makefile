CC=g++
CFLAGS=  -O3  -Wall
my_fm:div main.o fm.a
	g++ main.o fm.a   -o my_fm

all: adaptive clean
#adaptive: div man.o fm.a
#	g++ test.o fm.a $(CFLAGS) -o adaptive -lrt

fm.a:ABS_WT.o Balance_WT.o Huffman_WT.o Hutacker_WT.o FM.o BitMap.o UseCount.o WT_Handle.o InArray.o loadkit.o savekit.o divsufsort.o sssort.o trsort.o utils.o
	ar rc fm.a ABS_WT.o Balance_WT.o Huffman_WT.o Hutacker_WT.o FM.o BitMap.o UseCount.o WT_Handle.o  InArray.o loadkit.o savekit.o divsufsort.o sssort.o trsort.o utils.o

%.o:%.cpp *.h
	$(CC) -c  $(CFLAGS) $< -o $@

main.o:main.cpp  FM.h
	g++ -c  main.cpp

test.o: test.cpp FM.h
	g++ -c $(CFLAGS) test.cpp -lrt

clean:
	rm *.a *.o ./divsufsort/*.a ./divsufsort/*.o

div:
	make -C ./divsufsort/; cp divsufsort/libdivsufsort.a .;ar x libdivsufsort.a;rm libdivsufsort.a 
