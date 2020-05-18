# Steganography of Images Using SVD 
 This is a project on Steganography, particularly on Image Steganography. The project has been implimented in MATLAB and can be used for embedding simple messages in images. The images after embedding look similar to the one before embedding and will not be differentiable to the human eye. 

## Approach:
We have divided each input image into 4 x 4 blocks and we calculate the SVD for each block.
The message is embedded bit by bit in these blocks. After the SVD is computed the message bit will be embedded in the lest significant singular value of the singular matrix, so as to reduce the amount of loss in image information. To extract this value the SVD will again be computed and the embedded message bits will be extracted and reassembled.
 
 ## Usage:
 
The "workingstego.m" file contains all of the necessary code pertaining to both the encoding and embedding of the message as well as the decoding part of it(comments have been placed conveniently).

The "peaksignal.m" file contains the code for checking the results by using a technique called SSIM or Structural Similarity index which is a test which measures the quality degradation of an image.

This is just a simple implementation and a simple method to check your results , feel free to use it in any way you want to :) 

 
