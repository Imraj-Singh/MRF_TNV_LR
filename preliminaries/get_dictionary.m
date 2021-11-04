% clc
% clear
% disp("Started dictionary.")
% T1_vals = (100:10:4000)/1000;
% T2_vals = (20:2:600)/1000;
% RFpulses = [linspace(1,70,400),linspace(70,1,200),ones([1,280])]*pi/180;
% TR_times = 12*ones([1,880])/1000;
% TE=2.08/1000;
%         
% dict=zeros(length(T1_vals)*length(T2_vals),length(RFpulses),'single');
% LUT=zeros(length(T1_vals)*length(T2_vals),2,'single');
% 
% k=0;
% for T1 = T1_vals
%     for T2 = T2_vals
%         if T1<T2
%             continue
%         end
%         k=k+1;
%         LUT(k,:)=[T1,T2];
%         dict(k,:)=epg_3D_mrf(RFpulses ,TR_times ,TE, T1, T2);
%     end
%     disp(T1)
% end
% dict=dict(1:k,:);
% LUT=LUT(1:k,:);
% disp("Finished dictionary.")
% plot(abs(dict))
% 
% S_all = svds(double(dict),880);
% [U,S,V] = svds(double(dict),10);

%% figure
dummy = S_all;
for i = 2:880
    dummy(i) = sum(S_all(1:i));
end
plot(dummy(1:50)/sum(S_all),'.k','MarkerSize',12)
ylim([0 1.01])
grid on
xlabel('Singular value','Interpreter','latex','FontSize',12)
ylabel('Energy ratio','Interpreter','latex','FontSize',12)
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
%%
clc
clear
load('dict.mat')
dict_full = dict;
dict_lr = dict*dict.V;

normD = sqrt(sum(dict_lr.*conj(dict_lr),2));
D = dict_lr./repmat(normD,[1 10]);
lut = LUT;
dict = struct('normD',normD,'lut',lut,'V',V,'D',D,'dict_full',dict_full);

%   dict.D normalised compressed dictionary
%   dict.V low rank subspace
%   dict.lut look up table for T1/T2
%   dict.normD norm of each fingerprint
