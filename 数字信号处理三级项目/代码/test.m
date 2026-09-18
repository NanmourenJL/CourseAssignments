a=25440.96462;
sys=tf(1,1);
for i=0:10
    den=[1,2*cos((2*i+1)/44*pi)*a,a*a];
    sys=sys*tf(a*a,den);
end
c2d(sys,0.00005,'z')

