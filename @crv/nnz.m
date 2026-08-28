% Returns the number of non-zero elements of the CRV object
%
% m.keitel@soton.ac.uk
% ilya.kuprov@weizmann.ac.il

function n = nnz(A)
    
    % Count unique index pairs in the
    % row and column index arrays
    n=numunique([A.row A.col],'rows');
    
end

