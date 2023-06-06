kompilator : bison.tab.c scan.c
			gcc f.c bison.tab.c -lm -o kompilator

bison.tab.c	: bison
				bison -d bison

scan.c		:  flex
				flex -o f.c flex

				