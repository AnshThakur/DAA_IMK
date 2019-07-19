% demo file
%% load aa or daa dictionaries

% see https://github.com/AnshThakur/Deep-Convex-Representation_IS2018 for
% computing AA or DAA

%Using random dictionaries of 10 archetypes in this demo
D1=rand(39,10);
%load D1;% dictionary of class1

%load D2; % dictionary of class2
D2=rand(39,10);
%% X and Y are cell array containing feature sets from class x and class y respectively (again using random data)

X=rand(39,30,100);
X= num2cell(X,[1 2]);
X=reshape(X,[100,1]);

Y=rand(39,25,100);
Y= num2cell(Y,[1 2]);
Y=reshape(Y,[100,1]);

%% select local vectors using dictionary atoms
[local_vector_x] = select_local_vectors(X,D1,D2);
[local_vector_y] = select_local_vectors(Y,D1,D2);

TRAIN=[local_vector_x;local_vector_y];
disp('done')
%% generate base kenels and aggregate to obtain IMK
[kgm,sig]= im_kgm_generator(TRAIN,TRAIN, 1,[]);

%% train svm
addpath('libsvm'); %% path to libsvm matlab implementation
trainclass = [ones(1,100) -1*ones(1,100)];
num_train = [1:size(kgm,1)];
kernel_train_append = [num_train', kgm];
svm_model = svmtrain(trainclass',kernel_train_append,'-c 1 -t 4');




%%%%%%%% testing 

%generating random 50 test examples

test=rand(39,25,50);
test= num2cell(test,[1 2]);
test=reshape(test,[50,1]);
 
% learn test kernel gram

train=0;
[test] = select_local_vectors(test,D1,D2);
kgm_test = im_kgm_generator(test,TRAIN,0 , sig);
testclass = rand(1,size(kgm_test,1)); % just for implementation of libsvm
num_test = [1:size(kgm_test,1)];
kernel_test_append = [num_test', kgm_test];
[labels,~,decVals] = svmpredict(testclass', kernel_test_append,svm_model);





