%--------------------------------------------------------------------------
%
% auto clustering
% need to run 'getpatchpairs.m' first
%
%--------------------------------------------------------------------------

clc,clear;
load('lrpatch.mat');
load('hrpatch.mat');
% cluster number !!!! important value
cluster_num = 128;
[k1, k2,len]=size(lrpatch);
lrset = reshape(lrpatch, 45, len);
hrset = reshape(hrpatch,81, len);

% clustering
[idx, Center] = kmeans(lrset.', cluster_num, 'Options', statset('UseParallel', 1, 'Display', 'Iter', 'MaxIter', 100));

lrset = lrset';
hrset = hrset';

% calculate matrix W, V, C
C = zeros(81,46,cluster_num);
for i = 1:cluster_num
    W = (hrset(find(idx == i),:)).';
    V = (lrset(find(idx == i),:)).';
    [x, y] = size(V);
    padding = ones(1,y);
    V1 = [V; padding];
    C(:,:, i) = W / V1;
end

% save to files
save('C.mat','C');
save('idx.mat','idx');
save('Center.mat','Center');
save('cluster_num.mat','cluster_num');

