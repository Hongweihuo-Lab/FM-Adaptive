# FM-Adaptive

## What is it?
  	 FM-Adaptive is a full-text compressed index and combines the Burrows-Wheeler transform (BWT)
	 and the wavelet tree (WT).  It partitions adaptively the node bit vector in the WT into blocks
	 and applies the hybrid encoding along with run-length Gamma encoding to each block while
	 explores data-aware compression. It retains the high-order entropy-compressed theoretical
	 performance and introduces some improvements in practice. Statistical evidence shows that
	 the distribution of run-lengths for the non-repetitive data appears to follow a power-law
	 distribution, which matches the optimality of the Gamma encoding to the run-lengths.
	 
	 counting: compute the number of occurrences of pattern P in the text T.
	 locating: report the list of positions, where P occurs in T.
	 extract: extraction of arbitrary portions of T.

## How to use it?
### just for fun
 step 1: download it or clone it  
 step 2: make  
 step 3: run my_fm  

### build your own program
 step 1: download or clone it  
 step 2: make   
 step 3: include FM.h   
 step 4: g++ your_program.cpp -o xx -fm.a   

### example
```cpp
#include "fm.h"
#include <iostream>
using namespace std;
int main()
{
    int speedlevel = 1;
    FM fm("filename", speedlevel); //default speedlevel = 1
    int num;
    fm.Counting("the", num);
    cout << "pattern the occs " << num<< " times" <<endl;
    int *pos;
    fm.Locating("love", num,pos);
    cout << "pattern love occs " << num<< " times" << endl;
    cout << "all the positions are:";
    for (int i = 0; i < num; i++)
        cout << pos[i] << endl;
    delete [] pos; //it's your duty to delete pos.
    pos = NULL;

    char * sequence;
    int start = 0;
    int len = 20;
    fm.Extracting(start, len, sequence);
    cout << "T[start...start+len-1] is " << sequence << endl;
    delete [] sequence; //it's your duty to delete sequence.
    sequence = NULL;

    fm.Save("index.fm"); //serialize the fm object to file index.fm
    FM fm2;
    fm2 -> Load("index.fm"); //restore the fm object from file index.fm

    return 0;
}
```
## Suffix Array Construction
  The current version uses Yuta Mori's fast suffix array construction library [libdivsufsort](http://code.google.com/p/libdivsufsort/) version 2.0.1.

## Contributors
### Code
  •	Longgang Chen （陈龙刚）   
  •	Heng Zhao （赵恒）     
  •	Xiaoyang Chen （陈晓阳）  

### Paper
  FM-Adaptive is an implementation of the paper.

  H. Huo, L. Chen, H. Zhao, J. S. Vitter, Y. Nekrich, et al., A Data-Aware FM-index, ACM-SIAM Proceedings of the 17th Meeting on Algorithm Engineering and Experiments (ALENEX), San Diego, California, USA, 2015, 10–23.

## ChangeLog
2014.5.25:
Use the Lookup Tables, and cross them, it looks helpful, count works faster about 25~35%. 

2014.5.27:
If gamma coding doesn't save much space, only very few, using plain first. It helps, not very significant. 

2014.5.28:
Complete the copy constructor, assignment operator, for class FM by using Use Count Tec. It seems WT-Node is not a good name, BitMap is better.

2014.5.30:
Want to computer from head or tail, depending on which point is good, working on it Now!

2014.6.1:
It seems that Rank(int pos) works now, and the answer seems right. That's good!. Now working on Rank(int pos, int &bit). And change rename 'WT-Node' to BitMap

2014.6.2:
Computer Rank from head or tail adaptively, but the result is not good, this may be a result of expanded lookup tables, or bit-reverse function. So we can drop the drawback-lookup tables, and drop the bit-reverse function, only holds: forward-lookup tables and reverse-table, this will reduce space of tables, and bit-reverse can use the reverse-table, so it's may be faster. Working on it! 

2014.6.3
It does not work to drop backforward-lookup tables and bit-reverse function, So, expanded lookup tables and bit-reverse function is not the suspect of fading performance 

2014.6.4
After a long time thinking, it's no need to use reverse-function or reverse-tables. we can map all the gamma value to odd numbers, so the lowest bit will be 1, and it can denote the boundary. The mapping function: f(x) = x + x - 1 or f(x) = x + x -3 or f(x) = x + x - 5... 

2014.6.6:
Rank from head or tail will not save time for any kind of document. if the file is random-like file, the needed block should be small, in this situation, from both points will not help, because time used for decoding is not very significant, and time for prepare-operations will increase. for highly-repetitive data the runs are big, the decoding process is good enough, for example, if the block-size is 1024,the runs will be hundreds, so only a few decoding steps is needed. In this situation, form both points will not help too. So let it go, bye!

2014.6.6: 
draw back search function has the potential to works faster. Working on it

2016.6.15：
fix some bugs
