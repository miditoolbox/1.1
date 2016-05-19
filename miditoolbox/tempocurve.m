function tempo = tempocurve(nm)
% Onset times in beats or seconds
% tempo = tempocurve(NMAT);
% Returns the tempo curve of NMAT
%
% Input argument:
%	NMAT = notematrix
%
% Output:
% 	TEMPO = tempo in bpm at each onset of NMAT
%
%  Date		Time	Prog	Note
% 17.5.20016	14:07	PT	Created under MATLAB R2015a (Mac)
% Part of the MIDI Toolbox, Copyright 2016, University of Jyvaskyla, Finland

tmp1=diff(onset(nm,'sec'));
tmp2=diff(onset(nm));
ind=find(tmp1>0);
bpm=60./(tmp1(ind)./tmp2(ind));

tempo=zeros(size(tmp1));
tempo(1:ind(1))=bpm(1);
for k=2:(length(ind)-1)
    tempo(ind(k):(ind(k+1)-1))=bpm(k);
end
tempo(ind(end):length(tempo))=bpm(end);
tempo=[NaN; round(tempo,3)];

