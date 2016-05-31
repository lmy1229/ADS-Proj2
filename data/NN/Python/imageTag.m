function [ tag ] = imageTag( imagename )
%IMAGETAG Summary of this function goes here
%   Detailed explanation goes here

switch imagename(1:9)
    case 'n01613177'
        tag = 1;
    case 'n01923025'
        tag = 2;
    case 'n02278980'
        tag = 3;
    case 'n03767203'
        tag = 4;
    case 'n03877845'
        tag = 5;
    case 'n04515003'
        tag = 6;
    case 'n04583620'
        tag = 7;
    case 'n07897438'
        tag = 8;
    case 'n10247358'
        tag = 9;
    case 'n11669921'
        tag = 10;
    otherwise
        tag = 0;
end

% tag = tag - 1;

end

