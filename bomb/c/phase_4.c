#include <stdio.h>
#include <stdlib.h>
#include "phases.h"

int func4(int node, int low, int high) {
	printf("func4(%2d, %2d, %2d) ", node, low, high);

	int size = high - low;
	int sign = (size >> (sizeof (int) * 8 - 1) ) & 1; // 4bytes * 8bit - 1bit	
	int mid = low + (size + sign) / 2; // for negative floor division
	
	printf("mid: %2d, sign: %d\n", mid, sign);

	if (node == mid) {
		return 0;
	}

	if (node < mid) {
		return 2 * func4(node, low, mid - 1);
	} else {
		return 2 * func4(node, mid + 1, high) + 1; // +1 when moving right
	}
}

int main(int argc, char *argv[])
{
	printf("phase 4\n");

	if (argc != 2) {
		return 1;
	}

	int node = 0;
	int test = 0;

	int len = sscanf(argv[1], "%d %d", &node, &test);
	if (len != 2) {
		printf("bomb!!!\n");
		return 1;
	}

	int low = 0;
	int high = 14;

	if (node < 0 || node > high) {
		printf("bomb!!!\n");
		return 1;
	}

	int ret = func4(node, low, high);

	if (ret != 0) {
		printf("bomb!!! (%d)\n", ret);
		return 1;
	}
	
	if (test != 0) {
		printf("bomb!!!\n");
		return 1;
	}

	printf("Answer: %d %d\n", node, test);

	return 0;
}
