%% TNV regularisation for MRF
clc
clear
% Add folder and subfolders in to the path
addpath(genpath([pwd, '/..']));

% load the MRF dictionary and the corresponding low-rank SVD subspace
% Load pre-compressed according to [McGivney et al 2014, Asslander et al' 2018] using 10 SVD components.
%   dict.D normalised compressed dictionary
%   dict.V low rank subspace
%   dict.lut look up table for T1/T2
%   dict.normD norm of each fingerprint
load('dict.mat');

% Constructing a 2D example
% load the brainweb phantom data comprised of:
%   TSMI: (200x200 image size)x(880 time-points) time-series of magnetisation images
%   T1_GT, T2_GT, PD_GT :associated T1, T2, PD ground truth
load('ground_truth.mat')
mat_of_contrasts = double(mat_of_contrasts);
% Build a radial trajectory
% Single spoke taken at each read out (i.e. 880 spokes)
nt = 880;
Nx = 200;
Ny = Nx;

GoldenAngle = pi/((sqrt(5.)+1)/2);
kr = pi *  (-1+1/Nx:1/Nx:1).';
phi = (0:nt-1)*GoldenAngle;
k = [];
k(:,2,:) = kr * sin(phi);
k(:,1,:) = kr * cos(phi);

load('data.mat')
ELR_dcomp = LR_nuFFT_operator(k, [Nx Ny], dict.V, [], 2,[],[],dcomp);

%% Perform TV reconstruction

for eta = sqrt([50 45 40 35 30 25 20 15 10 5 1 0])
    maxit  = 30000;
    theta = 1;
    sig = 0.35;
    tau = 0.35;
    
    % initializations
    sizeImg = [200 200 10];
    
    ubar = ELR_dcomp'*data;
    u0 = ubar;
    
    z0 = Op_grad(ubar, zeros([sizeImg(1), sizeImg(2), sizeImg(3), 2]));
    q0 = data;
    
    data_fit_func = zeros(maxit,1);
    tv_norm_func = zeros(maxit,1);
    %===========MAIN PDHG TNV; Algorithm 2 from the paper
    for i = 1:maxit
        % q(k+1)
        q1 = proximal_map(q0 + sig * (ELR_dcomp*ubar - data), eta, sig);
        % z(k+1) = \Pi_{S/N}
        z1 = NnTV(z0 + sig * Op_grad(ubar, z0));
        % u(k+1)
        u1 = u0 - tau*(Op_div(z1, ubar) + ELR_dcomp'*q1);
        % ubar(k+1)
        ubar = u1 + theta*(u1-u0);
        data_fit_func(i) = norm(ELR_dcomp*ubar-data)^2;
        tv_norm_func(i) = tv_norm(ubar, z1);
        
        if mod(i,100) == 0
            disp(eta)
            disp(i)
            disp(data_fit_func(i))
            disp(tv_norm_func(i))
        end

        u0 = u1;
        q0 = q1;
        z0 = z1;
    end
    save(['TV_test_', num2eng(eta^2),'.mat'],'ubar', 'data_fit_func','tv_norm_func')
end
%%

function sum_s = tv_norm(u, z)
Z = Op_grad(u,z);
sum_s = sum(abs(Z(:)));
end

function g = Op_grad(u, g)
for i = 1 : size(g, 3)
    g(:,:,i,:) = Grad2D(u(:,:,i),squeeze(g(:,:,1,:)));
end
end

function u = Op_div(g, u)
for i = 1 : size(g, 3)
    u(:,:,i) = Div2D(squeeze(g(:,:,i,:)),u(:,:,1));
end
end