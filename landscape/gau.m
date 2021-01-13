function f=gau(x,mu,sigma)
f=1/(2*pi*sigma)^0.5.*exp(-0.5.*(x-mu).^2./sigma);
end