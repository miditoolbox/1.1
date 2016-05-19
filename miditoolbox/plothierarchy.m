function h = plothierarchy(nmat,timetype)
% Plot metrical hierarchy
% h = plothierarchy(nmat,<timetype>)
% Plot metrical hierarchy based on meter-finding and assigning
% metrical grid to each note according to its position in the grid.
% Lerdahl & Jackendoff (1983).
%
% Input argument:
%	NMAT = notematrix
%     TIMETYPE = time in beats ('beat', default) or seconds ('sec')
%
% Output:
%	FIG = Figure
%
% Reference:
%     Lerdahl, F., & Jackendoff, R. (1983). A generative theory of tonal music. 
%            Cambridge, MA: MIT Press.
%
% Change History:
% Date		Time	Prog	Note
% 1.7.2003	19:07	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if nargin<2, timetype='beat'; end

mh=metrichierarchy(nmat);
		os=onset(nmat,timetype);
		ds = dur(nmat,timetype);

			kesto = os(end)+ds(end);
			ac3length = length(mh);
			%kesto_aika = 0:(kesto/(ac3length-1)):kesto;

kesto_aika=os; % 

stem(kesto_aika, mh,'.k'); hold on
plot(kesto_aika, mh,'ok','MarkerSize',4.5,'MarkerFaceColor',[.3 .3 .3]); hold on
mh2=mh-1;
h=plot(kesto_aika, mh2,'ok','MarkerSize',4.5,'MarkerFaceColor',[.3 .3 .3]); hold on
mh3=mh-2;
h=plot(kesto_aika, mh3,'ok','MarkerSize',4.5,'MarkerFaceColor',[.3 .3 .3]); hold on
mh3=mh-3;
h=plot(kesto_aika, mh3,'ok','MarkerSize',4.5,'MarkerFaceColor',[.3 .3 .3]); hold off

axis([-0.35 kesto+.35 1.5 5.5]);
set(gca,'YTick',2:6,'FontSize',12);
set(gca,'XTick',0:2:kesto+.35,'FontSize',12);
colormap gray

str = ['\bfTime in ',timetype,'s'];

	xlabel(str,'FontSize',12)
	ylabel('\bfMetrical hierarchy','FontSize',12)
		set(gca,'YTickLabel',{'2','3','4','5'},'FontSize',12);
