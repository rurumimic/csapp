#include <stdio.h>
#include <stdlib.h>
#include "phases.h"

int read_six_numbers(char *s, int xs[])
{
	int len = sscanf(s, "%d %d %d %d %d %d", &xs[0], &xs[1], &xs[2], &xs[3], &xs[4], &xs[5]);

	printf("Your Inputs: '%s'\n", s);
	printf("Six Numbers:  %d %d %d %d %d %d\n", xs[0], xs[1], xs[2], xs[3], xs[4], xs[5]);
	printf("Numbers len:  %d\n", len);

	if (len <= 5) {
		return -1;
	}

	return xs[0];
}

int main(int argc, char *argv[])
{
	printf("Phase 2\n");

	if (argc != 2) {
		return 1;
	}

	int xs[6] = {0, };

	int a = read_six_numbers(argv[1], xs);
	if (a == -1) {
		printf("BOMB!!!\n");
		return 1;
	}

	for (int i = 1; i < 6; i++) {
		if (xs[i] != xs[i-1] * 2) {
			printf("%d + %d != %d\n", xs[i-1], xs[i-1], xs[i]);
			return 1;
		}
	}	

	printf("OK: %s\n", argv[1]);

	return 0;
}
