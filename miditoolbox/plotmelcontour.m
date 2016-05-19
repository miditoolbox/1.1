function p = plotmelcontour(nmat,varargin)
% Plot melodic contour
% p = plotmelcontour(nmat,varargin)
% Plot melodic contour using a user-defined resolution. Various other output 
% options can be used (VARARGIN).
%
% Input argument:
%	NMAT = notematrix
%     VARARGIN = Various other parameters:
%           STEP (numeric) = resolution (optional), see 'abs' or 'rel' below:
%	         'abs' defines the sampling interval in beats (default)
%	          rel' defines the number of sampling points
%	       'beat' (default) defines the timetype in beats
%            'sec' defines the timetype in seconds
%	      COLOR OPTIONS, e.g., 'r:' for red, dotted line... (optional)
%           'ac' for autocorrelation figure (optional).
%              This option plots the contour self-similarity of NMAT. 
%              The similarity is based on autocorrelation, where the melodic contour 
%              is correlated with a copy of itself. A short duration (approximately one 
%              measure) from the beginning is left out in the plot.
%
% Output:
%	P = Figure
%
%
% Example 1: plot melodic contour
%                plotmelcontour(laksin,0.1,'abs',':ok');
%
% Example 2: plot contour self-similarity
%                plotmelcontour(laksin,0.1,'abs','r','ac');
%
% Change History :
% Date		Time	Prog	Note
% 5.8.2003	11:46	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end

% INITIALIZE PARAMETERS
step=[]; meth=[]; timetype=[];  color=[]; ptype=[];

for i=1:length(varargin)
	if ~iscellstr(varargin(i)), step=varargin{i};
	elseif strcmp(varargin(i),'abs'), meth='abs';
	elseif strcmp(varargin(i),'rel'), meth='rel';
	elseif strcmp(varargin(i),'beat'), timetype='beat'; 
	elseif strcmp(varargin(i),'sec'), timetype='sec';
	elseif strcmp(varargin(i),'ac'), ptype='ac';
	elseif iscellstr(varargin(i))
		color=char(varargin(i)); % no error checking for invalid line options!
	end
end

% DEFAULT VALUES FOR PARAMETERS
if isempty(step), step=.5; end;
if isempty(meth), meth='abs'; end;
if isempty(timetype), timetype='beat'; end;
%if isempty(color), color='b-o'; end;
if isempty(ptype), ptype=''; end;
if isempty(color) && strcmp(ptype,'ac'), color='b';
elseif isempty(color) && ~strcmp(ptype,'ac'), color='b-o';
else
end;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	c = melcontour(nmat,step,meth);
	ctime=step*(0:(length(c)-1));
	max_duration=(max(onset(nmat,timetype))+ dur(nmat(end,:),timetype)); % removed 'round' from the first dur par.

if strcmp(meth,'rel')
	ctime2=(0:(length(c)-1));
	div=max_duration / ctime2(end);
	ctime=ctime2*div;
end

if strcmp(ptype,'ac')
	ac = melcontour(nmat,step,meth,'ac'); % step
	ac2 = ac(((length(ac)+1)/2)+4:end);
	ac3 = ac2.* (ac2 > 0);% half-wave rectification

	% Settings for the x axis
	os=onset(nmat,timetype);
	ds = dur(nmat,timetype);
	kesto = os(end)+ds(end);
	ac3length = length(ac3);
	kesto_aika = 0:(kesto/(ac3length-1)):kesto;

	% Plot stem graph
	p=plot(kesto_aika+1, ac3,'-k');
	h=area(kesto_aika+1, ac3,'FaceColor',color,'EdgeColor',[.1 .1 .1]);

	axis([0 kesto 0.01 0.65]) ;
	xlabel(['\bfLag (', timetype,'s)'],'FontSize',12);
	ylabel('\bfCorr. coef.','FontSize',12);

	legend_text = ['Autocorr. sampl. res. (beats)=', num2str(step)];
	legend(legend_text);
else

	h=plot(ctime,c,color);
		axis([-Inf max_duration min(c)-5 max(c)+5]); % max_duration
		xlabel(['\bfTime (', timetype,'s)'],'FontSize',12);
		ylabel('\bfMidinote','FontSize',12);
		set(gca,'XTick',min(ctime):2:max_duration);
		set(gca,'Xgrid','on');
		set(gca,'GridLineStyle',':');

	if strcmp(meth,'rel')
		legend_text = ['Number of samples=', num2str(step)];
		legend(legend_text);
	else	
		legend_text = ['Resolution in beats=', num2str(step)];
		legend(legend_text);
	end

end
