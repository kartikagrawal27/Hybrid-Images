img1 = im2single(imread('./redyellow.jpg'));
figure(1), imshow(img1), title('original');

%% CONTRAST ENHANCEMENT
% Gamma correction
im2 = img1.^1.2;
figure(2), imshow(im2), title('Gamma correction (1.2)');

% Histogram equalization
[hue, sat, val] = rgb2hsv(im2);
h = hist(val(:), 0:1/255:1);
c = cumsum(h);
val2 = c(uint8(val*255)+1)/numel(val);
im2 = hsv2rgb(hue, sat, val2);
figure(3), imshow(im2), title('Histogram equilization with gamma correction');

% Averaging original image and histeq image and giving equal weight to
% both(alpha = 0.5)
for alpha = 0.5
    veq = val*(1-alpha) + val2*alpha
    im2 = hsv2rgb(hue, sat, veq);
    figure(4), imshow(im2), title('Average of original and histeq image');
end


%% COLOR ENHANCEMENT
[h, s, v] = rgb2hsv(img1);
enhancedS = s .^ 0.6;
enhanced = hsv2rgb(h, enhancedS, v);
figure(5), hold off, imagesc(enhanced), axis image, title('Color enhancement');

%% COLOR SHIFT
% I) More red
img1_lab = rgb2lab(img1(:,:,1), img1(:,:,2), img1(:,:,3));
img1_lab(:,:,2) = img1_lab(:,:,2)*2.5;
more_red = lab2rgb(img1_lab);
figure(6), hold off, imagesc(more_red), axis image, title('More red');

% II) Less yellow
img1_lab = rgb2lab(img1);
img1_lab(:,:,3) = img1_lab(:,:,3)*0.3;
less_yellow = lab2rgb(img1_lab);
figure(7), hold off, imagesc(less_yellow), axis image, title('Less yellow');