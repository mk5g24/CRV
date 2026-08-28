% Scalar multiplication
%
% m.keitel@soton.ac.uk

function obj=times(scalar,obj)
    if isnumeric(scalar)&&isscalar(scalar)
        obj.val=obj.val*scalar;
    else
        error('Multiplication is only defined for scalar values.');
    end
end   