function [Accuracy, TestConfusion, EstimatedTestClasses] =runTrainTest( train, test )
tic;
N=36; % No. of Filter Responses 
K=15;
L=2;
alpha=100;
filterBank=createFilterBank();
createTextonLibrary;
prepareTrain;
prepareTest;
sceneCategorize;
toc;
end
