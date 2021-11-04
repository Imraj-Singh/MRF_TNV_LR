clc
clear
addpath(genpath([pwd, '/..']));

load('brainweb_phantom.mat')
T1 = imgaussfilt(T1_GT,1);
T2 = imgaussfilt(T2_GT,1);
PD = imgaussfilt(PD_GT,1);

PD(PD<0.1) = 0;
T1(PD<0.1) = 0;
T2(PD<0.1) = 0;
RFpulses = [linspace(1,70,400),linspace(70,1,200),ones([1,280])]*pi/180;
TR_times = 12*ones([1,880])/1000;
TE=2.08/1000;
mat_of_contrasts=zeros(size(T1,1),size(T1,2),length(RFpulses),'single');
locs=find((T2~=0)&(T1~=0)&(PD~=0));

disp("Started contrast.")
for k=1:length(locs)
    [i,j]=ind2sub(size(T1),locs(k));
    mat_of_contrasts(i,j,:)=(single((PD(i,j)*epg_3D_mrf(RFpulses ,TR_times ,TE, T1(i,j), T2(i,j)))));
end
disp("Finished contrast.")

save('ground_truth','mat_of_contrasts','T1','T2','PD')

%%
load('brainweb_phantom.mat')
T1 = imgaussfilt(T1_GT,1);
T2 = imgaussfilt(T2_GT,1);
PD = imgaussfilt(PD_GT,1);

PD(PD<0.05) = 0;
T1(PD<0.05) = 0;
T2(PD<0.05) = 0;

subplot(1,2,1)
imagesc(T2)
colorbar
subplot(1,2,2)
imagesc(T2_GT)
colorbar


