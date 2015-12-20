%% Initialization
clear ; close all; clc
addpath('/home/saasbook/Kaggle/jsonlab');
addpath('/home/saasbook/Kaggle/lib/ex6');

% training files
file='train-3.json'; % medium file
file='train.json'; % input file w/ 39774 recipes
file='train-2.json'; % tiny file
file='train-1.json'; % small file

% test files
filetest='test.json'; % input file w/ 39774 recipes

fprintf('Loading data for Kaggle competition: "What''s cooking"\n');
fprintf('\nData source: %s\n', file);

% load data
t=cputime;
data=loadjson(file);
printf('Total cpu time: %f seconds\n', cputime-t);
