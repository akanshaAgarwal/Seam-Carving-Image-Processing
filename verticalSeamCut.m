function image = verticalSeamCut (image , seamMatrix);

[rows cols dim]=size(image);
[Mrows Mcols Mdim]=size(seamMatrix);

% disp(rows);
% disp(Mrows);
if rows~=Mrows
    error('SeamMatrix and image dimension mismatch');
end

for k=1:Mcols              %goes through set of seams
    for i=1:dim             %if rgb, goes through each channel
        for j=1:rows        %goes through each row in image
            if seamMatrix(j,k)==1
                CutImg(j,:,i)=[image(j,2:cols,i)];
            elseif seamMatrix(j,k)==cols
                CutImg(j,:,i)=[image(j,1:cols-1,i)];
            else
                CutImg(j,:,i)=[image(j,1:seamMatrix(j,k)-1,i) image(j,seamMatrix(j,k)+1:cols,i)];
            end
        end
    end
    image=CutImg;
    clear CutImg;
    [rows cols dim]=size(image);
end