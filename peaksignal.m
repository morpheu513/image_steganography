%% This file is to perform a simple test on the obtained results.
%% This test is know as SSIM or Structural Similarity index. SSIM is a test which measures the quality degradation of an image.
%% In our case it measures the degradation caused by the embedding of our message in the image.
%% A score of -1 means that the images are structurally very differant and +1 means that the images are structurally very similar

%% Importing the message
I1=imread("10.jpg");  %% Write the path to the original image here
I2=imread("stego-10.jpg");  %% Write path to stego-image here
ssimval = ssim(I2,I1);

ssimval
