function [W, T] = ReOLSR(fea,gnd,epsilon, maxiter)
pre_Y = indicatedmatrix(gnd);
n = length(gnd);
pre_W = zeros(size(fea,2),size(pre_Y,2));
for iter = 1:maxiter
T = [];
%% regression
W = OLSR(fea,pre_Y);
if ( norm(pre_W-W)<=epsilon )
    break;
end
pre_W = W;
% calculate b
b = (1/n).*(pre_Y'*ones(n,1)-pre_W'*fea'*ones(n,1));
% claculate R
R = fea*pre_W+ones(n,1)*b';
%% retargeted
% calculate T
for i = 1:n
t =Retargeting(R(i,:),gnd(i));
T = [T;t];
end
pre_Y = T;
end
