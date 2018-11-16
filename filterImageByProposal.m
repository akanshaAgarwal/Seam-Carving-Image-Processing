function I = filterImageByProposal(I,name,proposalNum)

% IMAGE FILTERING--------------------------------------------------
proposalData = load(strcat('/SalPropboxes/',name,'.mat'));

x1=proposalData.boxes(:,1);
y1=proposalData.boxes(:,2);
x2=proposalData.boxes(:,3);
y2=proposalData.boxes(:,4);

if(proposalNum<1 || proposalNum>100)
    set(handles.proposals,'String',num2str(3));
    return
end

clear imgMatrix;

imgR=I(:,:,1);
imgG=I(:,:,2);
imgB=I(:,:,3);

%filter-------------------------------------------------------------

for i=1:proposalNum
    
%     for c=x1(i)+1:x2(i)+1
%         for r=y1(i)+1:y2(i)+1
%             imgR(r,c)=imgR(r,c)*1.35;
%             imgG(r,c)=imgG(r,c)*1.35;
%             imgB(r,c)=imgB(r,c)*1.35;
%             if(imgR(r,c)>255)
%                 imgR(r,c)=255;
%             end
%             if(imgG(r,c)>255)
%                 imgG(r,c)=255;
%             end
%             if(imgB(r,c)>255)
%                 imgB(r,c)=255;
%             end
%             
%         end
%     end
    
    c = [x1(i) x2(i) x2(i) x1(i)];
    r = [y1(i) y1(i) y2(i) y2(i)];
    
    R1 = roipoly(imgR,c,r);
    G1 = roipoly(imgG,c,r);
    B1 = roipoly(imgB,c,r);
    
    H = fspecial('unsharp');
    %H=imadjust(255,[0.7 0.9],[0.8 0.9]);
    
    red = roifilt2(H,imgR,R1);
    green = roifilt2(H,imgG,G1);
    blue = roifilt2(H,imgB,B1);
    
    imgR=red;
    imgG=green;
    imgB=blue;
    
end
    
imgMatrix(:,:,1)=imgR;
imgMatrix(:,:,2)=imgG;
imgMatrix(:,:,3)=imgB;
I=imgMatrix;
