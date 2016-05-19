function c = melcontour(nmat,res,meth,opt,timetype)
% Contour vector
% function c = melcontour(nmat,res,meth,<opt>);
% Returns the contour vector of the melody in NMAT.
%
% Input arguments:
%	NMAT = note matrix
%	RES = parameter defining the temporal resolution of C (see below)
%	METH = method for defining temporal resolution (= 'abs' or 'rel')
%		if METH=='abs', RES is defined as the sampling interval
% 			in beats
%		if METH=='rel', RES is defined as the number of sampling
%			points
%		default value for METH is 'abs'
%     OPT = if 'AC', returns the autocorrelation function of the contour vector of NMAT
%
% Output:
%	C = contour vector (or autocorrelation vector)
%
% Example:
%	c = melcontour(NMAT, 0.25, 'abs'); % uses a step of 0.25 beats
%	c = melcontour(NMAT, 32, 'rel'); % uses 32 sampling points
%	ac = melcontour(NMAT, 0.5, 'abs','ac'); % Autocorrelation function of the contour
%
% Reference:
% Eerola, T., Himberg, T., Toiviainen, P., & Louhivuori, J. (2006). Perceived complexity of Western and African folk melodies by Western and African listeners. Psychology of Music, 34(3), 341-375.
%
% Change History :
% Date		Time	Prog	Note
% 11.8.2002	18:36	PT	Created under MATLAB 5.3 (Macintosh)
%© Part of the MIDI Toolbox Software Package, Copyright © 2002, University of Jyväskylä, Finland
% See License.txt

if isempty(nmat), return; end
if ~ismonophonic(nmat), disp([mfilename, ' works only with monophonic input!']); c=[]; return; end

if nargin<5, timetype='beat'; end
ob = onset(nmat,timetype);
p = pitch(nmat);
db = dur(nmat,timetype);
ob = ob-ob(1);
totlen=ob(end)+db(end);

if nargin==2, meth='abs'; end
if strcmp(meth,'abs'), b = 0:res:totlen;
elseif strcmp(meth,'rel'), step=totlen/res; b=step*(0:(res-1));
else disp('ERROR : METH must be set to abs or rel'); c=[]; return;
end

c=zeros(1,length(b));
for k=1:length(b)
	last=max(find(ob<=b(k)));
	c(k)=p(last);
end

% AC
if nargin==4 && strcmp(opt,'ac')
	cc = c-mean(c);
	cc = cc/sqrt(sum(cc.*cc)); clear c
	c = xcorr(cc);
elseif nargin==4
	c=[];
	disp('OPT accepts only ''AC'' option!');
end
