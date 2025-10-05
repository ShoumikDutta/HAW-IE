%Tobias Hör
%fig8.m erstellt das Figure8 Fenster um den Restfehler darzustellen

figure(8)
set(figure(8),'Position',[scrsz(3)*2/3 scrsz(2)+9 scrsz(3)/3 scrsz(4)/4]);
[xb,yb] = stairs(restfehler);
[xb,yc] = stairs(erwuenscht);
[xb,yd] = stairs(ploterror);
%stairs(h,restfehler);
plot(xb,yb,xb,yc,xb,yd)
axis([0 SAMPLES -GENAUIGKEIT GENAUIGKEIT]);
grid on;
legend('Restfehler','s[k]','e[k]');
xlabel('Sample');
ylabel('Restfehler');
if TIT==1
 	d=get(h39,'String');
    title(d);
    TIT=0;
else
title('Restfehler = e[k] - s[k]');
end
