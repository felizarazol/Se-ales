%promedio de base de datos
clear all;
clc;

fs=22050;
[rec1]=wavread('F1b.wav');
[rec2]=wavread('F2b.wav');
[rec3]=wavread('F3b.wav');
[rec4]=wavread('F4b.wav');
[rec5]=wavread('F5b.wav');
%crear vector final de grabacion
prom=rec1;
tam=length(rec5)

for i = 1:1:tam
    prom(i)=((rec1(i)+rec2(i)+rec3(i)+rec4(i)+rec5(i))/5);
end;

lon = length(prom); %long del vector promedio
d = max(abs(prom)); 
prom = prom/d;  %normalizar señal
wavwrite(prom,fs,16,'FProm.wav')
plot(prom)  
%sound(prom,Fs)

[k0,fs,bits]=wavread('FProm.wav');

 duracion=5;

senal_salida=audiorecorder(fs,16,1);%Creacion del objeto de grabacion
msgbox('Empezando Grabacion',' Grabadora '); %Mensaje de informacion
recordblocking(senal_salida,duracion);%Grabacion del sonido
msgbox('Terminando Grabacion',' Grabadora ');%Mensaje de informacion
%Paso los valores del objeto a una señal
senal_grabada=getaudiodata(senal_salida, 'single');
%Grabamos y guardamos la señal
wavwrite(senal_grabada,fs,16,'prueba.wav')

lon=length(senal_grabada);
d = max(abs(senal_grabada));%valor mas grande
senal_grabada=senal_grabada/d;%normalizar señal
prom = sum(senal_grabada.*senal_grabada)/lon;%promedio señal completa
umbral = 0.02;  %2% energia promedio
y=[0];

for i = 1:400:lon-400   %ventaneo cada 10ms
    seg=senal_grabada(i:i+399); %segmentos
    e=sum(seg.*seg)/400; %promedio de cada segmento
    % si el promedio energetico es mayor que la señal completa por el valor umbral 
    if(e>umbral*prom)
        % almacena en y sino es eliminado como espacio en blanco
        y=[y;seg(1:end)]; 
     end; 
end; 

%guarda .wav normalizada y sin ruido
wavwrite(y,fs,16,'limpia.wav')

[kx,fs,bits]=wavread('prueba.wav');

%coeficientes LPC
num=(fs/1024)+3;
%coeficientes del filtro LPC para grabacion1
W0=lpc(k0,num);
Wx=lpc(kx,num);
%vector con distancia entre grabacion y base de datos
d0=0;
for z=1:25
    %distancia cuadratica media
    d0(z)=sqrt((W0(z)-Wx(z))*(W0(z)-Wx(z)));
    if d0(z)<=0.15
        %coloca 1 si es cercano a la grabacion
        d0(z)=1;
        %o 0 si es lejano a la grabacion
    else d0(z)=0;
    end
end

%contador de numero de coeficientes parecidos
cont0=0;

for i = 1:25
    %suma valores de la cadena
    cont0=d0(i)+cont0;
end
cont0

if(cont0>=19)
   op = length(k0);
   %prediccion señal por filtro
   predic=filter([0-W0(2:end)],1,k0);
   error = k0-predic;
   %vector de autocorrelacion
   Rsw = xcorr(k0);
    R=Rsw(op:op+num);    %obtencion R(0)
    G=sqrt(sum(W0.*R')); %obtencion G
   %obtencion envolvente H(z)
   envolvente = abs(G./fft(W0,op));
   %transformada de fourier de la señal original
   SW=abs(fft(k0,op));
   semilogy(SW(1:(op/2)),'g');
   hold on;
   semilogy(envolvente(1:(op/2)),'b');
   hold off;
   title('Usuario orlando','Fontname','Arial','Fontangle','Italic','Fontweight','Bold','Fontsize',20,'color',[1 1 1])
   xlabel('Frecuencia','Fontname','Arial','Fontangle','Italic','Fontweight','Bold','Fontsize',15,'color',[1 1 1])
   ylabel('Nivel de voz','Fontname','Arial','Fontangle','Italic','Fontweight','Bold','Fontsize',15,'color',[1 1 1])
   msgbox('Identificado: orlando');
    ID=1;
   save ID.mat;
else 
        msgbox('no identificado');    
end


    