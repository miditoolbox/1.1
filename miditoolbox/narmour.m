function n = narmour(nmat,prin)
% Predictions from Implication-realization model by Narmour (1990)
% n = narmour(nmat,prin);
% Returns the predictions from Implication-realization model by Narmour (1990)
%
% Input arguments: NMAT = notematrix
%         PRIN denotes a specific principle:
%         rd = registral direction (revised, Schellenberg 1997)
%         rr = registral return (revised, Schellenberg 1997)
%         id = intervallic difference
%         cl = closure
%         pr = proximity (revised, Schellenberg 1997)
%         co = consonance (Krumhansl, 1995)
%
% Output: N = vector for all the tones in NMAT
%
% Remarks:
%
% Example: narmour(nmat, 'rd');
%
% References:
% Narmour, E. (1990). The Analysis and cognition of basic melodic structures: 
%       The Implication-realization model. Chicago, IL: University of Chicago Press.
% Krumhansl, C. L. (1995). Effects of musical context on similarity and expectancy. 
%      Systematische musikwissenschaft, 3, 211-250.
% Schellenberg, E. G. (1997). Simplifying the implication-realization model of 
%      melodic expectancy. Music Perception, 14, 295-318.
%
%  Author	Date
%  T. Eerola	1.2.2003
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if ~ismonophonic(nmat), disp([mfilename, ' works only with monophonic input!']); n=[]; return; end

if nargin<2, prin='pr'; end; % default value

switch lower(prin),

 case 'rd'
%---------------------> REGISTRAL DIRECTION (REVISED)  #1 <-----------------------   
%   if small interval (0)
%   if large and followed by change in direction (1)
%   for large intervals followed by same direction (-1)
%   (Thompson p. 248, Schellenberg 1996)
pc=pitch(nmat);
n=zeros(1,length(pc));

	for i=1:length(pc)-2
	   notewindow3=pc(i:i+2);
	   interval=diff(notewindow3);

		if interval(1)<6
		n(i+2)=0;
		elseif interval(1)>6 && sign(interval(1))~=sign(interval(2))
		n(i+2)=1;
		elseif interval(1)>6 && sign(interval(1))==sign(interval(2))
		n(i+2)=-1;
		end
	 end
n=n';
 case 'rr'
%---------------------> REGISTRAL RETURN (REVISED) #2 <-----------------------         
%   if second realized tone is within 2 semitones of the 
%   first tone in the implied interval, 1 (*1.5), others 0. 
%   This is the version revised by Schellenberg (1996)
%   better modifier* suggested by Schellengerg (1997).
pc=pitch(nmat);
n=zeros(1,length(pc));

	for i=1:length(pc)-2
	   notewindow3=pc(i:i+2);	
	   interval=diff(notewindow3);
	  	 
		rr0=abs(sum(interval));
		if notewindow3(2)==0, n(i+2)=0;
		elseif rr0<=2
			n(i+2)=1.5;
		end
	end
n=n';	
 case 'cl'
%---------------------> CLOSURE <-----------------------    
%   closure occurs when registral direction changes, or when a large interval
%   is followed by a smaller interval (i.e. smaller by more than 3 semitones
%   if registral direction is the same, or smaller by two semitones otherwise). 
%   All events that satisfy this condition are assigned a score of 1, and all
%   other events are assigned a score of 0.
pc=pitch(nmat);
n=zeros(1,length(pc));
	for i=1:length(pc)-2
	   notewindow3=pc(i:i+2);
	   interval=diff(notewindow3);

%		if interval(1)<6  % small interval
%		      n(i+2)=0;
		if sign(interval(1))~=sign(interval(2)) && (abs(interval(1))-abs(interval(2)))<3 % diff + 
		      n(i+2)=1; % OK
		elseif sign(interval(1))~=sign(interval(2)) && (abs(interval(1))-abs(interval(2)))>2
		      n(i+2)=2; % OK
		elseif sign(interval(1))==sign(interval(2)) && (abs(interval(1))-abs(interval(2)))>3
		      n(i+2)=1; % OK
		else 
		      n(i+2)=0;
		end
	end
n=n';
 case 'id'
%---------------------> INTERVALLIC DIFFERENCE  <-----------------------
%   This states that small implicative intervals (i.e. perfect fourth or less) 
%   imply similarly-sized realized intervals whereas large implicative 
%   intervals imply comparatively smaller intervals. 'Similarly-sized' 
%   realized intervals after a small interval are defined as the same size   
%   +- three semitones and if the realized interval changes registral direction, 
%   then they are defined as the same size +-two semitones. All events 
%   fulfilling these conditions are assigned a score of 1 whereas other events 
%   are assigned a value of 0.
%   Derived from Schellenberg, 1997, p. 296-297).
pc=pitch(nmat);
n=zeros(1,length(pc));
	for i=1:length(pc)-2
	   notewindow3=pc(i:i+2);
	   interval=diff(notewindow3);
	   	if interval(1)<6 && sign(interval(1))~=sign(interval(2)) && abs(abs(interval(1))-abs(interval(2)))<3  % pieni ja eri  suunta
		      n(i+2)=1;
	   	elseif interval(1)<6 && sign(interval(1))==sign(interval(2)) && abs(abs(interval(1))-abs(interval(2)))<4  % pieni ja sama  suunta
		      n(i+2)=1;
		elseif interval(1)>6 && abs(abs(interval(1))>=abs(interval(2)))  % iso ja pienempi
		      n(i+2)=1;
		else 
		      n(i+2)=0;
		end

	end
n=n';
 case 'pr'
%---------------------> PROXIMITY <-----------------------
% Linear coding of pitch proximity

pc=pitch(nmat);

n = 6-[0 abs(diff(pitch(nmat)))']; %PT
n = max(0,n); %PT
n = abs(diff(pitch(nmat)))'; %TE
n=[0 n];
n=n';
 case 'co'
%---------------------> CONSONANCE <-----------------------
% i.e. if consonant with previous tone (see Krumhansl 1995 "Effects of musical context on similarity and expectancy", Systematische musikwissenschaft or Krumhansl (1990), p. 57.
consonance=[10,1,4.16,6.03,7.25,8.03,5.76,9.16,6.32,7.76,5.66,3.8];
iv=pitch(nmat);
pcdiff=diff(iv);
pcdiff0=[0 pcdiff']; % 
iv25=mod(abs(pcdiff0),12).*sign(pcdiff0)+13; % sisältää maksimi ja minimi rajoittiminen
iv12=mod(abs(pcdiff0),12)+1; % in semitones, no directions
n=consonance(iv12);
n=n';
end
