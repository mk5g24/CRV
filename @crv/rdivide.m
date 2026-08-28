% Scalar multiplication
%
% m.keitel@soton.ac.uk

function obj=rdivide(obj,scalar)
    if isnumeric(scalar)&&isscalar(scalar)
        scalar=1/scalar;
        obj.val=obj.val*scalar;
    else
        error('Multiplication is only defined for scalar values.');
    end
end