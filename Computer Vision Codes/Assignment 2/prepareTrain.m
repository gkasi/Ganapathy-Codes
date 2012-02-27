T=size(train.files,2);
H=(K/3)*(4^(L+1)-1);
TrainHistograms=zeros(H,T);
disp(' ');
disp(' ');
for i=1:T
    I=imread(char(strcat('Dataset\' ,train.files(i))));
    [textonMap, textonHisto] = textonify(I, filterBank, TextonLibrary);
    [histPyramid, vecHistPyramid] = createSpatialPyramid(textonMap, K, L);
    TrainHistograms(:,i)=vecHistPyramid;
    disp(['Loading TrainHistograms...... ',num2str(i),'/',num2str(T)]);
end

save TrainHistograms.mat TrainHistograms
