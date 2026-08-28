% Gather object from the GPU
%
% m.keitel@soton.ac.uk

function obj=gather(obj)

if obj.isGPU
    obj.row=gather(obj.row);
    obj.col=gather(obj.col);
    obj.val=gather(obj.val);
    obj.isGPU=false;
end

end