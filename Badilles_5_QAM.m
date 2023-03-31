clear;
clc;

b = input('Enter the Bit stream \n '); 
n = length(b);
z = 3;
t = 0:.01:n;
x = 1:1:(n+2)*100;

if(rem(n,z)~=0) %makes sure that the number of bits in the input is divisible by three
    error('the number of input bits must be divisible by 3');
end

grp = reshape(b, [3,n/3]); %groups the input array into three bits

tgrp = grp'; 
q = tgrp(:,1); %gets the first bit of the group
i = tgrp(:,2); %gets the second bit of the group
c = tgrp(:,3); %gets the third bit of the group

qq = repelem(q',3); %repeats q bit thrice
ii = repelem(i',3); %repeats i bit thrice
cc = repelem(c',3); %repeats c bit thrice


for i = 1:n %input channel 
    if (b(i)==0)
       b_p(i)= -1;   
   else
        b_p(i)= 1;   
    end
   
   for j = i:.1:i+1
       bw(x(i*100:(i+1)*100))= b_p(i);    
   end
end

for i = 1:length(qq) %q channel
   if (qq(i)==0)
       qq_p(i)= -1;    
   else
       qq_p(i)= 1;    
   end
   
   for j = i:.1:i+1
       qqw(x(i*100:(i+1)*100))= qq_p(i);    
   end
end

for i = 1:length(ii) %i channel
   if (ii(i)==0)
       ii_p(i)= -1;   
   else
        ii_p(i)= 1;    
   end
   
   for j = i:.1:i+1
       iiw(x(i*100:(i+1)*100))= ii_p(i);    
   end
end

for i = 1:length(cc) %c channel
   if (cc(i)==0)
       cc_p(i)= 0.541;    
   else
        cc_p(i)= 1.307;    
   end
   
   for j = i:.1:i+1
       ccw(x(i*100:(i+1)*100))= cc_p(i);    
   end
end


bw = bw(100:end);   
qqw = qqw(100:end); 
iiw = iiw(100:end);
ccw = ccw(100:end); 
sint= sin(2*pi*t); 
cost= cos(2*pi*t); 
qsum = qqw.*ccw.*cost; 
isum = iiw.*ccw.*sint;  
qam = qsum + isum;  

subplot(5,1,1) 
plot(t,bw);
grid on; axis([0 n -2 +2])

subplot(5,1,2) 
plot(t,qqw);
grid on; axis([0 n -2 +2])

subplot(5,1,3) 
plot(t,iiw);
grid on; axis([0 n -2 +2])

subplot(5,1,4) 
plot(t,ccw);
grid on; axis([0 n 0.5 1.5])

subplot(5,1,5) 
plot(t,qam);
grid on; axis([0 n -2 +2])