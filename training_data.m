n_ex = 60000;
ex = cell(n_ex, 1);
an = cell(n_ex, 1);

images = loadMNISTImages('./data/train-images.idx3-ubyte');
labels = loadMNISTLabels('./data/train-labels.idx1-ubyte');

for i = 1 : 60000
	an{i} = [0 0 0 0 0 0 0 0 0 0];
	ex{i} = images(:, i);
	an{i}(labels(i) + 1) = 1; % because labels(i) can be 0
end
