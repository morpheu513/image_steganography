I=imread("10.jpg");
I2=im2double(I);
%%Message code
M='Everything-is-temporary-nothing-ever-lasts';
lm=strlength(M);
MNum=double(M);
MNumFinal=dec2bin(MNum,8);
Emp=strings;

for a=1:lm
    for b=0:7
        Emp(end+1)=MNumFinal(a+(lm*b));
    end
end

Emp(end+1)=2;
[height,width,dim]=size(I);

%%Encoding the message

isBreaking=false;

for i=1:floor(height/4)
    for j=1:floor(width/4)
        %applying svd
        [U,S,V]=svd(I2(4*i-3:4*i,4*j-3:4*j));
        Sbig(i,j,:)=[S(1,1),S(2,2),S(3,3),S(4,4)];
        %compare bit piece of message to # matrix(# mat=width/4(i-1)+j)
        %Emp(270(i-1)+j+1 is the bit that corresponds to the matrix number
        if Emp(floor(width/4)*(i-1)+j+1)=="1"
            %if bit=1 change 4th sigma of S, then reconstruct 4x4
            S(4,4)=0;
        elseif Emp(floor(width/4)*(i-1)+j+1)=="0"
            %if bit=0 do nothing, reconstruct 4x4(reverse SVD)
            %if S(4,4) is already a very small number, change matrix so
            %that bit isn't misinterpreted as a 1
            if S(4,4)<=1*10^(-5)
                S(4,4)=S(3,3)/5;
                if S(3,3)<=1*10^(-5)
                    S(3,3)=S(2,2)/5;
                    S(4,4)=S(3,3)/5;
                    if S(2,2)<=1*10^(-5)
                        S(2,2)=S(1,1)/5;
                        S(3,3)=S(2,2)/5;
                        S(4,4)=S(3,3)/5;
                    end
                end
            else
                S(4,4)=S(4,4);
            end
        elseif Emp(floor(width/4)*(i-1)+j+1)=="2"
            isBreaking=true;
            break
        end
        %reverse SVD
        VT=V.';
        A=U*S*VT;
        
        %place new 4X4 into new image
        I2(4*i-3:4*i,4*j-3:4*j)=A(1:4,1:4);
    end
    if isBreaking==true
        break;
    end
end



%%decoding the message
NewM=strings;
[Nheight,Nwidth,Ndim]=size(I2);
for i=1:floor(Nheight/4)
    for j=1:floor(Nwidth/4)
        [U,S,V]=svd(I2(4*i-3:4*i,4*j-3:4*j));
        Sbig(i,j,:)=[S(1,1),S(2,2),S(3,3),S(4,4)];
        %I2(4*i-3:4*i, 4*j-3:4*j)
        %j
        %S(4,4)
        if S(4,4)<=1*10^(-10)
            NewM(end+1)="1";
        elseif S(4,4)>=1*10^(-10)
            NewM(end+1)="0"
        end
    end
end
Emp
NewM

%%make new message legible
StegM="Decoded message: ";
for k=linspace(1,lm,lm)
    for i=2+8*(k-1)
        %take each set of 8 bits and combine
        b=strcat(NewM(i),NewM(i+1),NewM(i+2),NewM(i+3),NewM(i+4),NewM(i+5),NewM(i+6),NewM(i+7));
        %make 8 bit number into ascii
        a=bin2dec(b);
        %convert ascii to letter format
        l=char(a);
        %push letter into message
        StegM=strcat(StegM,l);
    end
end
StegM
imwrite(I2, "stego-10.jpg");
figure,imshow(I)
figure,imshow(I2)