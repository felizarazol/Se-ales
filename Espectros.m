function llave = espectro()
    filename = uigetfile({'*.wav';'*.mp3'},'Seleccione el  archivo de audio');
    x=wavread(filename);
    % archivo de audio para su nombre.
    plot(x) % gráfica en el dominio del tiempo.
    x(1: 10)
    pause
    Y=fft(x); % transformada rápida de Fourier.
    A=Y.*conj(Y); % potencia de la señal.
    floor(sum(A)/norm(A))
    length(A)
    A(1:10)
    f=(100:3000); %espectro de frecuencias
    plot(f,A(1:2901));
end

