% need to load data first with file 'kaggle1-load'

% define/initialize constants
num_recipes = size(data, 2);
total_ingr = 0; % 
min_ingr_threshold = 1; % ignore ingredient if occurs < min_ingr_threshold

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
  for j = 1:size(data{i}.ingredients, 2) % iterate across individual ingredients in this recipe
    ingr = [ingr; lower(data{i}.ingredients{j})]; % added LOWER
    total_ingr += 1;
  endfor
endfor

% get unique ingredients and cuisines
uingr = unique(ingr, 'rows'); 
ucuis = unique(cuis, 'rows'); 
num_ingr_raw = size(uingr, 1);
num_cuis = size(ucuis, 1);

% transform into cell arrays
cuis_list = cellstr(ucuis);
% cuis_list = cell(num_cuis, 1);
% for i = 1:num_cuis
%     cuis_list{i} = lower(strtrim(ucuis(i,:))); % needed to trim string
% end

ingr_list_raw = cellstr(uingr);
% ingr_list_raw = cell(num_ingr_raw, 1);
% for i = 1:num_ingr_raw
%     ingr_list_raw{i} = strtrim(uingr(i,:)); % needed to trim string
% end

% analyze frequency of ingredients
ingr_frequency = zeros(num_ingr_raw, 1);
for i = 1:num_recipes
  for j = 1:1:size(data{i}.ingredients, 2)
    ingr_index = find(strcmp(ingr_list_raw, lower(data{i}.ingredients{j})));
    ingr_frequency(ingr_index) += 1;
  endfor
endfor

% analyze frequency of cuisines
cuis_frequency = zeros(num_cuis, 1);
for i = 1:num_recipes
  cuis_index = find(strcmp(cuis_list, lower(data{i}.cuisine)));
  cuis_frequency(cuis_index) += 1;
endfor
[cuis_frequency_sorted, cuis_frequency_index] = sort(cuis_frequency, 'descend');

% delete ingredients that don't occur frequently enough (>= min_ingr_threshold)
uingr_over_threshold = [];
for i = 1:num_ingr_raw
  if ingr_frequency(i) >= min_ingr_threshold
    uingr_over_threshold = [uingr_over_threshold ; ingr_list_raw{i}];
  endif
endfor

num_ingr = size(uingr_over_threshold, 1);

% transform into cell array (make this a function!)
ingr_list = cellstr(uingr_over_threshold);
% ingr_list = cell(num_ingr, 1);
% for i = 1:num_ingr
%     ingr_list{i} = strtrim(uingr_over_threshold(i,:)); % needed to trim string
% end

fprintf('\nNumber of recipes = %d\n', num_recipes);
fprintf('Number of cuisines = %d\n', num_cuis);
fprintf('Number of ingredients (raw) = %d\n', num_ingr_raw);
fprintf('Number of ingredients (> threshold) = %d\n', num_ingr);
fprintf('Total ingredient count (in all recipes) = %d\n\n', total_ingr);
fprintf('Top cuisine table:\n');

cuis_table_size = min(size(cuis_list, 1), 10);
for i = 1:cuis_table_size
  fprintf('%25s (%d = %6.1f%%)\n', cuis_list{cuis_frequency_index(i)}, cuis_frequency_sorted(i), cuis_frequency_sorted(i) / num_recipes *100);
endfor

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

% SVM SVM SVM SVM SVM SVM SVM SVM SVM SVM SVM SVM SVM SVM SVM SVM SVM SVM SVM SVM 
C = 1.1;
C = 0.3;
C = 0.1;
C = 0.5;

% model = zeros(num_recipes, num_cuis);
p = zeros(num_recipes, num_cuis);
for i = 1:num_cuis
  model(i) = svmTrain(X, y(:,i), C, @linearKernel); 
  p(:,i) = svmPredict(model(i), X);
endfor

% now go row by row to correct any all-0 predictions with most frequent cuisine
for i = 1:num_recipes
  if sum(p(i,:)) == 0
    p(i,cuis_frequency_index(1)) = 1;
  endif
endfor


% keyboard (">>>: "); 


% compute training accuracy
% need to guess if all p values are = 0 in row!!!!!!!!!!!!!
correct = 0;
for i = 1:num_recipes
  [ max_value, max_index ] = max(p(i,:));
  if strcmp(cuis_list{max_index}, data{i}.cuisine) == 1
    correct += 1;
  endif
endfor
fprintf('Value of C = %6.2f\n', C);
fprintf('Training Accuracy: %6.2f%%\n', (correct/num_recipes) * 100);

% X
% y
% id

