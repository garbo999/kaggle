addpath('/home/saasbook/Kaggle/jsonlab');
data=loadjson('train-1.json')
data=loadjson('train-2.json')

for d = data
  for val = d
    val.cuis
  endfor
endfor

% this builds an array of ingredients
ingr = [];
cuis = [];
for i = 1:size(data, 2)
  cuis = [cuis; data{i}.cuisine];
  for j = 1:size(data{i}.ingredients, 2)
    ingr = [ingr; data{i}.ingredients{j}];
  endfor
endfor

x = data{i}.ingredients{3}
x = all-purpose flour

uingr = unique(ingr, 'rows'); % get unique / sorts at same time
ucuis = unique(cuis, 'rows'); 
sortrows(ingr)

% this turns it into a cell
%num_ingr = 29;  
num_ingr = size(uingr);
ingr_list = cell(num_ingr, 1);
for i = 1:num_ingr
    ingr_list{i} = strtrim(uingr(i,:)); % needed to trim string
end

num_cuis = size(ucuis);
cuis_list = cell(num_cuis, 1);
for i = 1:num_cuis
    cuis_list{i} = strtrim(ucuis(i,:)); % needed to trim string
end

% index into ingredient list
ingr_index = find(strcmp(ingr_list, 'salt'))
cuis_index = find(strcmp(cuis_list, 'southern_us'))

% need to reduce ingredient list to common ingredients only

% X array
X = zeros(size(data,2), num_ingr(1))

% test loop to walk thru element of X array and recite ingredients
recipe_index = 3;
ingr_count = 0;
for i = 1:size(X,2)
  if X(recipe_index,i) == 1
    ingr_list{i}
    ingr_count += 1;
  endif
endfor
ingr_count

% read file
filename = 'AAA_octave_notes.m';
file_contents = readFile(filename);

% random indexes of vector
t = rand(10,1)
randidx = randperm(size(t, 1))

% equality test between a vector and a single number
% F1 --> first get vector with 1s and 0s depending on value (from ex8)
    predictions = (pval < epsilon);

    tp = sum((predictions == 1) & (yval == 1));
    fp = sum((predictions == 1) & (yval == 0));
    fn = sum((predictions == 0) & (yval == 1));

    prec = tp / (tp + fp);
    rec = tp / (tp + fn);

    F1 = (2 * prec * rec) / (prec + rec);

% mean of ratings
mean(Y(1, R(1, :)))

% find function is useful to get index or indices into vector or matrix

% convert matrix to row vector
T = rand(3,2)
T(:)

% max value and its index
[ max_value, max_index ] = max(p(3,:))

% sort matrix and get sorted values and original indices
[s, i] = sort(cuis_frequency, 'descend')

% save data to file
% http://se.mathworks.com/help/matlab/ref/fprintf.html
x = 0:.1:1;
A = [x; exp(x)];

fileID = fopen('exp.txt','w');
fprintf(fileID,'%6s %12s\n','x','exp(x)');
fprintf(fileID,'%6.2f %12.8f\n',A);
fclose(fileID);

% debugging
keyboard (">>>: "); 
