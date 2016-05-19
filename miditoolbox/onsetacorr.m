function ac = onsetacorr(nmat, ndivs, fig)
% Autocorrelation function of onset times
% ac = onsetacorr(nmat, <ndivs>, <fig>);
% Returns autocorrelation of onset times weighted by onset durations. 
% These onset durations, are in turn, weighted by Parncutt's durational accent (1994).
% The function optionally creates a graph showing the autocorrelation function calculated
% from onset times weighted by note durations. 
%
% Input arguments:
%	NMAT = notematrix
%	NDIVS (optional) = divisions per quarter note (default = 4);
%     FIG (optional) = plot figure (yes=1, no=0, default=0)
%
% Output:
%	AC = values of autocorrelation function between lags 0 ... 8 quarter notes
%
% Reference:
%	Brown, J. (1992). Determination of meter of musical scores by
%		autocorrelation. Journal of the acoustical society of America, 94 (4), 1953-1957.
%     Parncutt, R. (1994). A perceptual model of pulse salience and metrical
%            accent in musical rhythms. Music Perception, 11(4), 409-464.
%    Toiviainen, P., & Eerola, T. (2006). Autocorrelation in meter induction: the role of accent structure. Journal of the Acoustical Society of America, 119(2), 1164-1170.
%
% Change History :
% Date		Time	Prog	Note
% 11.8.2002	18:36	PT	Created under MATLAB 5.3 (Macintosh)
% 2.4.2004	9:47	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), ac=zeros(1,2*MAXLAG*NDIVS); return; end

maxlag=8;
if nargin<3, fig=0; end
if nargin<2, ndivs = 4; end


ob = onset(nmat);
d = duraccent(dur(nmat,'sec'));
vlen = ndivs*max([2*maxlag ceil(ob(end))+1]);
g = zeros(vlen,1);
ind = mod(round(ob*ndivs),length(g))+1;
for k=1:length(ind)
	g(ind(k)) = g(ind(k))+d(k);
end

actmp = xcorr(g);
ind1 = (length(actmp)+1)/2; ind2 = ind1+maxlag*ndivs;
ac = actmp(ind1:ind2)';
ac = ac/ac(1);

%%%% PLOT
if fig
	FS = 14; % font size
	bar(0:(1/ndivs):maxlag, ac), axis([-.2 maxlag+.2 0 1.05]);
	ac2 = zeros(size(ac));
	ac2(1:ndivs:end) = ac(1:ndivs:end);
	xlabel('Time lag (quarter notes)','FontSize',FS);
	ylabel('Correlation','FontSize',FS);
	title('Autocorrelation function of onset times','FontSize',FS);
	hold on
	bar(0:(1/ndivs):maxlag, ac2, 'r');
	hold off
	set(gca,'FontSize',FS);
	if nargin>3
		text(maxlag-5,.98,['Onsets also weigthed by: ' func])
	end
end
