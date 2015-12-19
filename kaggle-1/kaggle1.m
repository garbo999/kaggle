%% Initialization
clear ; close all; clc
addpath('/home/saasbook/Kaggle/jsonlab');
addpath('/home/saasbook/MachineLearning/machine-learning-ex6/ex6');
file='train.json'; % input file
file='train-2.json'; % input file
file='train-1.json'; % input file

fprintf('Loading data for Kaggle competition: "What''s cooking"\n');
fprintf('\nData source: %s\n', file);

% load data
t=cputime;
data=loadjson(file);
printf('Total cpu time: %f seconds\n', cputime-t);

% define constants
num_recipes = size(data, 2);

% save data to file
% fileID = fopen('whatscooking.txt','w');
% fprintf(fileID,'%6s %12s\n','x','exp(x)');
% fprintf(fileID,'%6.2f %12.8f\n',A);
% fclose(fileID);

% build array of ingredients and cuisines
ingr = [];
cuis = [];
id = [];
for i = 1:num_recipes
  cuis = [cuis; data{i}.cuisine];
  id = [id; data{i}.id];
  for j = 1:size(data{i}.ingredients, 2)
    ingr = [ingr; lower(data{i}.ingredients{j})]; % added LOWER
  endfor
endfor

% get unique ingredients and cuisines
uingr = unique(ingr, 'rows'); 
ucuis = unique(cuis, 'rows'); 

% transform into cell arrays
num_ingr = size(uingr, 1);
ingr_list = cell(num_ingr, 1);
for i = 1:num_ingr
    ingr_list{i} = strtrim(uingr(i,:)); % needed to trim string
end

num_cuis = size(ucuis, 1);
cuis_list = cell(num_cuis, 1);
for i = 1:num_cuis
    cuis_list{i} = strtrim(ucuis(i,:)); % needed to trim string
end

fprintf('\nNumber of recipes = %d\n', num_recipes);
fprintf('Number of cuisines = %d\n', num_cuis);
fprintf('Number of ingredients = %d\n\n', num_ingr);

% initialize X and Y arrays
X = zeros(num_recipes, num_ingr);
y = zeros(num_recipes, num_cuis);

% fill X and y arrays
for i = 1:num_recipes
  % y array
  cuis_index = find(strcmp(cuis_list, data{i}.cuisine));
  y(i, cuis_index) = 1;
  % X array
  for j = 1:1:size(data{i}.ingredients, 2)
    ingr_index = find(strcmp(ingr_list, lower(data{i}.ingredients{j})));
    X(i, ingr_index) = 1;
  endfor
  %fprintf('\n');
endfor

% SVM
C = 0.1;
model = zeros(num_recipes, num_cuis);
p = zeros(num_recipes, num_cuis);
for i = 1:num_cuis
  model(i) = svmTrain(X, y(:,i), C, @linearKernel); % need to deal with multiple categories!!!
  p(:,i) = svmPredict(model(i), X);
endfor
fprintf('Training Accuracy: %f\n', mean(double(p == y)) * 100);

% X
% y
% id
% need to reduce ingredient list to common ingredients only

