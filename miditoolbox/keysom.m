function z=keysom(nmat,cbar,cmap,tsize)
% Projection of pitch class distribution on a self-organizing map
% function keysom(nmat,<cbar>,<cmap>,<tsize>)
%
% Creates a pseudocolor map of the pitch class distribution
% of NMAT projected onto a self-organizing map trained with the
% Krumhansl-Kessler profiles.
%
% Colors correspond to Pearson correlation values.
%
% Input argument:
%	NMAT = notematrix
%	CBAR (optional) = colorbar switch (1 = legend (default), 0 = no legend)
%	CMAP (optional) = colormap (string, 'jet' (default), 'gray', etc.)
%	TSIZE (optional) = textsize points (default = 16)
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


if nargin<2, cbar=1; end
if nargin<3, cmap='jet'; end
if nargin<4, tsize=16; end


z=zeros(24,36);
load keysomdata; 
if ~isempty(nmat)
	pcd=pcdist1(nmat);
	pcd=pcd-mean(pcd);
	pcd=pcd/(sqrt(pcd*pcd')+1e-6);
	for k=1:36
		for l=1:24
			z(l,k) = pcd*somw(:,k,l);
		end
	end
end
if strcmp(cmap,'gray')
    contourf(z+1e-6*rand(24,36),-1:.2:1), caxis([-1 1]), axis off, colormap gray
else
    pcolor(z), shading interp , axis([1,36,1,24]), view(2) , caxis([-1 1]),axis off;
end
hold on
for m=1:24 
	text(0.99*keyx(m)-1, 0.98*keyy(m)+1, keyN(m,:), 'FontSize',tsize,'FontName','Arial'); 
end
hold off
set(gca,'PlotBoxAspectRatio',[1.5 1 1])

colormap(cmap)
if cbar, colorbar; end
