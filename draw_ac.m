txt=textread('MPU6050-20190113091403_160403.txt','%s');
txt=hex2dec(txt);
x=txt(1:3:length(txt)-2);
y=txt(2:3:length(txt)-1);
z=txt(3:3:length(txt));

tmp = dec2bin(x);
for i=1:length(tmp)*16
    if strcmp(tmp(i),'1')
        tmp(i)='0';
    else
        tmp(i)='1';
    end
end
for i=1:length(tmp)
   for j=0:7
       if strcmp(tmp(i,16-j),'0')
           tmp(i,16-j)='1';
           break
       else
           tmp(i,16-j)='0';
       end
   end
end
x=bin2dec(tmp);

[T, sx]=allan(x,100,100);
[T, sy]=allan(y,100,100);
[T, sz]=allan(z,100,100);

%s
figure;
loglog(T,sx*125/16384,'-diamond','LineWidth',2,'markersize',10,'MarkerFaceColor','w');
hold on;
loglog(T,sy*125/16384,'-square','LineWidth',2,'markersize',10,'MarkerFaceColor','w');
hold on;
loglog(T,sz*125/16384,'-og','LineWidth',2,'markersize',10,'MarkerFaceColor','w');
hold on;

index=find(sx==min(sx));
text(1e3,sx(index)*125/16384,['(',num2str(T(index)),',',num2str(sx(index)*125/16384),')'],'FontSize',16,'color','blue');
plot([T(index),1e3],[sx(index)*125/16384,sx(index)*125/16384],'b');
hold on;
index=find(sy==min(sy));
text(1e3,sy(index)*125/16384+1e-3,['(',num2str(T(index)),',',num2str(sy(index)*125/16384),')'],'FontSize', 16,'color','red');
plot([T(index),1e3],[sy(index)*125/16384,sy(index)*125/16384+1e-3],'r');
hold on;
index=find(sz==min(sz));
text(1e3,sz(index)*125/16384,['(',num2str(T(index)),',',num2str(sz(index)*125/16384),')'],'FontSize', 16,'color','green');
plot([T(index),1e3],[sz(index)*125/16384,sz(index)*125/16384],'g');
hold on;

l=legend('X-Axis', 'Y-Axis', 'Z-Axis', 'Location', 'NorthEast'); 
set(l, 'FontSize', 18);
grid on;
title('3-Axis Gyro - Allan Deviation', 'FontSize', 20);
xlabel('Intergration Time[s]', 'FontSize', 18,'FontWeight','bold'); 
ylabel('Allan Deviation[deg/s]', 'FontSize', 18,'FontWeight','bold');
set(gca,'fontsize',18);
%h
figure;
loglog(T,sx*125/16384*3600,'-diamond','LineWidth',2,'markersize',10,'MarkerFaceColor','w');
hold on;
loglog(T,sy*125/16384*3600,'-square','LineWidth',2,'markersize',10,'MarkerFaceColor','w');
hold on;
loglog(T,sz*125/16384*3600,'-og','LineWidth',2,'markersize',10,'MarkerFaceColor','w');
hold on;

index=find(sx==min(sx));
text(1e3,sx(index)*125/16384*3600,['(',num2str(T(index)),',',num2str(sx(index)*125/16384*3600),')'],'FontSize', 16,'color','blue');
plot([T(index),1e3],[sx(index)*125/16384*3600,sx(index)*125/16384*3600],'b');
hold on;
index=find(sy==min(sy));
text(1e3,sy(index)*125/16384*3600+1e1,['(',num2str(T(index)),',',num2str(sy(index)*125/16384*3600),')'],'FontSize', 16,'color','red');
plot([T(index),1e3],[sy(index)*125/16384*3600,sy(index)*125/16384*3600+1e1],'r');
hold on;
index=find(sz==min(sz));
text(1e3,sz(index)*125/16384*3600,['(',num2str(T(index)),',',num2str(sz(index)*125/16384*3600),')'],'FontSize', 16,'color','green');
plot([T(index),1e3],[sz(index)*125/16384*3600,sz(index)*125/16384*3600],'g');
hold on;

l=legend('X-Axis', 'Y-Axis', 'Z-Axis', 'Location', 'NorthEast'); 
set(l, 'FontSize', 18);
grid on;
title('3-Axis Gyro - Allan Deviation', 'FontSize', 20);
xlabel('Intergration Time[s]', 'FontSize', 18,'FontWeight','bold'); 
ylabel('Allan Deviation[deg/h]', 'FontSize', 18,'FontWeight','bold');
set(gca,'fontsize',18);

