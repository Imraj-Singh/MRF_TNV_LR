function grad = Grad2D(u, grad)
% Gradient2D_forward_constant_unitstep
%   grad = Gradient2D_forward_constant_unitstep(u, grad) computes the gradient 
% in two dimensions of an image u with forward finite differences and constant
% boundary conditions. The pixels are of unit size.
%
% Input:    
%   u [matrix]              
%       scalar-valued function
%
%   grad [matrix; DEFAULT = zeros]              
%       dummy variable for initialization
%
% Output:
%   grad [matrix]
%       vector-valued gradient
%
% See also: nAdj_Gradient2D_forward_constant_unitstep
%
% -------------------------------------------------------------------------
%   changes:
% 
% 2015-10-14 --------------------------------------------------------------
% Matthias J. Ehrhardt
% CMIC, University College London, UK 
% matthias.ehrhardt.11@ucl.ac.uk
% http://www.cs.ucl.ac.uk/staff/ehrhardt/software.html
%
% -------------------------------------------------------------------------
% Copyright 2015 University College London
%
% Licensed under the Apache License, Version 2.0 (the "License");
% you may not use this file except in compliance with the License.
% You may obtain a copy of the License at
%
%   http://www.apache.org/licenses/LICENSE-2.0
%
% Unless required by applicable law or agreed to in writing, software
% distributed under the License is distributed on an "AS IS" BASIS,
% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
% See the License for the specific language governing permissions and
% limitations under the License.
% -------------------------------------------------------------------------

    if nargin < 2
        grad = zeros([size(u) 2]);
    else
        grad(end,:,1) = 0;
        grad(:,end,2) = 0;    
    end
    
    grad(1:end-1,:,1) = u(2:end,:) - u(1:end-1,:);
    grad(:,1:end-1,2) = u(:,2:end) - u(:,1:end-1);

end