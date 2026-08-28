% Addition of CRV-CRV, CRV-Sparse and CRV-Scalar
%
% m.keitel@soton.ac.uk

function result=plus(a,b)
    % Case crv + scalar and scalar + crv
    if isa(a,'crv')&&isscalar(b)&&isnumeric(b)
        a.val=a.val+b;
        result=a;
    elseif isa(b,'crv')&&isscalar(a)&&isnumeric(a)
        b.val=b.val+a;
        result=b;    

    % Case crv + crv
    elseif isa(a,'crv')&&isa(b,'crv')
        if a.numRows~=b.numRows||a.numCols~=b.numCols
            error('Matrix sizes must match for addition.');
        end
        if a.isGPU&&~b.isGPU
            b.col=gpuArray(b.col);
            b.row=gpuArray(b.row);
            b.val=gpuArray(b.val);
        elseif ~a.isGPU&&b.isGPU
            a.col=gpuArray(a.col);
            a.row=gpuArray(a.row);
            a.val=gpuArray(a.val);
            a.isGPU=true;
        end
        a.col=[a.col;b.col];
        a.row=[a.row;b.row];
        a.val=[a.val;b.val];
        result=a;

    % Case crv + sparse and sparse + crv
    elseif isa(a,'crv')&&issparse(b)
        if a.numRows~=size(b,1)||a.numCols~=size(b,2)
            error('Matrix sizes must match for addition.');
        end        
        b=crv(b);
        result=plus(a,b);
    elseif isa(b,'crv')&&issparse(a)
        if b.numRows~=size(a,1)||b.numCols~=size(a,2)
            error('Matrix sizes must match for addition.');
        end        
        a=crv(a);
        result=plus(a,b);
    else
        error('Unsupported input types for plus.');
    end
end