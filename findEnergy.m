function Emean=findEnergy(I)
    Emean = (edge(I(:,:,1),'Canny')+edge(I(:,:,2),'Canny')+edge(I(:,:,3),'Canny'))/3;
%     imshow(Emean);
% Emean = (edge(I(:,:,1),'Canny')+edge(I(:,:,2),'Canny')+edge(I(:,:,3),'Canny'))/3;
% Emean = edgesDetect(I);
% figure;
% imshow(Emean);