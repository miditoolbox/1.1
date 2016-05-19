function analyzedir(ofname,varargin)
% Analysis of MIDI files in a directory
% analyzedir(ofname,varargin);
% Analyzes all the midi files in the current directory
% using the functions whose names are given as input arguments
% and writes the result to file OFNAME.
%
% Input arguments: 
%	OFNAME = output filename (string)
%	VARARGIN = name(s) of the function(s) (strings)
%
% Output: file OFNAmE and diagnostic index of processed files
%
% Remarks: This function works only with functions that take the notematrix as
%	input argument and return only one output argument. Also the midi files 
%     must have the postfix '.mid'. To create the output file outside of current directory,
%	the full path name has to be included in the first argument.
%
% Example:
%     analyzedir('myOutputFile', 'pcdist1', 'ivdist1', 'durdist1');
%
% Authors:
%  Date		Time	Prog	Note
% 4.6.2002	18:36	PT	Created under MATLAB 5.3 (Mac)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

fid = fopen(ofname,'wt');
if fid==-1
	disp('Could not open output file.');
	return;
end
d=dir('*.mid');
data=[];
rejected=[];

%---------------------> WAITBAR <-----------------------
	wtime = waitbar(0,'Please wait...');
	wtotal=length(d);
%---------------------> WAITBAR <-----------------------

% analyze first file and store variable lengths and function names
varlen = [];
funname = cell(size(varargin,2),1);
nm = readmidi(d(1).name);
for m=1:size(varargin,2)
	tmp = feval(char(varargin(m)),nm);
	varlen = [varlen length(tmp)];
	data = [data tmp];
	funname(m)=varargin(m);
end

% write header row of output file
fprintf(fid,'name\t');  % "name" lisätty (TE 12. kesäkuuta 2002)
for k=1:size(funname,1)
	if varlen(k)==1
		fprintf(fid,'%s\t',char(funname(k)));
	else % if the function returns multidimensional output add component number
		for m=1:varlen(k)
			fprintf(fid,'%s\t',strcat(char(funname(k)),num2str(m)));
		end
	end
end
fprintf(fid,'\n');

%write first data row
fprintf(fid,'%s',d(1).name);
fprintf(fid,'\t%f',data);
fprintf(fid,'\n');

% analyze the rest of the files
if size(d,1)>1
	for k=2:size(d,1)
		data=[];
%---------------------> WAITBAR <-----------------------
	waitbar(k/wtotal)
%---------------------> WAITBAR <-----------------------

		nm = readmidi(d(k).name);
		if ~isempty(nm)
			for m=1:size(varargin,2)
				data = [data feval(char(varargin(m)),nm)];
			end
			% write to file
			fprintf(fid,'%s',d(k).name);
			fprintf(fid,'\t%f',data);
			fprintf(fid,'\n');
		else % if NM is empty
			disp('REJECTED!');
			rejected=[rejected k];
		end
	end
end

close(wtime); 

fclose(fid);

% print report
disp('*************************');
disp('Number of files analyzed:')
disp(num2str(size(d,1)-length(rejected)));
disp('Number of files rejected:')
disp(num2str(length(rejected)));

if length(rejected)>0
	disp('*************************');
	disp('Rejected files:');
	for k=1:length(rejected)
		disp(d(rejected(k)).name);
	end
	disp('*************************');
end
