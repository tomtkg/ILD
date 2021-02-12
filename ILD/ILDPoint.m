function [W,N] = ILDPoint(N,M)
%ILD - Generate a set of uniformly distributed points on the unit
%hyperplane named Incremental lattice desigin
%
%   ILDPoint(N,M) returns approximately N uniformly distributed
%   points with M objectives on the unit hyperplane.
%
%   Due to the requirement of uniform distribution, the number of points
%   cannot be arbitrary, and the number of points in W may be slightly
%   larger than the predefined size N.
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
    
    I = M * eye(M);
    W = zeros(1,M);
    edgeW = W;
    for i = 1 : H
        edgeW = repmat(edgeW,M,1) + repelem(I,size(edgeW,1),1);
        edgeW = unique(edgeW,'rows');
        edgeW(min(edgeW,[],2)~=0,:) = [];
        W = [W+1;edgeW];
    end
    W = W / (M*H);
    W = max(W,1e-6);
    N = size(W,1);
end
