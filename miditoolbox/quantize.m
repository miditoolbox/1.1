function nm2 = quantize(nmat,onsetres,durres,filterres)
% Quantize note onsets and durations of NMAT
% nm2 = quantize(nmat, onsetres, <durres>, <filterres>)
% Quantize note events in NMAT according to onset resolution
% (ONSETRES), durations resolution (DURRES) and optionally filter
% note events shorter than the filter threshold (FILTERRES).
% 
% Input arguments:
%	NMAT = notematrix
%	ONSETRES = onset threshold for quantization (e.g., quarter note = 1/4).
%         Default value is 1/8 note.
%	DURRES (optional) = duration threshold for quantization. Default is double
%         the value of ONSETRES.
%	FILTERRES (optional) = duration threshold for filtering out notes. For example, 
%         to filter out eight notes and shorter notes events, FILTERRES of 
%         1/8 can be used.
%
% Output:
%	NM2 = quantized notematrix
%
% Example: Quantize NMAT to quarter notes (onsets and durations)
% and filter out all notes shorter than 1/8 beats
%	nm2 = quantize(nmat, 1/4, 1/4,1/8);
%
% Change History :
% Date		Time	Prog	Note
% 18.6.2002	18:37	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if nargin<4, filterres=[]; end
if nargin<3, durres=[]; end
if nargin<2, onsetres=1/8; durres=onsetres/2; end % default values

onsetresb = (onsetres)*4; durresb = (durres)*4;
ob=onset(nmat); db=dur(nmat);
nm2=nmat;

%%%% quantize onsets
ob2=round(ob/onsetresb)*onsetresb;
nm2(:,1)=ob2;
div=nmat(end,1) / nmat(end,6); % fix the onsets in seconds
nm2(:,6)=ob2/div;

%%%% quantize durations if specified by DURRES
if isempty(durres)==0
	db2=round(db/durresb)*durresb;
	nm2(:,2)=db2;
	div_d=nmat(end,2) / nmat(end,7); % fix the durations in seconds
	nm2(:,7)=db2/div_d;
end
% drop shorter notes than the quantization threshold if specified by FILTERRES
if filterres>=0
	nm2=dropshortnotes(nm2,'beat',onsetres);
end
