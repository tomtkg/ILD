function ILD(H,M)
%ILD - Generate a set of uniformly distributed points on the unit
%hyperplane named Incremental lattice desigin
%
%   ILD(H,M) saves approximately N uniformly distributed
%   points with M objectives on the unit hyperplane.
%
%   Due to the requirement of uniform distribution, the number of points
%   cannot be arbitrary, and the number of points in W is determined by
%   the decomposition parameter H.
%
%   Example:
%       ILD(3,10)

%------------------------------- Reference --------------------------------
% T. Takagi, K. Takadama, and H. Sato, Incremental lattice design of weight
% vector set, Proceedings of the 2020 Genetic and Evolutionary Computation
% Conference Companion, 2020, 1486-1494.
%--------------------------------------------------------------------------

% This algorithm is written by Tomoaki Takagi
% An optimized implementation for MATLAB
    
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
    writematrix(W,sprintf('../data/ILD_M%d_H%d_N%d.dat', M, H, N),'Delimiter','\t');
end

%% Original implementation based on the paper
%function ILD(H,M)
%    I = eye(M);
%    W = zeros(1,M);
%    for i = 1 : H
%        oldW = W;
%        W = double.empty(0,M);
%        edgeW = oldW(min(oldW,[],2)==0,:);
%        for j = 1 : size(edgeW)
%            for k = 1 : M
%                W = [W;edgeW(j,:)+M*I(k,:)];
%            end
%        end
%        for j = 1 : size(oldW)
%            W = [W;oldW(j,:)+1];
%        end
%        W = unique(W,'rows');
%    end
%    for j = 1 : size(oldW)
%        W = W(j,:) / (M*H);
%    end
%    W = max(W,1e-6);
%    N = size(W,1);
%end
