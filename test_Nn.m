clear
clc
% Add folder and subfolders in to the path
% addpath(genpath([pwd, '/..']));

scale = 1
Z = -randi(1000,[1,1,10,2])*scale + randi(1000,[1,1,10,2])*1i*scale;
x = Nn(Z);
rng(10)
[Nx, Ny, ~, ~] = size(Z);
Nnout1 = zeros(size(Z),'like',Z);
tic
for i=1:Nx
    for j=1:Ny
        matrix = squeeze(Z(i,j,:,:));
        [U,S,V] = svd(matrix);
        S1 = S;
        for k=1:2
            if abs(S(k,k))>1
                S1(k,k) = S(k,k)/abs(S(k,k));
            end
        end
        Nnout1(i,j,:,:) = U*S1*V';
    end
end
toc
Nnout2 = Nn(Z);
tic
[S2,V1] = SV_decomp(Z);
toc

squeeze(Nnout1(1,1,:,:)-Nnout2(1,1,:,:))
