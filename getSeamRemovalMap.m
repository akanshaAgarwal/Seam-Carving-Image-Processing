function seamMatrix = getSeamRemovalMap (image,column);

%This function gives us the map which contains information of all the
%vertical seams to be removed

[rows cols dim] = size(image);
energy=findEnergy(image);

for i = 1:min(column,cols-1)
    
    %find the cumulative energy map for the energy gradient
    cumEnergy = findSeamImg (energy);
    
    % After obtaining the cumulative energies,we select the seam with
    % lowest energy
    
    seamMatrix(:,i) = seamWithLowestEnergy (cumEnergy);
    
    % Now we remove the seam from the image
    image = verticalSeamCut (image , seamMatrix(:,i));
    energy = verticalSeamCut (energy , seamMatrix(:,i));
    
    % Update the size of new image after seam cut
    [rows cols dim]=size(image);
    
end

    