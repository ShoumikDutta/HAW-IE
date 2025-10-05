%Tobias Hör
%fig6.m erstellt das Figure6 Fenster um die Koeffizienten darzustellen
figure(6)

set(figure(6),'Position',[scrsz(3)/3 scrsz(4)/3 scrsz(3)/3 scrsz(4)/4]);

if DREID==1
   	hpop = uicontrol('Style', 'popup',...
       	'String', 'jet|hsv|hot|cool|gray',...
       	'Position', [20 570 100 50],...
       	'Callback',...
       	['val = get(hpop,''Value'');',...
		 	'if val == 1;',...
    		'	colormap(jet);',...
			'elseif val == 2;',...
    		'	colormap(hsv);',...
			'elseif val == 3;',...
    		'	colormap(hot);',...
			'elseif val == 4;',...
   		'	colormap(cool);',...
			'elseif val == 5;',...
    		'	colormap(gray);',...
			'end;']);

		h = surf(plotcoef);
		xlabel('Koeffizienten')
		ylabel('SAMPLES')
      zlabel('Integer Wert')
      if TIT==1
 			d=get(h37,'String');
         title(d);
         TIT=0;
		else
			title('Stabilität der Koeffizienten')
		end

else
		plot(plotcoef);
		xlabel('SAMPLES')
      ylabel('Integer Wert')
      if TIT==1
 			d=get(h37,'String');
   		title(d);
		else
			title('Stabilität der Koeffizienten')
		end
end
      

      
grid on;
