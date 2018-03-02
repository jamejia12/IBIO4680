function F=makeRFSfilters
% Returns the RFS filter bank of size 49x49x38 in F. The MR8, MR4 and
% MRS4 sets are all derived from this filter bank. To convolve an
% image I with the filter bank you can either use the matlab function
% conv2, i.e. responses(:,:,i)=conv2(I,F(:,:,i),'valid'), or use the
% Fourier transform.

  SUP=21;                 % Support of the largest filter (must be odd)
  SCALEX=[1,2,4];         % Sigma_{x} for the oriented filters
  NORIENT=6;              % Number of orientations

  NROTINV=2;
  NBAR=length(SCALEX)*NORIENT;
  NEDGE=length(SCALEX)*NORIENT;
  NF=NBAR+NEDGE+NROTINV;
  F=zeros(SUP,SUP,NF);
  hsup=(SUP-1)/2;
  [x,y]=meshgrid([-hsup:hsup],[hsup:-1:-hsup]);
  orgpts=[x(:) y(:)]';

  count=1;
  for scale=1:length(SCALEX),
    for orient=0:NORIENT-1,
      angle=pi*orient/NORIENT;  % Not 2pi as filters have symmetry
      c=cos(angle);s=sin(angle);
      rotpts=[c -s;s c]*orgpts;
      F(:,:,count)=makefilter(SCALEX(scale),0,1,rotpts,SUP);
      F(:,:,count+NEDGE)=makefilter(SCALEX(scale),0,2,rotpts,SUP);
      count=count+1;
    end;
  end;  
  F(:,:,NBAR+NEDGE+1)=normalise(fspecial('gaussian',SUP,10));
  F(:,:,NBAR+NEDGE+2)=normalise(fspecial('log',SUP,10));
return