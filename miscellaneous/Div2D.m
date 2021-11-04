function div = Div2D(p, div)
% Adj_Gradient2D_forward_constant_unitstep
%   div = Adj_Gradient2D_forward_constant_unitstep(p, div) computes the 
% adjoint of Gradient2D_forward_constant_unitstep. This is in principle the 
% divergence with backward differences and zero boundary conditions but differs 
% at the positive boundary. The pixels are assumed to be of unit size.
%
% Input:    
%   p [matrix]              
%       vector-valued function
%   div [matrix; DEFAULT = zeros]              
%       dummy variable for initialization
%
% Output:
%   div [matrix]
%       scalar-valued divergence
%
% See also: Gradient2D_forward_constant_unitstep
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

    if nargin < 2; 
        s_p = size(p);
        div = zeros(s_p(1:2));
    end

    div(1,:) = -p(1,:,1);
    div(end,:) = p(end-1,:,1);
    div(2:end-1,:) = -p(2:end-1,:,1)+p(1:end-2,:,1);

    div(:,1) = div(:,1) - p(:,1,2);
    div(:,end) = div(:,end) + p(:,end-1,2);
    div(:,2:end-1) = div(:,2:end-1) - p(:,2:end-1,2) + p(:,1:end-2,2);

end