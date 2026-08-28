% Kronecker Product of crv objects
%
% m.keitel@soton.ac.uk

function result=kron(A,B)
    if ~isa(A,'crv')||~isa(B,'crv')
        error('Both inputs must be CRV objects');
    end

    % Compute new dimensions
    newRows=A.numRows*B.numRows;
    newCols=A.numCols*B.numCols;

    % Cartesian product of row/col indices and value multiplication
    % Ensure everything is on GPU
    if ~A.isGPU&&B.isGPU
        A=gpuArray(A);
    end
    if ~B.isGPU&&A.isGPU
        B=gpuArray(B);
    end
    [aRow,aCol,aVal]=deal(A.row,A.col,A.val);
    [bRow,bCol,bVal]=deal(B.row,B.col,B.val);

    [ia,ib]=ndgrid(1:length(aVal),1:length(bVal));
    ia=ia(:);ib=ib(:);

    newRow=(aRow(ia)-1)*B.numRows+bRow(ib);
    newCol=(aCol(ia)-1)*B.numCols+bCol(ib);
    newVal=aVal(ia).*bVal(ib);

    result=crv(newCol,newRow,newVal);
    result.numRows=newRows;
    result.numCols=newCols;
    result.isGPU=A.isGPU||B.isGPU;
end
