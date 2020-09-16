function [W,N] = ILDPoint(N,M)
%ILD - Generate a set of uniformly distributed points on the unit
%hyperplane named Incremental lattice desigin
%
%   ILDPoint(N,M) returns approximately N uniformly distributed
%   points with M objectives on the unit hyperplane.
%
%   Due to the requirement of uniform distribution, the number of points
%   cannot be arbitrary, and the number of points in W may be slightly
%   smaller than the predefined size N.
%
%   Example:
%       [W,N] = ILD(286,10)

%------------------------------- Reference --------------------------------
% T. Takagi, K. Takadama, H. Sato, Incremental lattice design of weight
% vector set, Proceedings of the 2020 Genetic and Evolutionary Computation
% Conference Companion, 2020, 1486-1494.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

% This algorithm is written by Tomoaki Takagi
    
    NList = [
         5,15, 35,  69, 121, 195,  295,  425,  589;
         6,21, 56, 126, 251, 456,  771, 1231, 1876;
         7,28, 84, 210, 462, 923, 1709, 2975, 4921;
         8,36,120, 330, 792,1716, 3431, 6427,11404;
		 9,45,165, 495,1287,3003, 6435,12869,24301;
        10,55,220, 715,2002,5005,11440,24310,48619;
        11,66,286,1001,3003,8008,19448,43758,92378;];
    
    H = 1;
    if M==2
        H = floor(N/2)-1;
    elseif M==3
        while (H+1)*(H+2)/2*M+1 <= N
            H = H + 1;
        end
    else
        while NList(M-3,H+1) <= N
            H = H + 1;
        end
    end
    
    W = zeros(1,M);
    edgeW = W;
    for i = 1 : H
        sizeW = size(edgeW,1);
        edgeW = repmat(edgeW,M,1);
        for j = 1 : M
            edgeW((j-1)*sizeW+1:j*sizeW,j) = edgeW((j-1)*sizeW+1:j*sizeW,j)+M;
        end
        edgeW = unique(edgeW,'rows');
        edgeW(min(edgeW,[],2)~=0,:) = [];
        W = [W+1;edgeW];
    end
    W = W / (M*H);
    W = max(W,1e-6);
    N = size(W,1);
end
