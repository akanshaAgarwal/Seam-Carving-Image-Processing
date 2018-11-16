function SeamVector = seamWithLowestEnergy(x);

% This function gives us the column numbers to be removed

[rows cols]=size(x);
for i=rows:-1:1
    if i==rows
        [value, j]=min(x(rows,:));  %finds min value of last row
    else    %accounts for boundary issues
        if SeamVector(i+1)==1
            Vector=[Inf x(i,SeamVector(i+1)) x(i,SeamVector(i+1)+1)];
        elseif SeamVector(i+1)==cols
            Vector=[x(i,SeamVector(i+1)-1) x(i,SeamVector(i+1)) Inf];
        else
            Vector=[x(i,SeamVector(i+1)-1) x(i,SeamVector(i+1)) x(i,SeamVector(i+1)+1)];
        end
        
        %find min value and index of 3 neighboring pixels in prev. row.
        [Value Index]=min(Vector);
        IndexIncrement=Index-2;
        j=SeamVector(i+1)+IndexIncrement;
    end
    SeamVector(i,1)=j;
end
