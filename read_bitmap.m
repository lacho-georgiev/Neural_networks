n_ex = 100;
ex = cell(n_ex, 1);
an = cell(n_ex, 1);

for i = 1: n_ex
    YourImage = imread(['examples_1_8_28/' num2str(i) '.tif']);
    YourImage = YourImage(:,:,1:3);
    grayImage = rgb2gray(YourImage);
    level = graythresh(grayImage);
    e = ~imbinarize(grayImage, level);
    ex{i} = reshape(e, N, 1);
end