function c = combcontour(nmat)
% Builds the Marvin & Laprade (1987) representation of melodic contour
% c = combcontour(nmat)
% For a melody nmat with n notes, combcontour builds an n x n matrix 
% of ones and zeros. A one is inserted in the i,j-th entry if the 
% pitch of note i is higher than the pitch of note j. A zero is inserted 
% otherwise. This matrix is a representation of melodic contour, 
% preserving relative rather than specific pitch height information.
%
% Input arguments:
%	NMAT = notematrix
% 
% Output:
%	C = matrix of ones and zeros representing melodic contour.
% 
% Example:
%	m = combcontour(nmat) 
%
% Reference:
%  Marvin, E. W. & Laprade, P. A. (1987). Relating music contours: 
%       Extensions of a theory for contour. Journal of Music Theory,
%       31(2), 225-267.
%
% Change History :
% Date		Time	Prog	Note
% 17.3.2004	14:00	MB	Created under MATLAB 6
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

if isempty(nmat), return; end
if ~ismonophonic(nmat), disp([mfilename, ' works only with monophonic input!']); c=[]; return; end

a=length(nmat);
p=pitch(nmat);
c=zeros(a,a);
for k=1:a
    c(k:a,k)=p(k)>p(k:a);
end