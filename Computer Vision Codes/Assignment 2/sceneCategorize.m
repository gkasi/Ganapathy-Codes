T=size(test.files,2);
EstimatedTestClasses=zeros(size(TestHistograms,2),1);
CorrectTestClasses=zeros(size(TestHistograms,2),1);
count=0;
histInter=zeros(T,size(train.files,2));

for i=1:T
    histInter(i,:)=distanceToSet(TestHistograms(:,i),TrainHistograms);
    [~,index]=max(histInter(i,:));
    EstimatedTestClasses(i,1)=train.classes(index);
    CorrectTestClasses(i,1)=test.classes(i);
    if CorrectTestClasses(i,1)==EstimatedTestClasses(i,1)
        count=count+1;
    end
    disp(['Estimating Class for Test Image...... ',num2str(i),'/',num2str(T)]);
end

Accuracy=100*count/T;
disp(['Accuracy..... ',num2str(Accuracy),'%']);

disp('Confusion Matrix');
TestConfusion=confusionmat(CorrectTestClasses,EstimatedTestClasses);
disp(TestConfusion);

save TestResults.mat Accuracy TestConfusion EstimatedTestClasses





        
    