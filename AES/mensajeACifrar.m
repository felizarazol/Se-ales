function varargout = mensajeACifrar(varargin)

% MENSAJEACIFRAR MATLAB code for mensajeACifrar.fig
%      MENSAJEACIFRAR, by itself, creates a new MENSAJEACIFRAR or raises the existing
%      singleton*.
%
%      H = MENSAJEACIFRAR returns the handle to a new MENSAJEACIFRAR or the handle to
%      the existing singleton*.
%
%      MENSAJEACIFRAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MENSAJEACIFRAR.M with the given input arguments.
%
%      MENSAJEACIFRAR('Property','Value',...) creates a new MENSAJEACIFRAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mensajeACifrar_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mensajeACifrar_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mensajeACifrar

% Last Modified by GUIDE v2.5 08-Jun-2015 22:20:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mensajeACifrar_OpeningFcn, ...
                   'gui_OutputFcn',  @mensajeACifrar_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before mensajeACifrar is made visible.
function mensajeACifrar_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mensajeACifrar (see VARARGIN)

% Choose default command line output for mensajeACifrar
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mensajeACifrar wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mensajeACifrar_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in cifrar.
function cifrar_Callback(hObject, eventdata, handles)
% hObject    handle to cifrar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    N = double(get(handles.mensaje,'String'));
    if length(N) < 16
        
        if length(N) < 16
            for i=length(N) + 1: 16
                N(i) = 0;
            end
        end
        [s_box, inv_s_box, w, poly_mat, inv_poly_mat] = aes_init;
        cyphertext = cipher(N', w, s_box, poly_mat, 1);
        cyphertext;
        salida1 = [char(cyphertext)];

        re_plaintext = inv_cipher (cyphertext, w, inv_s_box, inv_poly_mat, 1);
        re_plaintext;
        salida2 = [char(re_plaintext)];

        set(handles.encriptado, 'String', salida1);
        set(handles.desencriptado, 'String', salida2);
    else
        msgbox('El mensaje debe tener 16 carácteres o menos','Error');
    end



function mensaje_Callback(hObject, eventdata, handles)
% hObject    handle to mensaje (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%     Val=get(hObject, 'String');
%     New=double(Val)
%     handles.mensaje=New
%     guidata(hObject, handles);

% Hints: get(hObject,'String') returns contents of mensaje as text
%        str2double(get(hObject,'String')) returns contents of mensaje as a double


% --- Executes during object creation, after setting all properties.
function mensaje_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mensaje (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
