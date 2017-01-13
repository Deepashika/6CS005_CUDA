// Name: Deepashika Maduwanthi
// Student Id: 1432291
//--------------------------------------------------

/*include <stdlib.h> header provides variable types,several macros, 
and functions to performe general functions.

 include <stdio.h> 
-the compiler to include this header file for compilation
*/


#include<stdio.h>
#include <stdlib.h>


#define N 4

/*Global function is also called "kernels".
 It's the functions that you may call from the host side.
 Matri_Add()will execute on the device
Matri_Add()will be called from the host
*/

__global__ void Matri_Add(int A[][N], int B[][N], int C[][N]){
	 // Thread row and column 
        int i = threadIdx.x;
		int j = threadIdx.y;

		C[i][j] = A [i][j] + B[i][j];
}


int main()
{

int A[N][N] =
    {
      {1, 5, 6, 7},
      {4, 4, 8, 0},
      {2, 3, 4, 5},
      {2, 3, 4, 5}
   };

int B[N][N] = 
    {
      {1, 5, 6, 7},
      {4, 4, 8, 0},
      {2, 3, 4, 5},
      {2, 3, 4, 5}
   };

int C[N][N] = 
     {
      {0, 0, 0, 0},
      {0, 0, 0, 0},
      {0, 0, 0, 0},
      {0, 0, 0, 0}
   };
   

//calling the poniters
int (*d_A)[N], (*d_B)[N], (*d_C)[N];

// allocate device copies of A,B, C	
	cudaMalloc((void**)&d_A, (N*N)*sizeof(int));
	cudaMalloc((void**)&d_B, (N*N)*sizeof(int));
	cudaMalloc((void**)&d_C, (N*N)*sizeof(int));
	
// CUDA memory copy types(copy input to device from host)
  cudaMemcpy(d_A, A, (N*N)*sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(d_B, B, (N*N)*sizeof(int), cudaMemcpyHostToDevice);
  cudaMemcpy(d_C, C, (N*N)*sizeof(int), cudaMemcpyHostToDevice);

   int numBlocks = 1;
  
  // N threads (kernel invoke N threads)
  dim3 threadsPerBlock(N,N);
  Matri_Add<<<numBlocks,threadsPerBlock>>>(d_A,d_B,d_C);

  // copy result of device back to host 
  cudaMemcpy(C, d_C, (N*N)*sizeof(int), cudaMemcpyDeviceToHost);

	int i, j; printf("C = \n"); 
	for(i=0;i<N;i++){
	for(j=0;j<N;j++){ 
	printf("%d ", C[i][j]);
	}
	printf("\n");
}
  