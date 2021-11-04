clc
clear
%% Figure 1 Framework
% Still to do

%% Figure 2 Segmented brain mse curves

etas = [0 1 5 10 15 20 25 30 35 40 45 50];
figure
hold on
x = [0,0];
y = [0,0];
scatter(x,y,'kx')
hold on
l1 = line([5 8.5],[0.346 0.346],'Color','black','LineStyle','-');
scatter(x,y,'k+')
l2 = line([5 8.5],[2.22e-3 2.22e-3],'Color','black','LineStyle','--');
scatter(x,y,'k*')
l3 = line([5 8.5],[0.552 0.552],'Color','black','LineStyle','-.');


load(['DM_TNV_test_', num2eng(etas(1)),'.mat'])
scatter(TNV_datafit^.5,TNV_T1.bm_immse,'rx')
load(['DM_TV_test_', num2eng(etas(1)),'.mat'])
scatter(TV_datafit^.5,TV_T1.bm_immse,'bx')

load(['DM_TNV_test_', num2eng(etas(1)),'.mat'])
scatter(TNV_datafit^.5,TNV_T2.bm_immse,'r+')
load(['DM_TV_test_', num2eng(etas(1)),'.mat'])
scatter(TV_datafit^.5,TV_T2.bm_immse,'b+')

load(['DM_TNV_test_', num2eng(etas(1)),'.mat'])
scatter(TNV_datafit^.5,TNV_PD.bm_immse,'r*')
load(['DM_TV_test_', num2eng(etas(1)),'.mat'])
scatter(TV_datafit^.5,TV_PD.bm_immse,'b*')

for eta = etas(2:end)
    load(['DM_TV_test_', num2eng(eta),'.mat'])
    scatter(TV_datafit^.5,TV_T1.bm_immse,'bx')

    load(['DM_TNV_test_', num2eng(eta),'.mat'])
    scatter(TNV_datafit^.5,TNV_T1.bm_immse,'rx')

    load(['DM_TV_test_', num2eng(eta),'.mat'])
    scatter(TV_datafit^.5,TV_T2.bm_immse,'b+')

    load(['DM_TNV_test_', num2eng(eta),'.mat'])
    scatter(TNV_datafit^.5,TNV_T2.bm_immse,'r+')

    load(['DM_TV_test_', num2eng(eta),'.mat'])
    scatter(TV_datafit^.5,TV_PD.bm_immse,'b*')

    load(['DM_TNV_test_', num2eng(eta),'.mat'])
    scatter(TNV_datafit^.5,TNV_PD.bm_immse,'r*')
end
legend('T1','Direct inversion T1', 'T2','Direct inversion T2','PD','Direct inversion PD', ...
    'Interpreter','latex','FontSize',8,"Location", 'southeast')
box on
grid on
xlim([5 7.5])
ylim([0 0.6])
set(gca, 'YScale', 'log')
xlabel('Data-fitting, $|\mathbf{S}-\mathbf{AX}|_2$','Interpreter','latex','FontSize',12)
ylabel('MSE','Interpreter','latex','FontSize',12)
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

%% Figure 3 Table

%% Figure 4 Singular images


load('ground_truth.mat')
load('FBP_imgs.mat')
load('masks.mat')
etas = [0 1 5 10 15 20 25 30 35 40 45 50];

tiledlayout(4,5, 'Padding', 'none', 'TileSpacing', 'compact');
gt = multicontrast;
k=1;
for i = 1:1
    for j = 1:5
        nexttile
        imagesc(brain_mask.*abs(gt(:,:,k)))
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
        imagesc(brain_mask.*abs(FBP(:,:,k)))
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

load(['TV_test_', num2eng(etas(4)),'.mat'])
load(['DM_TV_test_', num2eng(etas(4)),'.mat'])
k = 1;
% figure('Renderer', 'painters', 'Position', [10 10 1600 400])
for i = 1:1
    for j = 1:5
        nexttile
        imagesc(brain_mask.*abs(ubar(:,:,k)))
        title(['TV: ',num2str(k)],'Interpreter','latex','FontSize',8)
%         c = colorbar;
%         c.FontName = 'CMU Serif';
%         c.FontSize = 4;
        set(groot,'defaultAxesTickLabelInterpreter','latex');
        set(groot,'defaulttextinterpreter','latex');
        set(groot,'defaultLegendInterpreter','latex');
        xlabel(['MSE: ',num2eng(TV_si.mse(k))])
        set(gca,'xtick',[],'ytick',[],'ylabel',[]),
        k=k+1;
    end
end

load(['TNV_test_', num2eng(etas(6)),'.mat'])
load(['DM_TNV_test_', num2eng(etas(6)),'.mat'])
k = 1;
for i = 1:1
    for j = 1:5
        nexttile
        imagesc(brain_mask.*abs(ubar(:,:,k)))
        title(['TNV: ',num2str(k), ],'Interpreter','latex','FontSize',8)
%         c = colorbar;
%         c.FontName = 'CMU Serif';
%         c.FontSize = 4;
        %axis off
        set(groot,'defaultAxesTickLabelInterpreter','latex');
        set(groot,'defaulttextinterpreter','latex');
        set(groot,'defaultLegendInterpreter','latex');
        xlabel(['MSE: ',num2eng(TNV_si.mse(k))])
        set(gca,'xtick',[],'ytick',[],'ylabel',[]),
        k=k+1;
    end
end
x = flipud(bone);
colormap(x)




%% Figure 5 Parametric maps

etas = [0 1 5 10 15 20 25 30 35 40 45 50];
load('masks.mat')
tiledlayout(4,3, 'Padding', 'none', 'TileSpacing', 'compact'); 
load('FBP_out.mat')
ax1 = nexttile;
imagesc(brain_mask.*abs(out_GT.qmap(:,:,1)))
title('T1 - Ground Truth','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
% xlabel(['MSE: ',num2eng(immse(out_GT.qmap(:,:,1),out_GT.qmap(:,:,1)))])
set(gca,'xtick',[],'ytick',[],'ylabel',[]),
ax2 = nexttile;
imagesc(brain_mask.*abs(out_GT.qmap(:,:,2)))
title('T2 - Ground Truth','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
% xlabel(['MSE: ',num2eng(immse(out_GT.qmap(:,:,2),out_GT.qmap(:,:,2)))])
set(gca,'xtick',[],'ytick',[],'ylabel',[])
ax3 = nexttile;
imagesc(brain_mask.*abs(out_GT.pd))
title('PD - Ground Truth','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
% xlabel(['MSE: ',num2eng(immse(out_GT.pd,out_GT.pd))])
set(gca,'xtick',[],'ytick',[],'ylabel',[])

ax4 = nexttile;
imagesc(brain_mask.*abs(out_FBP.qmap(:,:,1)))
title('T1 - Direct Inverison','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
xlabel(['MSE: ',num2eng(immse(out_FBP.qmap(:,:,1),out_GT.qmap(:,:,1)))])
set(gca,'xtick',[],'ytick',[],'ylabel',[]),
ax5 = nexttile;
imagesc(brain_mask.*abs(out_FBP.qmap(:,:,2)))
title('T2 - Direct Inverison','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
xlabel(['MSE: ',num2eng(immse(out_FBP.qmap(:,:,2),out_GT.qmap(:,:,2)))])
set(gca,'xtick',[],'ytick',[],'ylabel',[])
ax6 = nexttile;
imagesc(brain_mask.*abs(out_FBP.pd))
title('PD - Direct Inverison','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
xlabel(['MSE: ',num2eng(immse(out_FBP.pd,out_GT.pd))])
set(gca,'xtick',[],'ytick',[],'ylabel',[])

load(['DM_TV_test_', num2eng(etas(4)),'.mat'])
ax7 = nexttile;
imagesc(brain_mask.*abs(TV_out_dm.qmap(:,:,1)))
title('T1 - TV','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
xlabel(['MSE: ',num2eng(TV_T1.bm_immse)])
set(gca,'xtick',[],'ytick',[],'ylabel',[]),
ax8 = nexttile;
imagesc(brain_mask.*abs(TV_out_dm.qmap(:,:,2)))
title('T2 - TV','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
xlabel(['MSE: ',num2eng(TV_T2.bm_immse)])
set(gca,'xtick',[],'ytick',[],'ylabel',[])
ax9 = nexttile;
imagesc(brain_mask.*abs(TV_out_dm.pd))
title('PD - TV','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
xlabel(['MSE: ',num2eng(TV_PD.bm_immse)])
set(gca,'xtick',[],'ytick',[],'ylabel',[])

load(['DM_TNV_test_', num2eng(etas(6)),'.mat'])
ax10 = nexttile;
imagesc(brain_mask.*abs(TNV_out_dm.qmap(:,:,1)))
title('T1 - TNV','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
xlabel(['MSE: ',num2eng(TNV_T1.bm_immse)])
set(gca,'xtick',[],'ytick',[],'ylabel',[]),
ax11 = nexttile;
imagesc(brain_mask.*abs(TNV_out_dm.qmap(:,:,2)))
title('T2 - TNV','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
xlabel(['MSE: ',num2eng(TNV_T2.bm_immse)])
set(gca,'xtick',[],'ytick',[],'ylabel',[])
ax12 = nexttile;
imagesc(brain_mask.*abs(TNV_out_dm.pd))
title('PD - TNV','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
xlabel(['MSE: ',num2eng(TNV_PD.bm_immse)])
set(gca,'xtick',[],'ytick',[],'ylabel',[])

colormap(ax1,flipud(hot))
x = rot90(hot,2);
colormap(ax2,x)
colormap(ax3,flipud(bone))
colormap(ax4,flipud(hot))
colormap(ax5,x)
colormap(ax6,flipud(bone))
colormap(ax7,flipud(hot))
colormap(ax8,x)
colormap(ax9,flipud(bone))
colormap(ax10,flipud(hot))  
colormap(ax11,x)
colormap(ax12,flipud(bone))
