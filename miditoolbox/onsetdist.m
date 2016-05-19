function dist = onsetdist(nmat, nbeats, fig)
% Distribution of onset times within a measure
% dist = onsetdist(nmat, nbeats,<fig>);
% Returns the distribution of onset times within a measure with
% a length of NBEATS
%
% Input arguments:
%	NMAT = notematrix
%	NBEATS = beats per measure
%     FIG (Optional) = Figure flag (1=figure, 0=no figure)
%
% Output:
%	DIST = distribution of onset times
%
% Change History :
% Date		Time	Prog	Note
% 11.8.2002	18:36	PT	Created under MATLAB 5.3 (Macintosh)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if nargin<3, fig=0; end
if nargin<2, disp('You must give the beats per measure (NBEATS)!!!'); return
end

NDIVS = 4;
ob = onset(nmat); ob=ob-ob(1);
d = dur(nmat);
dist = zeros(NDIVS*nbeats,1);
ind = floor(mod((ob*NDIVS),NDIVS*nbeats))+1;
for k=1:length(ind)
	dist(ind(k)) = dist(ind(k))+d(k);
end

%%%% PLOT

if fig
	FS = 14; % font size
	bar((0:(NDIVS*nbeats-1))/NDIVS, dist), axis([-0.2 nbeats+.2 0 max(dist)+5]);
	dist2 = zeros(size(dist));
	dist2(1:NDIVS:end) = dist(1:NDIVS:end);
	xlabel('Location within measure (quarter notes)','FontSize',FS);
	ylabel('Total duration (quarter notes)','FontSize',FS);
	title('Distribution of note onsets (quarter notes)','FontSize',FS);
	hold on
	bar((0:(NDIVS*nbeats-1))/NDIVS, dist2, 'r');
	hold off
	set(gca,'FontSize',FS);
end
