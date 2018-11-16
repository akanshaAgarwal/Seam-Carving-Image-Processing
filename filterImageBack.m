function I = filterImageBack(I,proposalNum,x1,y1,x2,y2)


clear imgMatrix;

imgR=I(:,:,1);
imgG=I(:,:,2);
imgB=I(:,:,3);
[rows cols dim]=size(I);

%filter-------------------------------------------------------------
for i=1:proposalNum
    for c=x1(i+1)+1:min(x2(i+1)+1,cols)
        for r=y1(i+1)+1:min(y2(i+1)+1,rows)
            imgR(r,c)=imgR(r,c)/(1.02);
            imgG(r,c)=imgG(r,c)/(1.02);
            imgB(r,c)=imgB(r,c)/(1.02);
        end
    end
end
    
imgMatrix(:,:,1)=imgR;
imgMatrix(:,:,2)=imgG;
imgMatrix(:,:,3)=imgB;
I=imgMatrix;