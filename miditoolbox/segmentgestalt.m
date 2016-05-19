function [c,s] = segmentgestalt(nmat,fig)
% Segmentation algorithm by Tenney & Polansky (1980)
% y = segmentgestalt(nmat,<fig>);
%
% Input arguments: 
%	NMAT = notematrix
%	FIGURE (optional) = if any second argument given, 
%                                a figure is plotted
%
% Output: 
%   C = clang boundaries (binary (0|1) column vector)
%   S = segment boundaries (binary (0|1) column vector)
%   FIG (optionally) = plot pianoroll with dotted lines 
%                              corresponding with clang boundaries.
%                              Solid line indicates segment boundaries.
%
% References:
% Tenney, J.  & Polansky, L. (1980). Temporal gestalt perception
%     in music. Journal of Music Theory, 24(2), 205–41.
%
% Authors:
%  Date		Time	Prog	Note
% 20.2.2003	18:44	PT	Created under MATLAB 5.3 (Macintosh)
% 20.3.2004	15:04	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox Software Package, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if nargin<2, fig=0; end
if nargin==2, fig=1; end

	on=onset(nmat);
	off=on+dur(nmat);
	du = dur(nmat);
	totaldur=max(onset(nmat))+ dur(nmat(end,:));

	p=pitch(nmat);
	minimi = min(pitch(nmat));
	maksimi = max(pitch(nmat));

% calculate clang boundaries
%cl = zeros(size(on)); clb=cl;
cl = 2*(on(2:end)-on(1:(end-1)))+abs(p(2:end)-p(1:(end-1)));
clb = cl(2:(end-1))>cl(1:(end-2)) & cl(2:(end-1))>cl(3:end);  

clind = find(clb==1)+2; % clang starting points

if fig
	pianoroll(nmat) % using only default options
	set(gca,'Xgrid','off');

	hold on
	for k=1:length(clind)
		plot([on(clind(k)) on(clind(k))],[minimi-2 maksimi+2],'k:','LineWidth',2);
	end
	hold off
end

% calculate segment boundaries
first = [1; clind];
last = [clind-1; length(on)];
for k=1:length(first) % mean pitch of segments
	seg = first(k):last(k);
	meanp(k) = p(seg)'*du(seg)/sum(du(seg));
end
meanp = meanp';
segdist = abs(meanp(2:end)-meanp(1:(end-1)))+on(first(2:end))-on(first(1:(end-1)));
segdist = segdist+abs(p(first(2:end))-p(last(1:(end-1))));
segdist = segdist+2*(on(first(2:end))-on(last(1:(end-1))));

segb = segdist(2:(end-1))>segdist(1:(end-2)) & segdist(2:(end-1))>segdist(3:end);
segind = find(segb==1)+2; % seguence starting points



if fig
	hold on
	for k=1:length(segind)
		plot([on(first(segind(k))) on(first(segind(k)))],[minimi-2 maksimi+2],'k-','LineWidth',2);
	end
	hold off
end

padding=zeros(1,3)';
c = [padding; clb];

segment_index = segind-1;
j=find(c>0);
z=zeros(1,length(nmat));
z(j(segment_index))=1;
s=z';
