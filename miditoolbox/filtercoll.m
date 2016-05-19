function coll2 = filtercoll(coll, filtername, varargin)
% Filter collection using a specified FILTERNAME function
% function data = filtercoll(coll,filtername, <varargin>);
% FILTERCOLL works only with functions that take the notematrix as
% input argument.
%
% Input arguments:
%	COLL = name of the collection
%	FILTERNAME = name of the FILTER function
%	<VARARGIN> = possible other orguments to be passed to filter function FUNNAME
%
% Output:
%	COLL2 = vector or matrix containing the output of function FUNNAME
%	with each notematrix of the collection used as input argument
%
% Example:
% 	FNM = filtercoll(nm, 'trans',7); % transpose the whole collection a fifth up
%	
% Change History :
% Date		Time	Prog	Note
% 1.10.2003	12:58	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox Software Package, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

% check for additional arguments
% analyze first notematrix, check variable length and allocate

disp(strcat('Collection size: ',num2str(length(coll))));

h = waitbar(0,'Please wait ...');

% analyze
for k=1:length(coll)
	if ~isempty(coll{k})
		coll2{k} = feval(char(filtername), coll{k},varargin{:});
	else % if NM is empty
		disp(strcat('notematrix ', str2num(k), ' is empty!'));
	end
	waitbar(k/length(coll));
end

close(h);
