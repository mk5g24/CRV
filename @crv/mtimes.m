% Matrix Multiplication
%
% m.keitel@soton.ac.uk

function result=mtimes(a,b)
    % Case: scalar * crv or crv * scalar
    if isa(a,'crv')&&isscalar(b)&&isnumeric(b)
        a.val=a.val*b;
        result=a;

    elseif isa(b,'crv')&&isscalar(a)&&isnumeric(a)
        b.val=b.val*a;
        result=b;

    % Case: crv * crv
    elseif isa(a,'crv')&&isa(b,'crv')
        if a.numCols~=b.numRows
            error('Inner matrix dimensions must agree.');
        end
        result=sparse(a)*sparse(b);

    % Case: crv * sparse
    elseif isa(a,'crv')&&issparse(b)
        if a.numCols~=size(b,1)
            error('Inner matrix dimensions must agree.');
        end
        result=sparse(a)*b;
    elseif issparse(a)&&isa(b,'crv')
        if size(a,2)~=b.numRows
            error('Inner matrix dimensions must agree.');
        end
        result=a*sparse(b);
    else
        error('Unsupported input types for mtimes.');
    end

end