function y = complebm(nmat,method)
% Expectancy-based model of melodic complexity (Eerola & North, 2000)
% y = complebm(nmat,<method>);
% Expectancy-based model of melodic complexity based either on pitch 
% or rhythm-related components or 
% on an optimal combination of them together (METHOD).
% 
% The output is calibrated with the Essen collection so that 
% the mean value in the collection is 5 and standard deviation is 1.
% The higher the output value is, the more complex the NMAT is.
%
% Input arguments: NMAT = notematrix
%         METHOD stands for a specific method:
%             'p'  = pitch-related components only (
%             'r'  = rhythm-related components only
%             'o'  = optimal combination of pitch- and 
%			rhythm-related components
%
% Output: y = integer for complexity that is calibrated in
% relation to Essen Collection. Higher values = higher complexity.
%
% Example: Analyze a folk tune 'laksin' for its pitch-related complexity:
%		complebm(laksin,'p')
% ans = 4.6506
%
% The answer means that the tune is somewhat less complicated 
% than the average tune in Essen collection (0.35 standard deviations lower).
%
% References:
%     Eerola, T. (in press). Expectancy-violation and information-theoretic
%          models of melodic complexity. Empirical Musicology Review.
%     Eerola, T. & North, A. C. (2000) Expectancy-Based Model of Melodic 
%          Complexity. In Woods, C., Luck, G.B., Brochard, R., O'Neill, S. A., 
%          and Sloboda, J. A. (Eds.) Proceedings of the Sixth International 
%          Conference on Music Perception and Cognition. Keele, Staffordshire,
%          UK: Department of Psychology. CD-ROM.
%	  Eerola, T., Himberg, T., Toiviainen, P., & Louhivuori, J. (2006). Perceived 
%           complexity of Western and African folk melodies by Western and African
%           listeners. Psychology of Music, 34(3), 341-375.
%
% Change History :
% Date		Time	Prog	Note
% 27.3.2003	10:51	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if ~ismonophonic(nmat), disp([mfilename, ' works only with monophonic input!']); y=[]; return; end

if nargin<2, method='o'; end; % default value

switch lower(method),

case 'p'
	constant = -0.2407; % mean value of Essen collection is 0
	aveint_ = mean(diff(pitch(nmat))) * .3;
	pcd1_ = entropy(pcdist1(nmat)) * 1;
	ivd1_ = entropy(ivdist1(nmat)) * .8;
		ton=tonality(nmat);
		d = duraccent(dur(nmat,'sec'));
		tonD = d .* ton;
		ton_ = mean(tonD)*-1;
	y = (constant + aveint_ + pcd1_ +ivd1_ + ton_)/0.9040; % divided by std (in Essen)
	y=y+5; % mean value is 5 
	
case 'r'
	constant = -0.7841; % mean value of Essen collection is 0
	dud_ = entropy(durdist1(nmat)) * .7;
	noteden_ =	notedensity(nmat,'sec') * .2;
	du =dur(nmat,'sec'); du=du(du>0);
	rhyvar_ =(std(log(du))) * .5;
	metach_ = meteraccent(nmat) * .5;
	y = (constant + dud_ + noteden_ + rhyvar_ + metach_)/0.3637; % divided by std (in Essen)
	y=y+5; % mean value is 5
	
case 'o'
	constant = -1.9025; % mean value of Essen collection is 0
	aveint_ = mean(diff(pitch(nmat))) * .2;
	pcd1_ = entropy(ivdist1(nmat)) * 1.5;
	ivd1_ = entropy(ivdist1(nmat)) * 1.3;
		ton=tonality(nmat);
		d = duraccent(dur(nmat,'sec'));
		tonD = d .* ton;
	ton_ = mean(tonD)*-1;
	dud_ = entropy(durdist1(nmat)) * .5;
	noteden_ =	notedensity(nmat,'sec') * .4;
	du =dur(nmat,'sec'); du=du(du>0);
	rhyvar_ =(std(log(du))) * .9;

	metach_ = meteraccent(nmat) * .8;
	y = (constant + aveint_ + pcd1_ + ivd1_ + ton_ + dud_ + noteden_ + rhyvar_ + metach_)/1.5034; % divided by std (in Essen)
	y=y+5; % mean value is 5
	
otherwise
	disp('Unknown method. Type ''p'', ''r'' or ''o'' for valid method. ')
end
