function [S,V] = SV_decomp(B)

% Taken from http://www.ipol.im/pub/art/2016/141/article_lr.pdf#page=30
% B^T B
M11 = sum(conj(B(:,:,:,1)).*B(:,:,:,1), 3);
M12 = sum(conj(B(:,:,:,1)).*B(:,:,:,2), 3);
M21 = sum(conj(B(:,:,:,2)).*B(:,:,:,1), 3);
M22 = sum(conj(B(:,:,:,2)).*B(:,:,:,2), 3);

eig1 = (M11 + M22 + sqrt((M11 + M22).^2 - 4*(M11.*M22 - M12.*M21)))/2;
eig2 = (M11 + M22 - sqrt((M11 + M22).^2 - 4*(M11.*M22 - M12.*M21)))/2;
S = zeros([size(B,1) size(B,2) 2]);
S(:,:,1) = eig1.^0.5;
S(:,:,2) = eig2.^0.5;

V = zeros([size(B,1) size(B,2) 2 2]);

V11 = zeros([size(B,1) size(B,2)]);
V12 = ones([size(B,1) size(B,2)]);
V21 = ones([size(B,1) size(B,2)]);
V22 = zeros([size(B,1) size(B,2)]);

boo_check1 = M11 >= M22;

V11(boo_check1) = 1;
V12(boo_check1) = 0;
V21(boo_check1) = 0;
V22(boo_check1) = 1;

bl = M12.*conj(M12) > 1e-16;

V11(bl) = eig1(bl) - M22(bl);
V12(bl) = eig2(bl) - M22(bl);
V21(bl) = M21(bl);
V22(bl) = M21(bl);
norm1 = sqrt(V11(bl).*conj(V11(bl)) + V21(bl).*conj(V21(bl)));
norm2 = sqrt(V22(bl).*conj(V22(bl)) + V12(bl).*conj(V12(bl)));

V11(bl) = V11(bl)./norm1;
V21(bl) = V21(bl)./norm1;
V12(bl) = V12(bl)./norm2;
V22(bl) = V22(bl)./norm2;

V(:,:,1,1) = V11;
V(:,:,2,1) = V21;
V(:,:,1,2) = V12;
V(:,:,2,2) = V22;

end