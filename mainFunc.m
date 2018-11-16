path='/home/akansha/Desktop/ourSC/MSRA1000/x/';
filePattern=fullfile(path,'*.jpg');
jpeg=dir(filePattern);
for i=988:size(jpeg) 
    
    I=imread(jpeg(i).name);
    [rows cols dim]=size(I);
    s=size(jpeg(i));
    pathN=strcat(path,jpeg(i).name);
    [pathstr,name,ext] = fileparts(pathN);
    
    img=filterImageByProposal(I,name,50);
    
    M=getSeamRemovalMap(img,cols/2);
    I=verticalSeamCut(I,M);
    img=verticalSeamCut(img,M);
    
    Y=permute(img,[2,1,3]);
    M=getSeamRemovalMap(Y,rows/2);
    Y=permute(I,[2,1,3]);
    Y=permute(verticalSeamCut(Y,M),[2,1,3]);
    
    disp(name);
    imwrite(Y,strcat(name,(111),'.jpg'),'jpg');
    
%     I=imread(jpeg(i).name);
%     [rows cols dim]=size(I);
%     pathN=strcat(path,jpeg(i).name);
%     [pathstr,name,ext] = fileparts(pathN);
%     
%     img=filterImageByProposal(I,name,10);
%     
%     M=getSeamRemovalMap(img,cols*1/2);
%     I=verticalSeamCut(I,M);
%     img=verticalSeamCut(img,M);
%    
%     Y=permute(img,[2,1,3]);
%     M=getSeamRemovalMap(Y,rows*1/2);
%     Y=permute(I,[2,1,3]);
%     Y=permute(verticalSeamCut(Y,M),[2,1,3]);
%     
% %     figure;
% %     imshow(Y);
%     imwrite(Y,strcat(name,(98),'.jpg'),'jpg');
end
