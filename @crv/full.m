% Convert to full matrix
%
% m.keitel@soton.ac.uk

function S=full(obj)

    % Generate the sparse matrix and then make it full
    S=full(sparse(obj));

end