% Returns transpose of CRV object
%
% m.keitel@soton.ac.uk

function obj=transpose(obj)

    bin=obj.row;
    obj.row=obj.col;
    obj.col=bin;

end