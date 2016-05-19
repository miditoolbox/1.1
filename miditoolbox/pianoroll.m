function pianoroll(nmat,varargin)
% Plot pianoroll notation of NMAT
% pianoroll(nmat,varargin)
% Plots pianoroll notation of NMAT and takes several optional arguments
% that affect the information displayed.
%
% Input arguments: 
%	NMAT = notematrix
%     VARARGIN = various optional input arguments:
% 	   'name' = note names for y-axis (default)
%        'num' = MIDI numbers for y-axis
% 	   'beat'  = beats for x-axis (default)
%        'sec' = seconds for x-axis
% 	   'vel' = plot note velocities
%        'mh' = plot metric hierarchy
%        Color parameters, e.g. 'g' = Green pitches in pianoroll
%        'hold' = current pianoroll is added to a previous figure
%
% Output: Figure
%
% Remarks: Function displays NMATs with multiple channels using different colors
% for the different channels. A simple optimization of Y-scale labels is used 
% to increase the legibility of the output. 
% Also, the C notes are marked with dotted line in the plot. 
%
% Example 1: Plot pitches and their velocities using seconds as the x-axis
%   pianoroll(nmat,'vel','sec');
%
% Example 2: Plot two separate melodies into the same figure
%   pianoroll(nmat1,'r'); % 1st melody in red color
%   pianoroll(nmat2,'b','hold'); % 2nd melody in blue color
%
% Example 3: Plot multichannel NMAT (plot channels using different colors)
%   pianoroll(nmat3,'num'); %
%
% Authors:
%  Date		Time	Prog	Note
% 12.3.2004	11:47	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end

% INITIALIZE PARAMETERS
nameformat=[]; timeformat=[]; velformat=[];  color=[]; status=[];

for i=1:length(varargin)
	if strcmp(varargin(i),'hold'), status='hold'; end
	if strcmp(varargin(i),'num'), nameformat='num'; end
	if strcmp(varargin(i),'name'), nameformat='name'; end
	if strcmp(varargin(i),'beat'), timeformat='beat'; end
	if strcmp(varargin(i),'sec'), timeformat='sec'; end
	if strcmp(varargin(i),'vel'), velformat='vel'; end
	if strcmp(varargin(i),'mh'), velformat='mh'; end
	if iscell(varargin(i)) && length(char(varargin(i)))==1
		color=char(varargin(i));
	end
	 switch char(varargin(i))
		  case {'hold','num','name','beat','sec','vel','k','r','g','b','c','m','y','k','w'}
		  otherwise
		  disp([char(varargin(i)) ' is not valid parameter!'])
	end          
end

% DEFAULT VALUES FOR PARAMETERS
if isempty(nameformat), nameformat='name'; end;
if isempty(timeformat), timeformat='beat'; end;
if isempty(color), color='r'; end;

% INITIALIZE COLORS FOR MULTIPLE CHANNELS
c2=get(gca,'ColorOrder');
cols=repmat(c2,3,1);

% Clear Figure handle unless user wishes to plot on 
% top of the previous figure (hold)
if strcmp(status,'hold')==1
else
	clf
end

% IF MULTIPLE CHANNELS
m=mchannels(nmat);
if length(m)>1
	for i=1:length(m),
		n=getmidich(nmat,m(i));
		p=pitch(n);
		proll(n,nameformat,timeformat,velformat,cols(i,:),'hold');
		text(n(1),p(1)+1.5,['ch' num2str(i)],'Color', cols(i,:),'Fontsize',11);
	end
else
		proll(nmat,nameformat,timeformat,velformat,color,status);
end

function proll(nmat,nameformat,timeformat,velformat,color,status)
% proll(nmat,nameformat,timeformat,velformat,color,status);
% This function does the actual pianoroll plotting. The velocity plot was designed only 
% for single channel NMATs but kind of works for multiple channel NMATS.

if strcmp(status,'hold')==1

else
	clf
end

if strcmp(timeformat,'beat') == 1
	on=onset(nmat,'beat');
	off=on+dur(nmat,'beat');
	totaldur=max(onset(nmat)+dur(nmat));

else
	on=onset(nmat,'sec');
	off=on+dur(nmat,'sec');
	totaldur=max(onset(nmat,'sec')+dur(nmat,'sec'));

end

	p=pitch(nmat);
	minimi = min(pitch(nmat));
	maksimi = max(pitch(nmat));

if ischar(velformat)==1 && strcmp(velformat,'vel')==1 || strcmp(velformat,'mh')==1
	subplot(2,1,1)
			
elseif isempty(velformat)==1
else
	disp(['unknown VELFORMAT parameter ''', velformat, ''', use VEL'])
end;

hold on
for k=1:length(on)
   h=fill([on(k) off(k) off(k) on(k)],[p(k)-0.5 p(k)-0.5 p(k)+0.5 p(k)+0.5 ],color); end % default 'b'

%%%% AXIS
if strcmp(status,'hold')==1

	old=[totaldur minimi maksimi];
	aks=axis;
	if aks(2)>totaldur,totaldur=aks(2); end
	if aks(3)<minimi, minimi=aks(3); end
	if aks(4)>maksimi, maksimi=aks(4); end
	axis([0 totaldur minimi-0 maksimi+0]);
else
	axis([0 totaldur minimi-2 maksimi+2]);
end

	range = maksimi-minimi;
	if range < 12; interval = 1;
		elseif range < 24;	interval = 2;
		elseif range < 36;	interval = 3;
		elseif range > 35;	interval = 5;
	end
%%%% AXIS LABELS
		if strcmp(timeformat,'sec') == 1
			xlabel('Time in seconds','FontSize',13);
		else
			xlabel('Time in beats','FontSize',13);
		end

		ylabel('Pitch','FontSize',13);
				set(gca,'Xgrid','on');
				set(gca,'GridLineStyle',':');

%%%% y label
		set(gca,'YTick',[minimi-2:interval:maksimi+2]);

	if strcmp(nameformat,'num') ==1
	else
			scale= minimi-2:interval:maksimi+2;
			scalenames=notename(scale);
			set(gca,'YTickLabel',(scalenames));
	end

%%% MARK ALL C notes
	line([0 totaldur],[48 48],'LineWidth',1,'LineStyle','-','Color',[0.35 0.35 0.35])
	line([0 totaldur],[60 60],'LineWidth',1,'LineStyle','-','Color',[0.35 0.35 0.35])
	line([0 totaldur],[72 72],'LineWidth',1,'LineStyle','-','Color',[0.35 0.35 0.35])
	line([0 totaldur],[84 84],'LineWidth',1,'LineStyle','-','Color',[0.35 0.35 0.35])
	line([0 totaldur],[96 96],'LineWidth',1,'LineStyle','-','Color',[0.35 0.35 0.35])

	box on
hold off

%%%% VELOCITY & METRIC-HIERARCHY PLOT

if ischar(velformat)==1 && strcmp(velformat,'vel')==1 || strcmp(velformat,'mh')==1

	subplot(2,1,2)
	v=velocity(nmat);

	if strcmp(velformat,'vel')==1, % fill
		hold on
		for k=1:length(on)
		   h=fill([on(k) off(k) off(k) on(k)],[v(k)-0.9 v(k)-0.9 v(k)+0.9 v(k)+0.9 ],color); end
		hold off
	end

			axis([0 totaldur 0 128]);

			set(gca,'YTick',[0:20:128]);

	if strcmp(timeformat,'sec') == 1
		xlabel('Time in seconds','FontSize',13);
	else
		xlabel('Time in beats','FontSize',13);
	end

			ylabel('Velocity','FontSize',13);
			set(gca,'Xgrid','on');
			set(gca,'GridLineStyle',':');
			box on
		hold off

		if strcmp(velformat,'mh') == 1
		mh = metrichierarchy(nmat);
		h=stem(on, mh,color);
		axis([0 totaldur 2 6]);
%		set(h,'FaceColor',[0.6 0.6 0.6],'EdgeColor','k');


		if strcmp(timeformat,'sec') == 1
			xlabel('Time in seconds','FontSize',13);
		else
			xlabel('Time in beats','FontSize',13);
		end
			ylabel('Metrical hierarchy','FontSize',13);
			set(gca,'Xgrid','on');
			set(gca,'GridLineStyle',':');
			set(gca,'YColor',[0.05 0.05 0.05]);
			set(gca,'XColor',[0.05 0.05 0.05]);
			box on
		hold off

	end

end
