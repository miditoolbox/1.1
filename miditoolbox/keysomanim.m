function m = keysomanim(nmat, stmem, step, ttype, opt)
% m = keysomanim(nmat, <stmem>, <step>, <ttype>, <opt>);
% Animation using the KEYSOM function
%
% Input arguments:
%   NMAT = notematrix
%   STMEM (optional) = length of short-term memory (default = 6 beats)
%           length indicates the time constant of exponentially
%           decaying memory
%   STEP (optional) =window step in beats (default = 0.5)
%   TIMETYPE (optional) = time type ('beat' (default) or 'sec')	
%   OPT (optional) = Options:   'MOVIE' creates a MATLAB movie
%                               'STRIP' creates a strip of the animation frames
%                               instead of the animation.
%                               'FRAMES' save each individual frame as a
%                               jpg file to current directory
%                               If no option is given, the function just
%                               displays the frames
% Output arguments:
%   M = MATLAB movie (if OPT has not been set to 'strip'
%
% Example:
%   m = keysomanim(nm, 3, 0.2, 'sec', 'movie'); % create a movie using a
%   3-sec window and a step of 0.2 seconds
%
% References:
%	Toiviainen, P. & Krumhansl, C. L. (2003). Measuring and modeling 
%	real-time responses to music: the dynamics of tonality induction. 
%	Perception, 32(6), 741-766.
%
%	Krumhansl, C. L., & Toiviainen, P. (2001) Tonal cognition. 
%	In R. J. Zatorre & I. Peretz (Eds.), The Biological Foundations of Music. 
%	Annals of the New York Academy of Sciences. 
%	New York, NY: New York Academy of Sciences, 77-91.
%
%	Change History :
% 	Date		Time	Prog	Note
% 	16.2.2003	23:55	PT	Created under MATLAB 5.3 (Macintosh)
%© Part of the MIDI Toolbox Software Package, Copyright © 2002, University of Jyväskylä, Finland
% See License.txt


if isempty(nmat), return; end

if nargin<5, opt = 'none'; end
if nargin<4, ttype = 'beat'; end
if nargin<3, step = 0.5; end
if nargin<2, stmem = 6; end

m=[];
ob = onset(nmat,ttype); du=dur(nmat,ttype); len = ob(end)+du(end);
N = length(0:step:len);
if strcmp(ttype, 'beat'), tttitle = 'Beat'; 
elseif strcmp(ttype, 'sec'), tttitle = 'Secs:';
else disp('Wrong timetype - ''beat'' and ''sec'' are accepted'); return; end
%%%% For 'STRIP' Option
	if strcmp(opt,'strip')
        strip_length = max(ob)/step; % STRIP
		%n=ceil(strip_length/4);
		n=ceil(sqrt(strip_length));
    elseif strcmp(opt,'movie')
        m = moviein(N);
        fr = 1;
        if strcmp(computer,'MAC')
            figure;
            set(gcf,'Renderer','painters') % fixes the bug in MATLAB for OS 10.3
        end
    elseif strcmp(opt,'frames')
        fr = 1;
        h = waitbar(0,'Please wait...');
	end
%%%% 
figure;
for t = 0:step:len
	nm = exptimewindow(nmat,t,stmem,ttype);
	if strcmp(opt,'strip') && t>0 % STRIP
		subplot(n,ceil((strip_length)/n),round(t/step))
		keysom(nm,0,'gray',8);
		title([tttitle,' ',num2str(t,'%.1f')],'FontSize', 10,'FontName','Arial')
    elseif strcmp(opt,'movie') % MOVIE
		keysom(nm,0,'jet',16);
        drawnow
        m(:,fr) = getframe; fr = fr+1;
    elseif strcmp(opt,'frames')
        waitbar(fr/N,h, ['Frame ' num2str(fr) '/' num2str(N)])
        keysom(nm,0,'jet',12);
        drawnow
        set(gca,'Position',[0 0 1 1]); set(gcf,'PaperPosition',[0 0 4.5 3])
        print('-djpeg100', ['frame' sprintf('%0.4d', fr)]); fr = fr+1;     
    elseif strcmp(opt,'none')
    	keysom(nm);
		title([tttitle,' ',num2str(t,'%.1f')],'FontSize', 16,'FontName','Times');
        drawnow
end	
	
end

if strcmp(opt,'strip')
	set(gcf,'PaperPositionMode','manual')
	set(gcf,'PaperUnits','points')
	set(gcf,'PaperPosition',[0 0 600 500])
elseif strcmp(opt,'frames')
    close(h)
end
