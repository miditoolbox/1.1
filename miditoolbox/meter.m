function m = meter(nmat,option)
% Autocorrelation-based estimate of meter
% m = meter(nmat,<option>)
% Returns an autocorrelation-based estimate of meter of NMAT.
% Based on temporal structure and on Thomassen's melodic accent.
% Uses discriminant function derived from a collection of 12000 folk melodies.
% m = 2 for simple duple
% m = 3 for simple triple or compound
%
% Input argument:
%	NMAT = notematrix
%	OPTION (Optional, string) = Argument 'OPTIMAL' uses a weighted combination
%      of duration and melodic accents in the inference of meter (see Toiviainen & Eerola, 2004).
%
% Output:
%	M = estimate of meter (M=2 for simple duple; M=3 for simple triple or compound)
%
% References:
%     Brown, J. (1993). Determination of the meter of musical scores by 
%         autocorrelation. Journal of the Acoustical Society of America, 
%         94(4), 1953-1957.
%     Toiviainen, P., & Eerola, T. (2006). Autocorrelation in meter induction: the role of accent structure. Journal of the Acoustical Society of America, 119(2), 1164-1170.
%
% Change History :
% Date		Time	Prog	Note
% 11.8.2002	18:36	PT	Created under MATLAB 5.3 (Macintosh)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end

if nargin<2

	ac = ofacorr(onsetfunc(nmat,'dur'));
	if ac(4) >= ac(6)
		m = 2;
	else
		m = 3;
	end

else
if ~ismonophonic(nmat), disp(' Optimized version works only with monophonic input!'); m=[]; return; end
	if strcmp(lower(option), 'optimal')~=1
			disp(['Unknown option:' option])
			disp('Accepted option is ''optimal''! ')
			return
	end
	m = weighted_meter(nmat);
end

%%%%%%%%%  Optimized (weighted) function
function m = weighted_meter(nmat)
% m = weighted_meter(nmat);

ac1 = ofacorr(onsetfunc(nmat));
ac2 = ofacorr(onsetfunc(nmat,'melaccent'));

% discriminant function

df = -1.042+0.318*ac1(3)+5.240*ac1(4)-0.63*ac1(6)+0.745*ac1(8)-8.122*ac1(12)+4.160*ac1(16);
df=df-0.978*ac2(3)+1.018*ac2(4)-1.657*ac2(6)+1.419*ac2(8)-2.205*ac2(12)+1.568*ac2(16);

if df>=0
	m = 2;
else
	m = 3;
end
