function nm = exptimewindow(nmat,time,tau,ttype);
% Exponential time windowing
% nm = exptimewindow(nmat,time,tau,ttype);
% Returns the notes in NMAT whose onset times satisfy
% TIME-2*TAU <= onsettime[beats/secs](NMAT) <= TIME
% With note durations weighted by exp((t-time)/tau);
%
% Input arguments:
%	NMAT = notematrix
%	TIME = maximum limit of the window in beats (default) or secs
%	TAU = decay constant of exponential weighting
%	ttype = time type, 'beat' (default) or 'sec' 
%
% Output:
%	NM = notematrix containing the notes of NMAT whose onsets
%	are within the window
%
% Change History :
% Date		Time	Prog	Note
% 11.8.2002	18:36	PT	Created under MATLAB 5.3 (Macintosh)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat) nm=[]; return; end
if nargin <4, ttype = 'beat'; end
maxtime=time; mintime=time-2*tau;
on = onset(nmat,ttype); du = dur(nmat,ttype); off = on+du;
nm = nmat(on<=maxtime & off>=mintime,:);
on2 = onset(nm,ttype); du2 = dur(nm,ttype); off2 = on2+du2;
off2 = min(maxtime,off2); du2 = off2-on2;
if strcmp(ttype,'sec') du2 = duraccent(du2); end

if isempty(nm) return; end

tsc=1; if nm(end,1)>0 tsc = nm(end,6)/nm(end,1); end

if strcmp(ttype, 'beat')==1
    nm(:,2)=du2.*exp((nm(:,1)-maxtime)/tau);
    nm(:,7) = nm(:,2)*tsc;
elseif strcmp(ttype, 'sec')==1
    nm(:,7)=du2.*exp((nm(:,6)-maxtime)/tau);
    nm(:,2) = nm(:,7)/tsc;
else
	disp(['Unknown timetype:' ttype])
	disp('Accepted timeformats are ''sec'' or ''beat''! ')
end