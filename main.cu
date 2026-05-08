// #include <stdio.h>

// // This is the 'kernel' that runs on the GPU.
// // The __global__ keyword tells the compiler this function is called from the CPU
// // but executes on the GPU.
// __global__ void helloFromGPU() {
//     printf("Hello World from GPU thread %d!\n", threadIdx.x);
// }

// int main() {
//     printf("Hello World from CPU!\n");

//     // Launch the kernel on the GPU.
//     // Syntax: <<<number_of_blocks, threads_per_block>>>
//     helloFromGPU<<<1, 5>>>();

//     // Wait for the GPU to finish before the CPU continues.
//     // Without this, the program might exit before the GPU prints anything.
//     cudaDeviceSynchronize();

//     return 0;
// }

#include <stdio.h>

int main() {
    int deviceCount;
    cudaGetDeviceCount(&deviceCount);
    printf("Number of CUDA devices: %d\n", deviceCount);

    cudaDeviceProp prop;
    cudaGetDeviceProperties(&prop, 0);
    printf("GPU Name: %s\n", prop.name);
    printf("Compute Capability: %d.%d\n", prop.major, prop.minor);
    printf("Total Memory: %.0f MB\n", prop.totalGlobalMem / 1024.0 / 1024.0);
    return 0;
}