% Convert to sparse matrix
%
% m.keitel@soton.ac.uk

function S=sparse(obj)

    if isempty(obj.col)
        S=sparse(int32(obj.numRows),int32(obj.numCols));
    else
        S=sparse(obj.row,obj.col,obj.val,obj.numRows,obj.numCols);
    end
    
end