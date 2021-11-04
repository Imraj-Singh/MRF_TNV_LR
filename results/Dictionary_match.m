%% Do the dictionary reconstruction
clc
clear
close all
load('dict.mat')
load('ground_truth.mat')
load("masks.mat")




for eta = [0 1 5 10 15 20 25 30 35 40 45 50]
%     TNV = load(['TNV_test_', num2eng(eta),'.mat']);
%      TV = load(['TV_test_', num2eng(eta),'.mat']);
%     TNV_out_dm = dm_MRF_inference(dict, TNV.ubar);
%      TV_out_dm = dm_MRF_inference(dict, TV.ubar);

    load(['DM_TNV_test_', num2eng(eta),'.mat'])
    load(['DM_TV_test_', num2eng(eta),'.mat'])
    
    TNV_si.mse = zeros(1,10);
    TNV_si.bias = zeros(1,10);
    TNV_si.var = zeros(1,10);
    TNV_si.psnr = zeros(1,10);
    TV_si.mse = zeros(1,10);
    TV_si.bias = zeros(1,10);
    TV_si.var = zeros(1,10);
    TV_si.psnr = zeros(1,10);

    for k=1:10
        test = nonzeros(reshape(squeeze(abs(TNV.ubar(:,:,k))).*brain_mask,1,[]));
        ref = nonzeros(reshape(squeeze(abs(multicontrast(:,:,k))).*brain_mask,1,[]));
        TNV_si.psnr(k) = psnr(test, ref);
        TNV_si.mse(k) = immse(test, ref);
        TNV_si.bias(k) = sum(test(:)-ref(:))/length(test);
        TNV_si.var(k) = var(test(:)-ref(:));
        test = nonzeros(reshape(squeeze(abs(TV.ubar(:,:,k))).*brain_mask,1,[]));
        ref = nonzeros(reshape(squeeze(abs(multicontrast(:,:,k))).*brain_mask,1,[]));
        TV_si.psnr(k) = psnr(test, ref);
        TV_si.mse(k) = immse(test, ref);
        TV_si.bias(k) = sum(test(:)-ref(:))/length(test);
        TV_si.var(k) = var(test(:)-ref(:));
    end
    
    TNV_T1 = get_gm_wm_bm_vals(squeeze(TNV_out_dm.qmap(:,:,1)), T1, brain_mask, gm_mask, wm_mask);
    TNV_T2 = get_gm_wm_bm_vals(squeeze(TNV_out_dm.qmap(:,:,2)), T2, brain_mask, gm_mask, wm_mask);
    TNV_PD = get_gm_wm_bm_vals(squeeze(TNV_out_dm.pd(:,:)), PD, brain_mask, gm_mask, wm_mask);
    TV_T1 = get_gm_wm_bm_vals(squeeze(TV_out_dm.qmap(:,:,1)), T1, brain_mask, gm_mask, wm_mask);
    TV_T2 = get_gm_wm_bm_vals(squeeze(TV_out_dm.qmap(:,:,2)), T2, brain_mask, gm_mask, wm_mask);
    TV_PD = get_gm_wm_bm_vals(squeeze(TV_out_dm.pd(:,:)), PD, brain_mask, gm_mask, wm_mask);

    TNV_datafit = TNV.data_fit_func(end);
    TV_datafit = TV.data_fit_func(end);

    save(['DM_TNV_test_', num2eng(eta),'.mat'],"TNV_PD","TNV_T1","TNV_T2","TNV_datafit","TNV_si","TNV_out_dm","TNV")
    save(['DM_TV_test_', num2eng(eta),'.mat'],"TV_PD","TV_T1","TV_T2","TV_datafit","TV_si","TV_out_dm","TV")
end

function [gm_wm_vals] = get_gm_wm_bm_vals(qmap, qmapref, brain_mask, gm_mask, wm_mask)
    test = nonzeros(reshape(abs(qmap).*gm_mask,1,[]));
    ref = nonzeros(reshape(abs(qmapref).*gm_mask,1,[]));
    gm_wm_vals.gm_bias = sum(test-ref)/length(test);
    gm_wm_vals.gm_var = var(test-ref);
    gm_wm_vals.gm_immse = immse(test, ref);
    test = nonzeros(reshape(abs(qmap).*wm_mask,1,[]));
    ref = nonzeros(reshape(abs(qmapref).*wm_mask,1,[]));
    gm_wm_vals.wm_bias = sum(test-ref)/length(test);
    gm_wm_vals.wm_var = var(test-ref);
    gm_wm_vals.wm_immse = immse(test, ref);
    test = nonzeros(reshape(abs(qmap).*brain_mask,1,[]));
    ref = nonzeros(reshape(abs(qmapref).*brain_mask,1,[]));
    gm_wm_vals.bm_bias = sum(test-ref)/length(test);
    gm_wm_vals.bm_var = var(test-ref);
    gm_wm_vals.bm_immse = immse(test, ref);
end