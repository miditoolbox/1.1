function p = plotdist(dist,param)
% Plotting of distributions
% p = plotdist(dist,<param>)
%
% This function creates a visual output of note-, interval- or duration
% distributions or transitions. This purpose of the command is make
% creating simple figures easier. 
% Also, figure created by this function is suitable for normal, grayscale
% printing.
%
% Input arguments: 
%	DIST = Distribution of:
%	pitch-classes (1x12), intervals (1x25) or durations (1x9) OR
%	the transitions of the same features;
%	pitch-class transitions (12 x 12), interval transitions (25 x 25),  
%	durations transitions (9 x 9), or key correlations (1x24)
%     interval sizes (1x13) or intervals directions (1x12). For the last one,
%     a simple heuristic is used to distinguish it from the pitch-class distribution.
%
%     PARAM (optional) = color parameters (e.g. 'k' for black 
%                                bars or [.1 .4 .9] for specific colors). 
%                               For transition plots, use 'hot' or other colormap
%                               definition. Default color is gray in both cases.
%
% Output: Figure
%
% Remarks: The distribution needs to be calculated separately.
%
% Example 1: Create note transition figure of NMAT
%   plotdist(pcdist2(NMAT),'hot');
%
% Example 2: Plot interval sizes of NMAT
%   plotdist(ivsizedist1(NMAT));
%
% Authors:
%  Date		Time	Prog	Note
% 1.2.2003	12:02	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt


distdim = size(dist,1);

%%%%%% SECOND ORDER
if distdim > 1  % transition plot
	if nargin<2, param = 'gray'; end  % default: gray figures
	p=imagesc(dist);
	str=['colormap(''',param, '(256)'')'];
	eval(str)
	map=colormap;
	newmap = flipud(map);
	colormap(newmap)

	colorbar;
	axis xy;
else
%%%%%% FIRST ORDER
if nargin<2, param = [0.6 0.6 0.6]; end  % default: gray figures
	p=bar(dist);
	set(p,'FaceColor',param,'EdgeColor','k');
end

distsize = length(dist);

%%%%%%%%% IVDIRDIST
	if distsize==12 
		if distdim==1
			if min(dist)<0 | abs(sum(dist)-1)>0.001 
				set(p,'FaceColor',param,'EdgeColor','k');
				set(gca,'YLim',[-1 1],'Layer','top');
				set(gca,'XLim',[.5 12.5],'Layer','top');
				set(gca,'YTickLabel',0:.1:1) % 
				label = {'MI2','MA2','MI3','MA3','P4','D5','P5','MI6','MA6','MI7','MA7','P8'};
				label=cellstr(label')';
				set(gca,'XTickLabel',(label),'FontSize',12);
				ylabel('Proportion ascending (%)','FontSize',14)
				line(0.5:.01:12.5,0,'LineWidth',22,'LineStyle','-','Color',[0.15 0.15 0.15])
			end
%%%%%%%%% IVDIRDIST

		[r,label] = refstat('pcdist1essen');
		tick = 1;
		stringlabel = 'Pitch-class';
		else
		[r,label] = refstat('pcdist1essen');
		tick = 1;
		stringlabel = 'Pitch-class';
		end
	elseif distsize==25
		[r,label] = refstat('ivdist1essen');
			label2 = strrep(label, 'D','-');
			label3 = strrep(label2, 'U','+'); 
		label=label3(1:3:end);
		tick = 3;
		stringlabel = 'Interval';
	elseif distsize==9
		[r,label] = refstat('durdist1essen');
		tick = 1;
		stringlabel = 'Duration';
	elseif distsize==24
		[label] = keyname(1:2:24);
		tick = 2;
		stringlabel = 'Key';
	elseif distsize==13
		label = {'P1','MI2','MA2','MI3','MA3','P4','D5','P5','MI6','MA6','MI7','MA7','P8'};
		label=cellstr(label')';
		tick = 1;
		stringlabel = 'Interval';
	else
		disp('unknown matrix size')
		return
	end

if distdim > 1  % transition plot

	% label X-axis
		xlabel(strcat(stringlabel,' 2'),'FontSize',14);
		set(gca,'XTick',1:tick:distsize);
		set(gca,'XTickLabel',(label),'FontSize',12);
	% label Y-axis
		ylabel(strcat(stringlabel,' 1'),'FontSize',14);
		set(gca,'YTick',1:tick:distsize);
		set(gca,'YTickLabel',(label),'FontSize',12);
else
	% label X-axis
		if min(dist)<0 || abs(sum(dist)-1)>0.001
		else
			xlabel(stringlabel,'FontSize',14);
			set(gca,'XTick',1:tick:distsize);
			set(gca,'XTickLabel',(label),'FontSize',12);
		end
	
	% label Y-axis
		ylabel('Proportion (%)','FontSize',14)
end
if 	distsize==24, ylabel('Corr. coeff.','FontSize',14); end
