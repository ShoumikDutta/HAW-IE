function [y,w,px]=dsp_lms(x,d,w,mue,sigma,alpha,px)
% LMS algorithm: kzr / version 11.02
%
% Inputs:
%    x      = input data row vector [x(1),x(2),...,x(N)].
%    d      = desired signal row vector, same length as x.
%    w      = row vector with L+1 adaptive FIR weights. 
%             H(z)=b(1)+b(2)*z^(-1)+...+b(L+1)*z^(-L).
%    mue    = convergence parameter; scalar.
%    sigma  = estimate of x^2 (updated); scalar.
%    alpha  = forgetting factor; scalar.
%    px     = past values of x row vector (may be "0").
% Outputs:  
%    y  = output row data vector with epsilon=d-y.
%    w  = updated adaptive weight row vector, length L+1.
%    px = updated px row vector; [x(N-1),...,x(N-L)].

N=length(x); L=length(w)-1;
if N~=length(d),
   error('LMS: lengths of x and d row vectors not equal.');
end
if (mue<=0)|(mue>=1)|(sigma<=0)|(alpha<0)|(alpha>=1),
   error('LMS: mue, sigma, or alpha out of range.');
end
y=zeros(1,N);
if(length(px)<L),
   px=[px,zeros(1,L-length(px))];
end
px=[0,px];
for k=1:N,
   px(1)=x(k);
   y(k)=w*px';
   if abs(y(k))>1e10,
      fprintf('\nLMS warning: |y| output > 1e10.\n');
      y(k+1:N)=zeros(1,N-k);
      return
   end
   e=d(k)-y(k);
   sigma=alpha*(px(1)^2)+(1-alpha)*sigma;
   tmp=2*mue/((L+1)*sigma);
   w=w+tmp*e*px;
   px(L+1:-1:2)=px(L:-1:1);
end
px=px(2:L+1);
return
