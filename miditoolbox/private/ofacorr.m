function ac = ofacorr(of);
% ac = ofacorr(of);
%
% Comment: Auxiliary function that resides in private directory

MAXLAG = 8;
NDIVS = 4;
actmp = xcorr(of);
ind1 = (length(actmp)+1)/2; ind2 = min(length(actmp),ind1+MAXLAG*NDIVS);
ac=zeros(1,MAXLAG*NDIVS+1);
ac(1:(ind2-ind1+1)) = actmp(ind1:ind2)';
if ac(1)>0 ac = ac/ac(1); end
ac = ac(3:2:end);