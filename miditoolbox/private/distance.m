function d=distance(v1,v2,metric,mexp)
% Distance between two vectors or matrices under a given metric
% d = distance(v1,v2,<metric>,<mexp>)
% Measures distance of two equally-sized arrays under the given metric.
% If two matrices are input, distances are calculated column-wise and then 
% summed.
%
% Input argument: 
%	V1 = vector or matrix
%   V2 = vector or matrix
%   METRIC (optional) = Parameter
%       'taxi' (default) = taxi-cab metric (first order)
%       'euc' = euclidean metric (second order)
%       'cosine' = cosine angle 
%       'minkowski' = Minkowski metric which requires specification of optional parameter
%                     mexp.
%   MEXP (optional) = Parameter required for 'minkowski' metric. Default value is 2 so that 
%                     'minkowski' is equivalent to 'euc'.
%
% Output: 
%	d = distance measure between vectors
%
% Remarks:
% Comment: Auxiliary function that resides in private directory
%
% Example: d = distance(a,b,'euc');
%
%  Author		Date
%  MB       	16.2.2004
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyväskylä, Finland
% See License.txt
if nargin < 3, metric='taxi'; end
[a b]=size(v1);
[c d]=size(v2);
if a~=c | b~=d
    disp('Vectors or arrays must be of the same size to be compared')
else
    switch lower(metric)   
    case 'taxi'
        d=sum(abs(v1 - v2));
	case 'euc'
        d=sqrt(sum(abs(v1.^2 - v2.^2)));
	case 'cosine'
        d=dot(v1,v2)/norm(v1)*norm(v2);
    case 'minkowski'
        d=(sum(abs(v1.^mexp - v2.^mexp)))^(1/mexp);
    case 'corr'
        tmp=corrcoef(v1,v2); d=tmp(2);
end
end
[e f]=size(d);
if f>1
    d=sum(d);
end
