% Horizontal Concatenation [A, B]
%
% m.keitel@soton.ac.uk

function obj=horzcat(obj,obj2)
    if obj.numRows~=obj2.numRows
        error('Row counts must match for horizontal concatenation.');
    end
    if obj.isGPU&&~obj2.isGPU
        obj2.col=gpuArray(obj2.col);
        obj2.row=gpuArray(obj2.row);
        obj2.val=gpuArray(obj2.val);
        obj2.isGPU=true;
    elseif ~obj.isGPU&&obj2.isGPU
        obj.col=gpuArray(obj.col);
        obj.row=gpuArray(obj.row);
        obj.val=gpuArray(obj.val);
        obj.isGPU=true;
    end
    obj2.col=obj2.col+obj.numCols;
    obj.col=[obj.col;obj2.col];
    obj.row=[obj.row;obj2.row];
    obj.val=[obj.val;obj2.val];
    obj.numCols=obj.numCols+obj2.numCols;
end