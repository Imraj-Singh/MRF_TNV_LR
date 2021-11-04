function [Nnout] = NnTV(Z)
%Nn 2 Dimensional projection operator
%   Usage:  [DJtv] = Nn(I)
%           [DJtv] = Nn(I, wx, wy)
%
%   Input parameters:
%         I     : Input data [Nx, Ny, L]
%
%   Output parameters:
%         dx    : Gradient along x
%         dy    : Gradient along y
%
% Author: Imraj Singh 09 June 2021
Nnout = Z;
for i = 1:10
    x = squeeze(Z(:,:,i,:));
    nx = max(1,abs(sqrt(sum(x.*conj(x),3))));
    x(:,:,1) = x(:,:,1) ./ nx;
    x(:,:,2) = x(:,:,2) ./ nx;
    Nnout(:,:,i,:) = x;
end

end

