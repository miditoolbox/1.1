function y = meldistance(nmat1,nmat2,repr,metric,samples,rescale)
% Measurement of distance between two NMATs
% y=melsim(nmat1,nmat2,<repr>,<metric>,<samples>,<rescale>)
% Calculates the similarity of two NMATs in a particular representation.
% Output is a value indicating distance between nmat1 and nmat2 under 
% the given representation and metric. Output value is rescaled to [0, 1] if 
% rescale is set to 1.
%
% Input arguments:
%	NMAT1= first notematrix
%	NMAT2= second notematrix
%   REPR= string denoting the specific representation used for comparison of the two NMATs:
%       'pcdist1' (default)= distribution of pitch classes
%       'pcdist2'= distribution of pitch class dyads
%       'ivdist1'= distribution of intervals
%       'ivdist2'= distribution of interval dyads
%       'contour'= melodic contour (input number of samples)
%       'combcontour'= Combinatorial Contour (does not accept a metric argument)
%       'durdist1'= distribution of note durations
%       'durdist2'= distribution of note duration dyads
%   METRIC= string denoting the distance metric used for comparison:
%       'taxi' (default)=the taxicab norm
%       'euc'=euclidean distance measure
%       'cosine' =measure of cosine of the angle between vectors
%   SAMPLES= integer number of samples for contour representation.
%            default value is 10.
%   RESCALE= rescales distance to similarity value between 0 and 1. Default 
%            is no rescaling. Set to 1 to rescale values.
%       
% Output:
%	y = value representing the distance between the two 
%       melodies under the given representation and metric.
%
% Example: 
%	meldistance(nmat1,nmat2,'pcdist1','taxi');
%
% Authors:
%  Date		Time	Prog	Note
% 15.2.2004	15:30	MB	Created under MATLAB 6.1 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyväskylä, Finland
% See License.txt

if isempty(nmat1), return; end
if isempty(nmat2), return; end
if ~ismonophonic(nmat1), disp([mfilename, ' works only with monophonic input!']); y=[]; return; end
if ~ismonophonic(nmat2), disp([mfilename, ' works only with monophonic input!']); y=[]; return; end

% Includes firstnbeats selector function, combcontour CSIM matrix constructor
if nargin <3
    repr='pcdist1';
    metric='taxi';
    rescale=0;
elseif nargin <4
    metric='taxi';
    rescale=0;
elseif nargin<5
    samples=10;
    rescale=0;
elseif nargin<6
    rescale=0;
end
switch lower(repr)
 
%if representation is a normalised distribution, we only need to calculate it.
case {'ivdist1','ivdist2','pcdist1','pcdist2','durdist1','durdist2'}
    repr_of_1=feval(char(repr),nmat1);
    repr_of_2=feval(char(repr),nmat2);
    y=distance(repr_of_1,repr_of_2,metric);
    %Now we rescale to map y->[0,1]
    if rescale
        if strcmp(metric,'taxi')
        refl=1;
    elseif strcmp(metric,'euc')
        refl=1;
    elseif strcmp(metric,'cosine')
        refl=.15;
    end
    if y < refl
    y=(2*(refl-y)+y)/2;
    else
        y=(y-2*(y-refl))/2;
    end
end

%if the representation chosen is contour, we need to scale the contour stepsize so that 
%both contour vectors are of the same length. Note: in order to be useful we are operating 
%under theassumption that the nmats passed to mel_sim are of reasonably similar length.
case 'contour'
    repr_of_1=melcontour(nmat1,samples,'rel');
    repr_of_2=melcontour(nmat2,samples,'rel');
%Now we subtract the mean of the contour vectors to effectively discard pitch height
    repr_of_1=repr_of_1-mean(repr_of_1);
    repr_of_2=repr_of_2-mean(repr_of_2);
    y=distance(repr_of_1,repr_of_2,metric);
    if rescale % rescale y->[0,1]
        if strcmp(metric,'taxi')
        refl=8*samples;
    elseif strcmp(metric,'euc')
        refl=2*samples;
    elseif strcmp(metric,'cosine')
        refl=15*samples;
        y=y+11*samples;
    end    
     if y < refl
         y=(2*refl-y)/(2*refl);
     else
         y=(y-2*(y-refl))/(2*refl);
    end
   end


case 'combcontour'
notes1=length(nmat1);
notes2=length(nmat2);

if notes1>=notes2
    repr_of_1=combcontour(nmat1(1:notes2,:));
    repr_of_2=combcontour(nmat2);
else
    repr_of_1=combcontour(nmat1);
    repr_of_2=combcontour(nmat2(1:notes1,:));
end;
     diff=abs(repr_of_1-repr_of_2); %Comb contour ignores the chosen metric and uses the CSIM metric instead.
     n=length(diff);
     y=(sum(sum(diff)))/(n^2-n);
    % rescale to map y=[0,1]
    if rescale
    refl=.5;
    if y < refl
    y=(2*(refl-y)+y);
else
    y=(y-2*(y-refl));
end
end
end
