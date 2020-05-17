function [W,N] = UniformPoint(N,M)
%UniformPoint - Generate a set of uniformly distributed points on the unit
%hyperplane.
%
%   [W,N] = UniformPoint(N,M) returns approximately N uniformly distributed
%   points with M objectives on the unit hyperplane.
%
%   Due to the requirement of uniform distribution, the number of points
%   cannot be arbitrary, and the number of points in W may be slightly
%   smaller than the predefined size N.
%
%   Example:
%       [W,N] = UniformPoint(275,10)

%------------------------------- Reference --------------------------------
% [1] I. Das and J. E. Dennis, Normal-boundary intersection: A new method
% for generating the Pareto surface in nonlinear multicriteria optimization
% problems, SIAM Journal on Optimization, 1998, 8(3): 631-657.
% [2] K. Deb and H. Jain, An evolutionary many-objective optimization
% algorithm using reference-point based non-dominated sorting approach,
% part I: Solving problems with box constraints, IEEE Transactions on
% Evolutionary Computation, 2014, 18(4): 577-601.
% [3] T. Takagi, K. Takadama, H. Sato, Incremental lattice design of weight
% vector set, Workshop on Decomposition Techniques in Evolutionary
% Optimization, 2020 Genetic and Evolutionary Computation Conference
% (GECCO 2020), 2020. (to appear)
%------------------------------- Copyright --------------------------------
% Copyright (c) 2018-2019 BIMK Group. You are free to use the PlatEMO for
% research purposes. All publications which use this platform or any code
% in the platform should acknowledge the use of "PlatEMO" and reference "Ye
% Tian, Ran Cheng, Xingyi Zhang, and Yaochu Jin, PlatEMO: A MATLAB platform
% for evolutionary multi-objective optimization [educational forum], IEEE
% Computational Intelligence Magazine, 2017, 12(4): 73-87".
%--------------------------------------------------------------------------

% This algorithm is written by Tomoaki Takagi

    W = ILDPoint(N,M);
    if W ~= zeros(1,M)
        N = size(W,1);
        return
    end
    
    H1 = 1;
    while nchoosek(H1+M,M-1) <= N
        H1 = H1 + 1;
    end
    W = nchoosek(1:H1+M-1,M-1) - repmat(0:M-2,nchoosek(H1+M-1,M-1),1) - 1;
    W = ([W,zeros(size(W,1),1)+H1]-[zeros(size(W,1),1),W])/H1;
    if H1 < M
        H2 = 0;
        while nchoosek(H1+M-1,M-1)+nchoosek(H2+M,M-1) <= N
            H2 = H2 + 1;
        end
        if H2 > 0
            W2 = nchoosek(1:H2+M-1,M-1) - repmat(0:M-2,nchoosek(H2+M-1,M-1),1) - 1;
            W2 = ([W2,zeros(size(W2,1),1)+H2]-[zeros(size(W2,1),1),W2])/H2;
            W  = [W;W2/2+1/(2*M)];
        end
    end
    W = max(W,1e-6);
    N = size(W,1);
end

%% If the the predefined size N and the possible size of the ILD
%% point match, the ILD point is returned.
function [W,N] = ILDPoint(N,M)

    NList = [
         5,15, 35,  69, 121, 195,  295,  425,  589;
         6,21, 56, 126, 251, 456,  771, 1231, 1876;
         7,28, 84, 210, 462, 923, 1709, 2975, 4921;
         8,36,120, 330, 792,1716, 3431, 6427,11404;
		 9,45,165, 495,1287,3003, 6435,12869,24301;
        10,55,220, 715,2002,5005,11440,24310,48619;
        11,66,286,1001,3003,8008,19448,43758,92378;];
    
    H = 1;
    W = zeros(1,M);
    
    if M==2
        return
    elseif M==3
        while (H+1)*(H+2)/2*M+1 <= N
            H = H + 1;
        end
        if H*(H+1)/2*M+1 ~= N
            return
        end
    else
        while NList(M-3,H+1) <= N
            H = H + 1;
        end
        if NList(M-3,H) ~= N
            return
        end
    end
    
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
