n_ex = 100;
type='gpuArray';
ex = zeros(n_ex, N, type);
an = zeros(n_ex, 2, type);

k =[1 0 0 0 1 1 1 0 1 1 ...
    1 0 1 1 1 0 0 0 0 0 ...
    0 0 1 1 1 0 0 0 1 1 ...
    0 1 1 1 1 0 0 1 1 0 ...
    0 0 1 0 1 0 1 0 0 0]';

k =[1 0 1 1 0 0 1 1 1 1 ...
    1 1 0 1 1 0 0 1 0 0 ...
    1 1 0 0 0 0 0 1 0 0 ...
    0 1 1 1 1 1 1 0 1 1 ...
    0 0 0 0 0 0 0 1 1 1 ...
    1 1 1 0 0 0 0 1 1 1 ...
    0 0 0 0 0 1 1 1 1 1 ...
    0 0 0 1 1 1 0 0 1 1 ...
    1 1 1 1 0 0 0 0 0 0 ...
    1 1 1 1 1 1 1 0 0 0]';

c =[0 0 0 0 0 0 0 0 0 0 ...
    0 0 0 0 0 0 0 0 0 0 ...
    0 0 0 0 0 0 0 0 0 0 ...
    0 0 0 0 0 0 0 0 0 0 ...
    0 0 0 0 0 0 0 0 0 0 ...
    1 1 1 1 1 1 1 1 1 1 ...
    1 1 1 1 1 1 1 1 1 1 ...
    1 1 1 1 1 1 1 1 1 1 ...
    1 1 1 1 1 1 1 1 1 1 ...
    1 1 1 1 1 1 1 1 1 1]';

for i = 1: n_ex
    if c(i) == 1
       an(i,:) = [0 1]'; 
    else
        an(i,:) = [1 0]'; 
    end
    YourImage = imread(['examples_1_8_28/' num2str(i) '.tif']);
    YourImage = YourImage(:,:,1:3);
    grayImage = rgb2gray(YourImage);
    level = graythresh(grayImage);
    e = ~imbinarize(grayImage, level);
    ex(i,:) = reshape(e, 1, N);
end
