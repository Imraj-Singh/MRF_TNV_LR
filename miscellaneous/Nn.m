function [Nnout] = Nn(Z)
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

Nnout = Proj_P(Z);
end

function p = Proj_P(x) % Prox_nuclear_unit_sphere
[S, V] = SV_decomp(x);

% compute T = V * S^{-1} S_new V'
% singular values
snew1 = S(:,:,1);
snew2 = S(:,:,2);
% threshold values
snew1(S(:,:,1)>1) = 1;
snew2(S(:,:,2)>1) = 1;

% invert singular values
eps = 1e-16;

sinv1 = 1./S(:,:,1);
sinv2 = 1./S(:,:,2);

sinv1(S(:,:,1) < eps) = 0;
sinv2(S(:,:,2) < eps) = 0;

% compute G = S^{-1} S_new
g1 = snew1 .* sinv1;
g2 = snew2 .* sinv2;

% Expand V out
v11 = V(:,:,1,1);
v12 = V(:,:,1,2);
v21 = V(:,:,2,1);
v22 = V(:,:,2,2);

t = V;
t(:, :, 1, 1) = g1 .* v11 .* conj(v11) + g2 .* v12 .* conj(v12) ;
t(:, :, 2, 1) = g1 .* v21 .* conj(v11) + g2 .* v22 .* conj(v12) ;
t(:, :, 1, 2) = g1 .* v11 .* conj(v21) + g2 .* v12 .* conj(v22) ;
t(:, :, 2, 2) = g1 .* v21 .* conj(v21) + g2 .* v22 .* conj(v22) ;

% compute p = A * T
p = x; % compute V * S
for i = 1 : size(x, 3)
    for j = 1 : 2
        p(:,:,i,j) = 0;
        for k = 1 : 2
            p(:,:,i,j) = p(:,:,i,j) + x(:, :, i, k) .* t(:, :, k, j);
        end
    end
end


end

