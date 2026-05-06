#include <stdio.h>

__global__ void cuda_hello() {
    printf("Hello World from GPU!\n");
}

int main() {
    printf("CPU code\n");
    cuda_hello << <1, 1 >> > ();
    cudaDeviceSynchronize();  // ← Wait for GPU to finish
    return 0;
}