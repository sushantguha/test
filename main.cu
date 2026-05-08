#include <stdio.h>

// This is the 'kernel' that runs on the GPU.
// The __global__ keyword tells the compiler this function is called from the CPU
// but executes on the GPU.
__global__ void add(int n, float *a, float *b, float *c) {
    // Each thread will add an element.
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n) {
        c[idx] = a[idx] + b[idx];
    }
}

__global__ void initArrays(int n, float *a, float *b) {
    // Each thread will initialize one element
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n) {
        a[idx] = (float) idx;
        b[idx] = (float) idx * 2.0f;
    }
}

int main() {
    printf("Hello World from CPU!\n");

    float *a, *b, *c;
    int n = 1 << 20;

    cudaMallocManaged(&a, n * sizeof(float));
    cudaMallocManaged(&b, n * sizeof(float));
    cudaMallocManaged(&c, n * sizeof(float));



    // Launch the kernel on the GPU.
    // Syntax: <<<number_of_blocks, threads_per_block>>>
    initArrays<<<1, 5>>>(n, a, b);

    cudaDeviceSynchronize();

    printf("Initialized arrays\n");
    
    add<<<1, 5>>>(n, a, b, c);

    // Wait for the GPU to finish before the CPU continues.
    // Without this, the program might exit before the GPU prints anything.
    cudaDeviceSynchronize();

    return 0;
}


// git add . && git commit -m "from PC" && git push -u origin main