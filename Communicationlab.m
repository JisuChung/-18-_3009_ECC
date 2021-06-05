%% Question 1


h=commsrc.pn('Shift',1)
set(h,'NumBitsOut',100)
PN=generate(h)*2-1

stairs(PN);



%% Question 2

r= zeros(5,5);

for i = 1:5
    for j = 1:5
        d=PN_seq(i,1:end).*PN_seq(j,1:end);
        r(i,j)=sum(d,'all');            
    end
end



%% Question 4
%그래서 우리가 썼던 parameter는?


clear
close all

load('encoded_data.mat');
DATA=mod_data(1,1:100);

PN_max=10;
whatsk=zeros(10,1);
PN=zeros(10,100);
sum=0;
k=0;

for i=1:PN_max %10개의 PN sequence 만들기
    
    h = commsrc.pn('Shift',i);
    set(h,'NumBitsOut',100);
    PN_total=generate(h)*2-1;
    PN_total_trans=transpose(PN_total);
    PN(i,:)=PN_total_trans;
    for j=1:100
        
        sum = sum + DATA(1,j)*PN(i,j);

    end
    whatsk(i,1) = sum; % 절댓값이 100인 shift 횟수가 우리의 PN코드의 shift 횟수
    
    
    if abs(sum) == 100
        k=i;
    end
    
    sum=0;
end


%% Question 5
%threshold 적용하기



clear
close all

load('encoded_data.mat');
DATA=mod_data(1,1:1000000);

PN_max=10;
PN=zeros(1,100);
decodedDATA_temp=zeros(1,10000);
    
h = commsrc.pn('Shift',4);
set(h,'NumBitsOut',100);
PN_total=generate(h)*2-1;
PN(1,:)=transpose(PN_total);
PNsum=sum(PN);

for i=1:10000
        if sum(PN(1,:).*DATA(1,1+100*(i-1):1+100*(i-1)+99))>0 % threshold=0!!
            decodedDATA_temp(1,i)=1;
        else
            decodedDATA_temp(1,i)=-1;
        end
end
            
decodedDATA=transpose(reshape(decodedDATA_temp,100,100));

for i=1:100
    for j=1:100
        if decodedDATA(i,j)>=0 %세타=0으로 정하면 -1,1을 구분할수있다~
            decodedDATA(i,j)=0; %세타보다 크면 0으로 ////흑백반대면 1로
        else
            decodedDATA(i,j)=1; %세타보다 작으면 1으로 ////흑백반대면 0으로
        end
    end
end


I=mat2gray(decodedDATA);
figure;
imshow(I);





%% Question 7
%노이즈있을 때 결과값


for p=1:10

load('encoded_data.mat'); %variable name: mod_data
DATA = mod_data+normrnd(0, p, 1,length(mod_data)); % AWGN noise 

PN_max=10;
PN=zeros(1,100);
decodedDATA_temp=zeros(1,10000);
    
h = commsrc.pn('Shift',4);
set(h,'NumBitsOut',100);
PN_total=generate(h)*2-1;
PN(1,:)=transpose(PN_total);


for i=1:10000
        if sum(PN(1,:).*DATA(1,1+100*(i-1):1+100*(i-1)+99))> 0 % threshold=0!!
            decodedDATA_temp(1,i)=1;
        else
            decodedDATA_temp(1,i)=-1;
        end
end
            
decodedDATA=transpose(reshape(decodedDATA_temp,100,100));

for i=1:100
    for j=1:100
        if decodedDATA(i,j)>=0 %세타=0으로 정하면 -1,1을 구분할수있다~
            decodedDATA(i,j)=0; %세타보다 크면 0으로 ////흑백반대면 1로
        else
            decodedDATA(i,j)=1; %세타보다 작으면 1으로 ////흑백반대면 0으로
        end
    end
end


I=mat2gray(decodedDATA);
figure;
imshow(I);
end


%% Question 8
%노이즈정도에 따른 BER값 그래프


clear
close all

load('encoded_data.mat');mod_data
DATA=mod_data(1,1:1000000);

DATA_noise=zeros(1,1000000); %%%%
decodedDATA_noise=zeros(1,10000); %%%
NUMofERROR=zeros(1,10);
BER=zeros(1,10);


PN_max=10;
PN=zeros(1,100);
decodedDATA=zeros(1,10000);
    
h = commsrc.pn('Shift',4);
set(h,'NumBitsOut',100);
PN_total=generate(h)*2-1;
PN(1,:)=transpose(PN_total);
PNsum=sum(PN);

for i=1:10000
        if sum(PN(1,:).*DATA(1,1+100*(i-1):1+100*(i-1)+99))>0 % threshold=0!!
            decodedDATA(1,i)=0;
        else
            decodedDATA(1,i)=1;
        end
end
            


for s=1:10
    DATA_noise(s,:)=mod_data(1,1:1000000)+normrnd(0, s, 1,length(mod_data));
    for i=1:10000
        if sum(PN(1,:).*DATA_noise(s,1+100*(i-1):1+100*(i-1)+99))>0 % threshold=0!!
            decodedDATA_noise(1,i)=0;
        else
            decodedDATA_noise(1,i)=1;
        end
    end
    
  
    NUMofERROR(s)=nnz(decodedDATA - decodedDATA_noise); 
    BER(s)=NUMofERROR(s)/10000;
        
end

x_temp=1:1:10;
x=x_temp.^(-1);
figure;
loglog(x,BER(x_temp));
ylabel('log(1/sigma)')
xlabel('BER')

    
    