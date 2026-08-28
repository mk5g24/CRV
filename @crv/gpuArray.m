% Transfers object ot the GPU
%
% m.keitel@soton.ac.uk

function obj=gpuArray(obj)

if ~obj.isGPU
    obj.row=gpuArray(obj.row);
    obj.col=gpuArray(obj.col);
    obj.val=gpuArray(obj.val);
    obj.isGPU=true;
end

end