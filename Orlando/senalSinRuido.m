%normalizacion y eliminacion de ruido
 duracion=5
fs=22050; %f. muestreo
senal_salida=audiorecorder(fs,16,1);%Creacion del objeto de grabacion
msgbox('Empezando Grabacion',' Grabadora '); %Mensaje de informacion
recordblocking(senal_salida,duracion);%Grabacion del sonido
msgbox('Terminando Grabacion',' Grabadora ');%Mensaje de informacion
%Paso los valores del objeto a una señal
senal_grabada=getaudiodata(senal_salida, 'single');
%Grabamos y guardamos la señal
wavwrite(senal_grabada,fs,16,'F1.wav')

lon=length(senal_grabada);
d = max(abs(senal_grabada));%valor mas grande
senal_grabada=senal_grabada/d;%normalizar señal
prom = sum(senal_grabada.*senal_grabada)/lon%promedio señal completa
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
wavwrite(y,fs,16,'F5b.wav')
plot(y)
sound(y,22050)
