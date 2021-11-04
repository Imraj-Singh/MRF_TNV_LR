clc
clear

tiledlayout(4,3, 'Padding', 'none', 'TileSpacing', 'compact'); 
load('FBP_out.mat')
ax1 = nexttile
imagesc(abs(out_GT.qmap(:,:,1)))
title('T1 - Ground Truth','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
% xlabel(['MSE: ',num2eng(immse(out_GT.qmap(:,:,1),out_GT.qmap(:,:,1)))])
set(gca,'xtick',[],'ytick',[],'ylabel',[]),
ax2 = nexttile
imagesc(abs(out_GT.qmap(:,:,2)))
title('T2 - Ground Truth','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
% xlabel(['MSE: ',num2eng(immse(out_GT.qmap(:,:,2),out_GT.qmap(:,:,2)))])
set(gca,'xtick',[],'ytick',[],'ylabel',[])
ax3 = nexttile
imagesc(abs(out_GT.pd))
title('PD - Ground Truth','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
% xlabel(['MSE: ',num2eng(immse(out_GT.pd,out_GT.pd))])
set(gca,'xtick',[],'ytick',[],'ylabel',[])

ax4 = nexttile
imagesc(abs(out_FBP.qmap(:,:,1)))
title('T1 - Direct Inverison','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
xlabel(['MSE: ',num2eng(immse(out_FBP.qmap(:,:,1),out_GT.qmap(:,:,1)))])
set(gca,'xtick',[],'ytick',[],'ylabel',[]),
ax5 = nexttile
imagesc(abs(out_FBP.qmap(:,:,2)))
title('T2 - Direct Inverison','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
xlabel(['MSE: ',num2eng(immse(out_FBP.qmap(:,:,2),out_GT.qmap(:,:,2)))])
set(gca,'xtick',[],'ytick',[],'ylabel',[])
ax6 = nexttile
imagesc(abs(out_FBP.pd))
title('PD - Direct Inverison','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
xlabel(['MSE: ',num2eng(immse(out_FBP.pd,out_GT.pd))])
set(gca,'xtick',[],'ytick',[],'ylabel',[])


etas = [linspace(0,.001,11),0.002,0.003];
load(['DM_tv_test_', num2eng(etas(5)),'.mat'])
ax7 = nexttile
imagesc(abs(out_dm.qmap(:,:,1)))
title('T1 - TV','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
xlabel(['MSE: ',num2eng(immse(out_dm.qmap(:,:,1),out_GT.qmap(:,:,1)))])
set(gca,'xtick',[],'ytick',[],'ylabel',[]),
ax8 = nexttile
imagesc(abs(out_dm.qmap(:,:,2)))
title('T2 - TV','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
xlabel(['MSE: ',num2eng(immse(out_dm.qmap(:,:,2),out_GT.qmap(:,:,2)))])
set(gca,'xtick',[],'ytick',[],'ylabel',[])
ax9 = nexttile
imagesc(abs(out_dm.pd))
title('PD - TV','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
xlabel(['MSE: ',num2eng(immse(out_dm.pd,out_GT.pd))])
set(gca,'xtick',[],'ytick',[],'ylabel',[])

etas1 = [5 10 15 20 25 30 35 40 45 50 55 60 65 70];
load(['DM_test_', num2eng(etas1(8)),'.mat'])
ax10 = nexttile
imagesc(abs(out_dm.qmap(:,:,1)))
title('T1 - TNV','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
xlabel(['MSE: ',num2eng(immse(out_dm.qmap(:,:,1),out_GT.qmap(:,:,1)))])
set(gca,'xtick',[],'ytick',[],'ylabel',[]),
ax11 = nexttile
imagesc(abs(out_dm.qmap(:,:,2)))
title('T2 - TNV','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
xlabel(['MSE: ',num2eng(immse(out_dm.qmap(:,:,2),out_GT.qmap(:,:,2)))])
set(gca,'xtick',[],'ytick',[],'ylabel',[])
ax12 = nexttile
imagesc(abs(out_dm.pd))
title('PD - TNV','Interpreter','latex','FontSize',8)
% c = colorbar;
% c.FontName = 'CMU Serif';
% c.FontSize = 8;
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
xlabel(['MSE: ',num2eng(immse(out_dm.pd,out_GT.pd))])
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