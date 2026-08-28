% Vertical Concatenation [A; B]
%
% m.keitel@soton.ac.uk

function obj1=vertcat(obj1,obj2)
    if obj1.numCols~=obj2.numCols
        error('Column counts must match for vertical concatenation.');
    end
    if obj1.isGPU&&~obj2.isGPU
        obj2.col=gpuArray(obj2.col);
        obj2.row=gpuArray(obj2.row);
        obj2.val=gpuArray(obj2.val);
    elseif ~obj1.isGPU&&obj2.isGPU
        obj1.col=gpuArray(obj1.col);
        obj1.row=gpuArray(obj1.row);
        obj1.val=gpuArray(obj1.val);
        obj1.isGPU=true;
    end
    obj2.row=obj2.row+obj1.numRows;
    obj1.col=[obj1.col;obj2.col];
    obj1.row=[obj1.row;obj2.row];
    obj1.val=[obj1.val;obj2.val];
    obj1.numRows=obj1.numRows+obj2.numRows;
end