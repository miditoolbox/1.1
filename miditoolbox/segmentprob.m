function segm = segmentprob(nmat, thres, fig)
% Estimation of segment boundaries
% segm = segmentprob(nmat, <thres>,<fig>);
% Plots a segmentation of NMAT based on Markov probabilities of
% segment boundaries derived from the Essen collection.
%
% Input arguments:
%    NMAT = notematrix
%    THRES (optional) = segmentation threshold (default = 0.6);
%     FIG (optional) = plot figure (yes=1, no=0, default=0)
%
% Output:
%   SEGM = Segment probabilities for note event (row vector)
%   Figure (optional = Plot showing the pianoroll notation of NMAT in top subplot
%   and estimated segment boundaries with respective probabilities
%   as a stem plot.
%
% Authors:
%  Date		Time	Prog	Note
% 9.3.2003	15:31	PT	Created under MATLAB 5.3 (Macintosh)
%© Part of the MIDI Toolbox Software Package, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if nargin<3, fig=0; else fig=1; end

%nmat = transpose2c(nmat);
nmat(:,1)=nmat(:,1)-nmat(1,1);
if nargin<2, thres=0.6; end
load markovdata;
segm=zeros(nnotes(nmat),1);
p=pitch(nmat);
pc = mod(p,12)+1;
c = [-0.1128    0.0568    0.1581   -0.0530   -0.0404    1.1944    0.5 0.0949];

du = [diff(onset(nmat)); nmat(end,2)];
	du = round(2*log2(du+1e-12)); % take logarithms & categorize
	du = max(4,du);
for k=3:length(segm)
	segm(k) = c(1)*dp1(pc(k));
	segm(k)=segm(k)+c(2)*dp2(pc(k-1),pc(k));
	if abs(p(k)-p(k-1)) <= 12
		segm(k)=segm(k)+c(3)*div1(p(k)-p(k-1)+13);
		if abs(p(k-1)-p(k-2)) <= 12
			segm(k)=segm(k)+c(4)*div2(p(k-1)-p(k-2)+13,p(k)-p(k-1)+13);
        end
    end
	if abs(du(k)) <= 4
		segm(k)=segm(k)+c(5)*dd1(du(k)+5);
		if abs(du(k-1)) <= 4
			segm(k)=segm(k)+c(6)*dd2(du(k-1)+5,du(k)+5);
        end
	end
    segm(k)=segm(k)+c(8);
end
on=onset(nmat);
on2=round(2*mod(on,24));
for k=3:size(segm,1)-1
    segm(k)=segm(k)+c(7)*alkuhist(on2(k+1)+1);
end

segm=exp(segm/2)./(1+exp(segm/2));
segm2=[0; segm(1:end-1)];
[X I] = sort(-segm2);
totaldur=max(onset(nmat))+ dur(nmat(end,:));
N = round(totaldur/4);

segm=zeros(size(segm2));
segm(I(1:N))=segm2(I(1:N));
above = find(segm2>thres);
	segm(above)=segm2(above);
	on=onset(nmat);
	off=on+dur(nmat);
	du = dur(nmat);

	p=pitch(nmat);
	minimi = min(pitch(nmat));
	maksimi = max(pitch(nmat));

if fig
	subplot(2,1,1)
	pianoroll(nmat,'num','beat','b','hold');
	hold off
	subplot(2,1,2)
	stem(on,segm,'filled');
	axis([0 totaldur 0 1]);
	ylabel('\bfSegment prob.','FontSize',12)
end
