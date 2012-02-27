T=size(train.files,2);
GiantFeatureMatrix=zeros(alpha*T,N);
for i=1:T
    I=imread(char(strcat('Dataset\' ,train.files(i))));
    filterResponses=extractFilterResponses(I,filterBank);
    x=randperm(256);
    y=randperm(256);
   for j=1:alpha
       for k=1:N
           GiantFeatureMatrix((i-1)*alpha+j,k)=filterResponses(k,x(j),y(j));
       end
   end
   disp(['Loading GiantFeatureMatrix for Image...... ',num2str(i),'/',num2str(T)]);
end
disp(' ');
disp(' ');
disp('Performing K Means Clustering.................');
[res, TextonLibrary] = kmeans(GiantFeatureMatrix, K,'EmptyAction','drop');
save TextonLibrary.mat TextonLibrary