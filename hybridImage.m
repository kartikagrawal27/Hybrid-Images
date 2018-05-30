function img12 = hybridImage(im1, im2, cutoff_low, cutoff_high)

close all; % closes all figures

%%get dimensions of images
[h1, w1, l1] = size(im1);
[h2, w2, l2] = size(im2);

%%sigma calcualtion
sigma_low = w1/(2*pi*cutoff_low);
sigma_high = w1/(2*pi*cutoff_high);

%%half size of filter for low and high sigma
hs1 = (ceil(3*sigma_low));
hs2 = (ceil(3*sigma_high));

%% Low Pass Filtering
%creating filter and ffts and display FFTs and images
low_filt = fspecial('gaussian', 2*hs1+1, sigma_low);
im1_fft = fft2(im1, 2^nextpow2(h1), 2^nextpow2(w1));
figure(2), imagesc(log(abs(fftshift(im1_fft)))), title('panda_fft'), colormap jet;
low_filt_fft = fft2(low_filt, 2^nextpow2(h1), 2^nextpow2(w1));
figure(3), imagesc(log(abs(fftshift(low_filt_fft)))), title('low_filt_fft'), colormap jet;
filtered_fft_img1 = im1_fft.*low_filt_fft;
figure(4), imagesc(log(abs(fftshift(filtered_fft_img1)))), title('filtered_panda_fft'), colormap jet;
filtered_img1 = ifft2(filtered_fft_img1);
figure(5), imshow(filtered_img1), title('filtered panda');
filtered_img1 = filtered_img1(1+hs1:size(im1,1)+hs1, 1+hs1:size(im1,2)+hs1);


%% High Pass Filtering
%creating filter and ffts and display FFTs and images
high_filt = fspecial('gaussian', 2*hs2+1, sigma_high);
high_filt_fft = fft2(high_filt, 2^nextpow2(h1), 2^nextpow2(w1));
figure(6), imagesc(log(abs(fftshift(high_filt_fft)))), title('high_filt_fft'), colormap jet;
im2_fft = fft2(im2, 2^nextpow2(h1), 2^nextpow2(w1));
figure(7), imagesc(log(abs(fftshift(im2_fft)))), title('tiger_fft'), colormap jet;
im2_fil_fft = im2_fft .* (1 - high_filt_fft);
figure(8), imagesc(log(abs(fftshift(im2_fil_fft)))), title('filtered_tiger_fft'), colormap jet;
filtered_img2 = ifft2(im2_fil_fft);
figure(9), imshow(filtered_img2), title('filtered_tiger');
filtered_img2 = filtered_img2(1+hs2:size(im2,1)+hs2, 1+hs2:size(im2,2)+hs2);

%Combining filtered images to get resultant image
img12 = filtered_img1 + filtered_img2;