function data = analyzecoll(coll, funname, varargin)
% Analysis of collection using a specified function
% function data = analyzecoll(coll,functionname,<other arguments>);
%
% ANALYZECOLL works only with functions that take the notematrix as
% input argument and works only with functions returning either scalar 
% or row vector.
%
% Input arguments:
%	COLL = name of the collection
%	FUNNAME = name of the function
%	<OTHER ARGUMENTS> = possible other orguments to be passed to function FUNNAME
%
% Output:
%	DATA = scalar or row vector containing the output of function FUNNAME
%	with each notematrix of the collection used as input argument
%
% Example:
% 	keys = analyzecoll(collection, 'kkkey');
%
% Part of the MIDI Toolbox Software Package, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt
%
% Change History:
% Date		Time	Prog	Note
% 13.1.2002	14:25	PT	Created under MATLAB 5.3 (Macintosh)
%© Part of the MIDI Toolbox Software Package, Copyright © 2002, University of Jyväskylä, Finland
% See License.txt

if size(feval(funname,createnmat),1)>1
	disp([mfilename ' works only with functions returning either scalar or row vector!'])
	data=[];
	return
end



% check for additional arguments
% analyze first notematrix, check variable length and allocate
tmp = feval(char(funname), coll{1},varargin{:});
data = zeros(length(coll),size(tmp,2));
disp(strcat('Collection size: ',num2str(length(coll))));

h = waitbar(0,'Please wait ...');

% analyze
for k=1:length(coll)
	if ~isempty(coll{k})
		data(k,:) = feval(char(funname), coll{k},varargin{:});
	else % if NM is empty
		disp(strcat('notematrix ', str2num(k), ' is empty!'));
	end
	waitbar(k/length(coll));
end

close(h);

