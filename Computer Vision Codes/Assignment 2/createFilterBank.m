function [filterBank]=createFilterBank()
filterBank=cell(12,1);
for i=1:4
    filterBank{i}=fspecial('gaussian',[9 9],0.5*i);
    subplot(3,4,i)
    imagesc(filterBank{i});
    title(['Gaussian (Sigma = ',num2str(0.5*i),')']);
end

str=['y' 'x'];

for i=5:8
    if mod(i,2) ==0
    filterBank{i}=diff(fspecial('gaussian',[9 9],0.25*(i-6)+0.5));
    else
     filterBank{i}=diff(fspecial('gaussian',[9 9],0.25*(i-5)+0.5))';   
    end
    subplot(3,4,i)
    imagesc(filterBank{i});
    title(['DoG ',str(mod(i,2)+1),'-direction (Sigma = ',num2str(0.25*(i-6)+0.5+0.25*mod(i,2)),')']);  
end

for i=9:12
    filterBank{i}=-fspecial('log',[9 9],0.5*(i-8));
    subplot(3,4,i)
    imagesc(filterBank{i});
    title(['LoG (Sigma = ',num2str(0.5*(i-8)),')']);
end
end

