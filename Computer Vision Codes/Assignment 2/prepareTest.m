T=size(test.files,2);
H=(K/3)*(4^(L+1)-1);
TestHistograms=zeros(H,T);
for i=1:T
    I=imread(char(strcat('Dataset\' ,test.files(i))));
    [textonMap, textonHisto] = textonify(I, filterBank, TextonLibrary);
    [histPyramid, vecHistPyramid] = createSpatialPyramid(textonMap, K, L);
    TestHistograms(:,i)=vecHistPyramid;
    disp(['Loading TestHistograms...... ',num2str(i),'/',num2str(T)]);
end

save TestHistograms.mat TestHistograms
