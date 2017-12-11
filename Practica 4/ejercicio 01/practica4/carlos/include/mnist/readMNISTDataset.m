function [TrainingDataSet, TestingDataSet] = readMNISTDataset ( TrainImages, TrainLabels, TestImages, TestLabels, NTrain, NTest )
    % readMNISTDataset process the MNIST dataset files to format
    %   [images, labels_bin] where labels_bin are the tags' dataset in
    %   format {-1, 1}. NTrain and NTest are the numbers of examples for
    %   the train and test datasets.
    %   1 < NTrain < 60000
    %   1 < NTest < 10000
    
    if nargin < 5
        NTrain=60000;
        NTest=10000;
    end
    
    fprintf('Reading MNIST Dataset ...\n');
    
    % Read the dataset with NTrain and NTest samples

    % Training dataset
    images_train = loadMNISTImages(TrainImages).';
    labels_train = loadMNISTLabels(TrainLabels);
    images_train = images_train(1:NTrain,:);
    labels_train = labels_train(1:NTrain,:);

    TrainingClasses=zeros(1,10); % Count examples per class
    for i=1:NTrain
        TrainingClasses(labels_train(i)+1) = TrainingClasses(labels_train(i)+1) + 1;
    end

    labels_train_bin=zeros(NTrain,10); % Prepare the dataset labels
    for i=1:NTrain
        labels_train_bin(i,:)=circshift([1 -1*ones(1,9)],[0 labels_train(i)]);
    end
    
    % Testing dataset
    images_test = loadMNISTImages(TestImages).';
    labels_test = loadMNISTLabels(TestLabels);
    images_test = images_test(1:NTest,:);
    labels_test = labels_test(1:NTest,:);
        
    TestingClasses=zeros(1,10); % Count examples per class
    for i=1:NTest
        TestingClasses(labels_test(i)+1)=TestingClasses(labels_test(i)+1) + 1;
    end
       
    labels_test_bin=zeros(NTest,10); % Prepare the dataset labels
    for i=1:NTest
        labels_test_bin(i,:)=circshift([1 -1*ones(1,9)],[0 labels_test(i)]);
    end
    
    A=[TrainingClasses;TestingClasses];
    
    fprintf('Class\t\t 0\t 1\t 2\t 3\t 4\t 5\t 6\t 7\t 8\t 9\t Total\n');
    fprintf('Training:\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\n', ...
        A(1,1),A(1,2),A(1,3),A(1,4),A(1,5),A(1,6),A(1,7),A(1,8),A(1,9),A(1,10),sum(A(1,:)));
    fprintf('Testing:\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\t %d\n', ...
        A(2,1),A(2,2),A(2,3),A(2,4),A(2,5),A(2,6),A(2,7),A(2,8),A(2,9),A(2,10),sum(A(2,:)));

    % Crop dataset
    ColsToDelete=1:28*4;
    for i=5:24
        ColsToDelete=[ColsToDelete (i-1)*28+1:(i-1)*28+4  i*28-3:i*28];
    end
    ColsToDelete=[ColsToDelete 28*24+1:28*28];
    
    TrainingDataSet = [images_train labels_train_bin];
    TestingDataSet = [images_test labels_test_bin];
    TrainingDataSet(:,ColsToDelete)=[];
    TestingDataSet(:,ColsToDelete)=[];
    
end