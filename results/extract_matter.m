clc
clear
% grey and white matter

load('brainweb_phantom.mat')
load('ground_truth.mat')

gm_mask = T1_GT;
gm_mask(T1_GT ~= 1.5450) = 0;
gm_mask(T1_GT == 1.5450) = 1;

wm_mask = T1_GT;
wm_mask(T1_GT ~= 0.8110) = 0;
wm_mask(T1_GT == 0.8110) = 1;

load('ground_truth.mat')

brain_mask = T1_GT;
brain_mask(T1_GT > 0) = 1;

save('masks.mat','gm_mask','wm_mask',"brain_mask")

% gm_T1 = rm_0_vec(gm_mask.*T1);
% gm_T2 = rm_0_vec(gm_mask.*T2);
% gm_PD = rm_0_vec(gm_mask.*PD);
% wm_T1 = rm_0_vec(wm_mask.*T1);
% wm_T2 = rm_0_vec(wm_mask.*T2);
% wm_PD = rm_0_vec(wm_mask.*PD);


%%

etas = [linspace(0,.001,11),0.002,0.003];
etas1 = [5 10 15 20 25 30 35 40 45 50 55 60 65 70];

load(['DM_TV_test_', num2eng(etas(5)),'.mat'])
out_dm.pd = abs(out_dm.pd);
TV_gm_T1 = rm_0_vec(gm_mask.*out_dm.qmap(:,:,1));
TV_gm_T2 = rm_0_vec(gm_mask.*out_dm.qmap(:,:,2));
TV_gm_PD = rm_0_vec(gm_mask.*out_dm.pd);
TV_wm_T1 = rm_0_vec(wm_mask.*out_dm.qmap(:,:,1));
TV_wm_T2 = rm_0_vec(wm_mask.*out_dm.qmap(:,:,2));
TV_wm_PD = rm_0_vec(wm_mask.*out_dm.pd);

load(['DM_test_', num2eng(etas1(8)),'.mat'])
out_dm.pd = abs(out_dm.pd);
TNV_gm_T1 = rm_0_vec(gm_mask.*out_dm.qmap(:,:,1));
TNV_gm_T2 = rm_0_vec(gm_mask.*out_dm.qmap(:,:,2));
TNV_gm_PD = rm_0_vec(gm_mask.*out_dm.pd);
TNV_wm_T1 = rm_0_vec(wm_mask.*out_dm.qmap(:,:,1));
TNV_wm_T2 = rm_0_vec(wm_mask.*out_dm.qmap(:,:,2));
TNV_wm_PD = rm_0_vec(wm_mask.*out_dm.pd);

%%

res_gm_T1_bias = [mean(TV_gm_T1 - gm_T1),mean(TNV_gm_T1 - gm_T1)];
res_gm_T2_bias = [mean(TV_gm_T2 - gm_T2),mean(TNV_gm_T2 - gm_T2)];
res_gm_PD_bias = [mean(TV_gm_PD - gm_PD),mean(TNV_gm_PD - gm_PD)];
res_wm_T1_bias = [mean(TV_wm_T1 - wm_T1),mean(TNV_wm_T1 - wm_T1)];
res_wm_T2_bias = [mean(TV_wm_T2 - wm_T2),mean(TNV_wm_T2 - wm_T2)];
res_wm_PD_bias = [mean(TV_wm_PD - wm_PD),mean(TNV_wm_PD - wm_PD)];
res_gm_T1_vars = [var(TV_gm_T1 - gm_T1),var(TNV_gm_T1 - gm_T1)];
res_gm_T2_vars = [var(TV_gm_T2 - gm_T2),var(TNV_gm_T2 - gm_T2)];
res_gm_PD_vars = [var(TV_gm_PD - gm_PD),var(TNV_gm_PD - gm_PD)];
res_wm_T1_vars = [var(TV_wm_T1 - wm_T1),var(TNV_wm_T1 - wm_T1)];
res_wm_T2_vars = [var(TV_wm_T2 - wm_T2),var(TNV_wm_T2 - wm_T2)];
res_wm_PD_vars = [var(TV_wm_PD - wm_PD),var(TNV_wm_PD - wm_PD)];


% hold on
% h1 = BlandAltmanPlot(TNV_wm_T1,wm_T1,'AddDetailsText',false)
% hold on
% h2 = BlandAltmanPlot(TV_wm_T1,wm_T1,'AddDetailsText',false)
% set(h1.plot.data,'Color','b')
% set(h2.plot.data,'Color','r')

%%

gm_mask = T1_GT;
gm_mask(T1_GT ~= 1.5450) = 0;
gm_mask(T1_GT == 1.5450) = 1;

wm_mask = T1_GT;
wm_mask(T1_GT ~= 0.8110) = 0;
wm_mask(T1_GT == 0.8110) = 1;

mask = gm_mask + wm_mask;

i = 1; 
for eta = [0 1 5 10 15 20 25 30 35 40 45 50]
    load(['DM_test_', num2eng(eta),'.mat']);
    meanseT1z(i) = immse(rm_0_vec(double(out_dm.qmap(:,:,1)).*mask), rm_0_vec(T1.*mask));
    meanseT2z(i) = immse(double(out_dm.qmap(:,:,2)).*mask, T2.*mask);
    meansePDz(i) = immse(double(out_dm.pd).*mask, PD*mask);
    x(i) = datafit;
    i=i+1;
end

i = 1; 
for eta = [linspace(0,.001,11),0.002,0.003]
    load(['DM_TV_test_', num2eng(eta),'.mat']);
    meanseT1tv(i) = immse(rm_0_vec(double(out_dm.qmap(:,:,1)).*mask), rm_0_vec(T1.*mask));
    meanseT2tv(i) = immse(double(out_dm.qmap(:,:,2)).*mask, T2.*mask);
    meansePDtv(i) = immse(double(out_dm.pd).*mask, PD*mask);
    xtv(i) = datafit;
    i=i+1;
end
scatter(x.^.5,meanseT1z)
hold on
scatter(xtv,meanseT1tv)
legend('tnv','tv')


function vec = rm_0_vec(mat)
vec = mat(:);
vec = nonzeros(vec);
end