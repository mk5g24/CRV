% Returns conjugate transpose of CRV object
%
% m.keitel@soton.ac.uk

function obj=ctranspose(obj)

    bin=obj.row;
    obj.row=obj.col;
    obj.col=bin;
    obj.val=conj(obj.val);

end