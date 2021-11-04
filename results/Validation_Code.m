clc
clear
close all

i = 1;
for eta = [0 .5 .75 1 5 10 15 20 25 30 35 40 45 50 55 60 65 70]
    load(['TNV_test_', num2eng(eta),'.mat'])
    data_imraj(i) = data_fit_func(end);
    nuc_imraj(i) = nuc_norm_func(end);
    i = i + 1;
end

%%
close all
scatter(data_imraj, nuc_imraj,'x');
grid on
legend('PDHG code','Interpreter','latex','FontSize',12)
xlabel('Data-fitting, $||Au - g||_2^2$','Interpreter','latex','FontSize',12)
ylabel('Nuclear norm, $||\nabla u||_*$','Interpreter','latex','FontSize',12)
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

%%
load(['TNV_test_', num2eng(10),'.mat']);
figure
for j = 1:9
    subplot(3,3,j)
    imagesc(abs(ubar(:,:,j)))
    axis off
    xlabel('Sing img ' + j )
    colorbar
end
% data_fit_func = data_fit_func(1:999)-data_fit_func(2:1000);
% nuc_norm_func = nuc_norm_func(1:999)-nuc_norm_func(2:1000);
figure
subplot(2,1,1)
%plot(d_res)
plot(data_fit_func)
%plot(p_res-d_res)
set(gca, 'YScale', 'log')
ylabel(['$||Au-g||^2$: ', num2str(data_fit_func(end))],'Interpreter','latex')
xlabel('Iter')
subplot(2,1,2)
%plot(p_res)
plot(abs(nuc_norm_func))
%plot(d_res)
ylabel(['$||Ju||_*$: ', num2str(abs(nuc_norm_func(end)))],'Interpreter','latex')
xlabel('Iter: ')
set(gca, 'YScale', 'log')

%%
load(['TNV_test_', num2eng(1),'.mat']);
figure
for j = 1:9
    subplot(3,3,j)
    imagesc(abs(ubar(:,:,j)))
    axis off
    xlabel('Sing img ' + j )
    colorbar
end
% data_fit_func = data_fit_func(1:999)-data_fit_func(2:1000);
% nuc_norm_func = nuc_norm_func(1:999)-nuc_norm_func(2:1000);
figure
subplot(2,1,1)
%plot(d_res)
plot(data_fit_func(1:end))
%plot(p_res-d_res)
set(gca, 'YScale', 'log')
ylabel(['$||Au-g||^2$: ', num2str(data_fit_func(end))],'Interpreter','latex')
xlabel('Iter')
subplot(2,1,2)
%plot(p_res)
plot(abs(nuc_norm_func(1:end)))
%plot(d_res)
ylabel(['$||Ju||_*$: ', num2str(abs(nuc_norm_func(end)))],'Interpreter','latex')
xlabel('Iter: ')
set(gca, 'YScale', 'log')

function g = Op_grad(u, g)
for i = 1 : size(g, 3)
    g(:,:,i,:) = Gradient2D_forward_constant_unitstep(u(:,:,i),squeeze(g(:,:,1,:)));
end
end