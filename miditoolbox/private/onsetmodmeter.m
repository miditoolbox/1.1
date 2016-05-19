function bm = onsetmodmeter(nmat);
% Wrapping of onset times within a measure
% bm = onsetmodmeter(nmat);
% Returns the onset times modulo meter in NMAT estimated by meter.m
%
% Input argument:
%	NMAT = notematrix
%
% Output:
%	BM = onset times modulo meter in NMAT
%
%  Date		Time	Prog	Note
% 4.6.2002	18:36	TE	Created under MATLAB 5.3 (Mac)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt
% Comment: Auxiliary function that resides in private directory

if isempty(nmat) return; end

m = meter(nmat);
ob = mod(onset(nmat),m);
d = dur(nmat);
g = zeros(4*m,1);
ind = mod(round(ob*4),length(g))+1;
for k=1:length(g)
	g(k) = sum(d(ind==k));
end
[y,ind2] = max(g);
bm = mod(onset(nmat)-(ind2-1)*0.25,m)';
