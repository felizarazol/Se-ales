function [senal_salida,senal_grabada] = grabacion(duracion)
%Parametros de salida; senal_salida->objeto
                       %senal_grabada -> señal de de audio
%Parametros de entrada; duracion-> tiempo para grabar en segundos
 duracion=5
fs=44100; %f. muestreo
senal_salida=audiorecorder(fs,16,1);%Creacion del objeto de grabacion
msgbox('Empezando Grabacion',' Grabadora '); %Mensaje de informacion
recordblocking(senal_salida,duracion);%Grabacion del sonido
msgbox('Terminando Grabacion',' Grabadora ');%Mensaje de informacion
%Paso los valores del objeto a una señal
senal_grabada=getaudiodata(senal_salida, 'single');
%Grabamos y guardamos la señal
wavwrite(senal_grabada,fs,uiputfile({'*.wav'},'Guardar como'));
end