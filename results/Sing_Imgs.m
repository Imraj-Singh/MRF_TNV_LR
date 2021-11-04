%% TNV regularisation for MRF
clc
clear
% Add folder and subfolders in to the path
addpath('fessler_nufft\');

load('dict.mat');

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

% Simulate k-space measurements (create experimental data)
E = LR_nuFFT_operator(k, [Nx Ny], [], [], 2);
% Sample k-space measurements across temporal frames:

% Construct low rank nuFFT Operator [Asslaender et al'2018]
% Density compensation
dcomp = col(l2_norm(k,2));


ELR = LR_nuFFT_operator(k, [Nx Ny], dict.V, [], 2,[],[],ones(size(dcomp)));
ELR_dcomp = LR_nuFFT_operator(k, [Nx Ny], dict.V, [], 2,[],[],dcomp);

E_dcomp = LR_nuFFT_operator(k, [Nx Ny], [], [], 2,[],[],dcomp);


load('data.mat')
% %% FBP
FBP = ELR_dcomp' * data;
FBP_2 = E_dcomp'*data;
k = 1;

etas = [linspace(0,.001,11),0.002,0.003];
etas1 = [5 10 15 20 25 30 35 40 45 50 55 60 65 70];

N = 200;
gt = zeros(N,N,10);
for i=1:N
    for j =1:N
        gt(i,j,:) = dict.V'*squeeze(mat_of_contrasts(i,j,:));
    end
end

%%


tiledlayout(4,5, 'Padding', 'none', 'TileSpacing', 'compact'); 

k=1;
for i = 1:1
    for j = 1:5
        nexttile
        imagesc(abs(gt(:,:,k)))
        title(['Ground Truth: ',num2str(k)],'Interpreter','latex','FontSize',8)
%         c = colorbar;
%         c.FontName = 'CMU Serif';
%         c.FontSize = 4;
        set(groot,'defaultAxesTickLabelInterpreter','latex');
        set(groot,'defaulttextinterpreter','latex');
        set(groot,'defaultLegendInterpreter','latex');
        set(gca,'xtick',[],'ytick',[],'ylabel',[]),
        k=k+1;
    end
end
k=1;
for i = 1:1
    for j = 1:5
        nexttile
        imagesc(abs(FBP(:,:,k)))
        title(['Direct inversion: ',num2str(k)],'Interpreter','latex','FontSize',8)
%         c = colorbar;
%         c.FontName = 'CMU Serif';
%         c.FontSize = 4;
        set(groot,'defaultAxesTickLabelInterpreter','latex');
        set(groot,'defaulttextinterpreter','latex');
        set(groot,'defaultLegendInterpreter','latex');
        xlabel(['MSE: ',num2eng(immse(FBP(:,:,k),gt(:,:,k)))])
        set(gca,'xtick',[],'ytick',[],'ylabel',[]),
        k=k+1;
    end
end
% save('FBP_imgs','FBP','FBP_2')
% saveas(gcf,'MRF_FBP_Img','epsc')

load(['TV_test_', num2eng(etas(5)),'.mat'])
k = 1;
% figure('Renderer', 'painters', 'Position', [10 10 1600 400])
for i = 1:1
    for j = 1:5
        nexttile
        imagesc(abs(ubar(:,:,k)))
        title(['TV: ',num2str(k)],'Interpreter','latex','FontSize',8)
%         c = colorbar;
%         c.FontName = 'CMU Serif';
%         c.FontSize = 4;
        set(groot,'defaultAxesTickLabelInterpreter','latex');
        set(groot,'defaulttextinterpreter','latex');
        set(groot,'defaultLegendInterpreter','latex');
        xlabel(['MSE: ',num2eng(immse(ubar(:,:,k),gt(:,:,k)))])
        set(gca,'xtick',[],'ytick',[],'ylabel',[]),
        k=k+1;
    end
end
% saveas(gcf,'MRF_Best_TV_Img','epsc')


load(['TNV_test_', num2eng(etas1(8)),'.mat'])
k = 1;
% figure('Renderer', 'painters', 'Position', [10 10 1600 400])
for i = 1:1
    for j = 1:5
        nexttile
        imagesc(abs(ubar(:,:,k)))
        title(['TNV: ',num2str(k), ],'Interpreter','latex','FontSize',8)
%         c = colorbar;
%         c.FontName = 'CMU Serif';
%         c.FontSize = 4;
        %axis off
        set(groot,'defaultAxesTickLabelInterpreter','latex');
        set(groot,'defaulttextinterpreter','latex');
        set(groot,'defaultLegendInterpreter','latex');
        xlabel(['MSE: ',num2eng(immse(ubar(:,:,k),gt(:,:,k)))])
        set(gca,'xtick',[],'ytick',[],'ylabel',[]),
        k=k+1;
    end
end
x = flipud(bone);
colormap(x)
% saveas(gcf,'MRF_Best_TNV_Img','epsc')





