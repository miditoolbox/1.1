function nmat = mididemo(demonro)
% Run MIDI Toolbox demonstrations
% function nmat = mididemo(demonro);
%
% Input argument:
%	DEMONRO = number of demo
%
% Change History:
% Date		Time	Prog	Note
% 28.3.2004	14:49	TE	Created under MATLAB 5.3 (PC)
%© Part of the MIDI Toolbox, Copyright © 2004, University of Jyvaskyla, Finland
% See License.txt

p1 = cd; p2 = which('mididemo'); cd(p2(1:end-10)); % PT

a(1)={'EXAMPLE 1: VISUALIZING AND PLAYING MIDI DATA'};
a(2)={'EXAMPLE 2: MELODIC CONTOUR'};
a(3)={'EXAMPLE 3: KEY-FINDING'};
a(4)={'EXAMPLE 4: METER-FINDING'};
a(5)={'EXAMPLE 5. MELODIC SEGMENTATION'};
a(6)={'EXAMPLE 6: ANALYZING MIDI COLLECTIONS'};
a(7)={'EXAMPLE 7: CREATING SEQUENCES'};
a(8)={'EXAMPLE 8: MELODIC SIMILARITY'};
a(9)={' '};
a(10)={'(Press ''0'' to quit MIDI Toolbox demos)'};
a(11)={' '};

demo_counter=1;
demonro=demo_counter;

while (demonro ~= 0)
	clc
	disp('=======================================================')
	disp('    MIDI TOOLBOX DEMOS')
	disp('=======================================================')
	pause(.1)

	for i =1:11
		disp(a{i})
	end

	if demo_counter==9
		demonro=1; demo_counter=1;
	end

	t=['Enter example number (or hit ''ENTER'' to go to the EXAMPLE ',num2str(demo_counter),'): '];
	demonro=input(t);
		if isempty(demonro)
			demonro=demo_counter;
		end
			if isfinite(demonro)==1
				if demonro==0
					disp('The demo is over.');
					close all
					cd(p1);
					break

				elseif demonro >= 1 && demonro <= 8
					clc; clf reset;
					cmd1=['echo mdemo',num2str(demonro),' on'];
					eval(cmd1);
					eval(['mdemo',num2str(demonro),';']);
					demo_counter=demonro+1;
				else
					disp('Please enter a number between 0-8.')
				end
			end
end
