% Creates an object of a crv class. Syntax:
%
%                          p=crv(Mat) or
%                          p=crv(Dim1,Dim2) or
%                          p=crv(C,R,V)
%
% crv (column, row, value) is a special format for storing and adding large
% sparse matrices.
%
% Parameters:
% 
%        Mat - Sparse Matrix
%        Dim1,Dim2 - Empty Matrix Object with Size Dim1xDim2
%        C,R,V - Matrix with entries in columns C, rows R with values V
%
% Outputs:
%
%         crv - An object that behaves like a sparse matrix
%
% m.keitel@soton.ac.uk

classdef (InferiorClasses={?gpuArray}) crv

    properties
        col=int64([]);     % Column indices (int64)
        row=int64([]);     % Row indices (int64)
        val=double([]);    % Values (double)
        numRows=int64(0);  % Number of rows in the original matrix
        numCols=int64(0);  % Number of columns in the original matrix
        isGPU=false;       % Flag indicating if stored on GPU
    end

    methods

        function obj=crv(varargin)
            if nargin==1
                % Case: Single argument
                input=varargin{1};
                if isa(input,'crv')
                    obj=input;
                elseif isnumeric(input)||issparse(input)||isa(input,'gpuArray')
                    % Convert matrix to CRV format
                    obj.isGPU=isa(input,'gpuArray');
                    obj.numRows=int64(size(input,1));
                    obj.numCols=int64(size(input,2));
                    [row,col,val]=find(input);
                    if obj.isGPU
                        obj.col=gpuArray(int64(col(:)));
                        obj.row=gpuArray(int64(row(:)));
                        obj.val=gpuArray(double(val(:)));
                    else
                        obj.col=int64(col(:));
                        obj.row=int64(row(:));
                        obj.val=double(val(:));
                    end
                else
                    error('CRV:InvalidInput','Single argument must be a numeric matrix.');
                end

            elseif nargin==2
                % Case: Two arguments (numRows, numCols)
                numRows=varargin{1};
                numCols=varargin{2};
                if isnumeric(numRows)&&isnumeric(numCols)&&isscalar(numRows)&&isscalar(numCols)
                    obj.numRows=int64(numRows);
                    obj.numCols=int64(numCols);
                    obj.col=int64([]);
                    obj.row=int64([]);
                    obj.val=double([]);
                    obj.isGPU=false;
                else
                    error('CRV:InvalidInput','Two arguments must be numeric scalars specifying matrix dimensions.');
                end

            elseif nargin==3
                % Case: Three arguments (col, row, val vectors)
                col=varargin{1};
                row=varargin{2};
                val=varargin{3};

                if isnumeric(col)&&isnumeric(row)&&isnumeric(val)&&...
                        isvector(col)&&isvector(row)&&isvector(val)&&...
                        numel(col)==numel(row)&&numel(row)==numel(val)

                    obj.col=int64(col(:));
                    obj.row=int64(row(:));
                    obj.val=double(val(:));
                    obj.numRows=max(int64(row)); % Infer dimensions from max indices
                    obj.numCols=max(int64(col));
                    obj.isGPU=false; % Assume CPU unless vectors are GPU arrays

                    if isa(col,'gpuArray')||isa(row,'gpuArray')||isa(val,'gpuArray')
                        obj.col=gpuArray(obj.col);
                        obj.row=gpuArray(obj.row);
                        obj.val=gpuArray(obj.val);
                        obj.isGPU=true;
                    end
                else
                    error('CRV:InvalidInput','Three arguments must be numeric vectors of the same length.');
                end

            else
                error('CRV:InvalidInput','Invalid number of arguments. Use 1 (matrix), 2 (dimensions), or 3 (CRV vectors).');
            end
        end

        % Crv-matrices are numeric
        function answer=isnumeric(obj) %#ok<MANU>
    
            answer=true(); % Always
    
        end
    
        % Crv-matrices are matrices
        function answer=ismatrix(obj) %#ok<MANU>
    
            answer=true(); % Always
    
        end
    
        % Crv-matrices are floats
        function answer=isfloat(obj) %#ok<MANU>
    
            answer=true(); % Always
    
        end

    end

end