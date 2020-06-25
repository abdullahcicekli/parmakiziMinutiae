clc,clear all,close all
resim=imread('parmakizi (5).png');%% Parmakizi Tan�mlama 
resim = 110 < resim; %manuel olarak yap�lan bu i�lem dilenirse im2bw fonksiyonu ile otomatik yap�labilir.
%�NCELTME (skel ile inceltme yap�ld�. istenirse thin ile yap�labilir)
inceltme=~bwmorph(resim,'skel',Inf);
figure;
imshow(inceltme);
title('Parmak �zi');
figure;
imshow(resim);
s=size(inceltme); % size[m,n] yerine direk size kullan�ld� ve boyutlar s(1),s(2) olarak al�nd�
boyut=3; 
n=(boyut-1)/2;
r=s(1)+2*n;
c=s(2)+2*n;
double temp(r,c);   
gecici=zeros(r,c);
catallanma=zeros(r,c);
cikinti=zeros(r,c);
gecici((n+1):(end-n),(n+1):(end-n))=inceltme(:,:);

cikti=zeros(r,c,3);

cikti(:,:,1) = gecici .* 255;
cikti(:,:,2) = gecici .* 255;
cikti(:,:,3) = gecici .* 255;
for x=(n+1+10):(s(1)+n-10)
    for y=(n+1+10):(s(2)+n-10)
        e=1;
        for k=x-n:x+n
            f=1;
            for l=y-n:y+n
                mat(e,f)=gecici(k,l);
                f=f+1;
            end
            e=e+1;
        end;
         if(mat(2,2)==0)
            cikinti(x,y)=sum(sum(~mat));
            catallanma(x,y)=sum(sum(~mat));
         end
    end;
end;


[cikinti_x cikinti_y]=find(cikinti==2);
len=length(cikinti_x);


for i=1:len
    cikti((cikinti_x(i)-3):(cikinti_x(i)+3),(cikinti_y(i)-3),2:3)=0;
    cikti((cikinti_x(i)-3):(cikinti_x(i)+3),(cikinti_y(i)+3),2:3)=0;
    cikti((cikinti_x(i)-3),(cikinti_y(i)-3):(cikinti_y(i)+3),2:3)=0;
    cikti((cikinti_x(i)+3),(cikinti_y(i)-3):(cikinti_y(i)+3),2:3)=0;
    
    cikti((cikinti_x(i)-3):(cikinti_x(i)+3),(cikinti_y(i)-3),1)=255;
    cikti((cikinti_x(i)-3):(cikinti_x(i)+3),(cikinti_y(i)+3),1)=255;
    cikti((cikinti_x(i)-3),(cikinti_y(i)-3):(cikinti_y(i)+3),1)=255;
    cikti((cikinti_x(i)+3),(cikinti_y(i)-3):(cikinti_y(i)+3),1)=255;
end

[catal_x catal_y]=find(catallanma==4);
len=length(catal_x);

for i=1:len
    cikti((catal_x(i)-3):(catal_x(i)+3),(catal_y(i)-3),1:2)=0;
    cikti((catal_x(i)-3):(catal_x(i)+3),(catal_y(i)+3),1:2)=0;
    cikti((catal_x(i)-3),(catal_y(i)-3):(catal_y(i)+3),1:2)=0;
    cikti((catal_x(i)+3),(catal_y(i)-3):(catal_y(i)+3),1:2)=0;
    
    cikti((catal_x(i)-3):(catal_x(i)+3),(catal_y(i)-3),3)=255;
    cikti((catal_x(i)-3):(catal_x(i)+3),(catal_y(i)+3),3)=255;
    cikti((catal_x(i)-3),(catal_y(i)-3):(catal_y(i)+3),3)=255;
    cikti((catal_x(i)+3),(catal_y(i)-3):(catal_y(i)+3),3)=255;
end
figure;imshow(cikti);