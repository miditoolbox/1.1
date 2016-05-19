function of = onsetfunc(nmat, accfunc);
% Sum of delta functions at onset times weighted by values obtained from ACCFUNC
% of = onsetfunc(nmat, <accfunc>);
%
% Input arguments:
%	NMAT = note matrix
%	ACCFUNC (optional) = accent function;
%
% Output:
%	OF = onset function
%
% Reference:
%	Brown, J. (1992). Determination of meter of musical scores by
%		autocorrelation. Journal of the acoustical society of America, 94 (4), 1953-1957.
%
% Comment: Auxiliary function that resides in private directory
%
% Change History :
% Date		Time	Prog	Note
% 11.8.2002	18:36	PT	Created under MATLAB 5.3 (Macintosh)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

NDIVS = 4; % four divisions per quater note
MAXLAG=8;
ob = onset(nmat);

if nargin==2
	acc=feval(accfunc,nmat);
else
	acc=ones(length(ob),1);
end

vlen = NDIVS*max([2*MAXLAG ceil(max(ob))+1]);
of = zeros(vlen,1);
ind = mod(round(ob*NDIVS),length(of))+1;
for k=1:length(ind)
	of(ind(k)) = of(ind(k))+acc(k);
end
