function varargout = program1(varargin)
% PROGRAM1 MATLAB code for program1.fig
%      PROGRAM1, by itself, creates a new PROGRAM1 or raises the existing
%      singleton*.
%
%      H = PROGRAM1 returns the handle to a new PROGRAM1 or the handle to
%      the existing singleton*.
%
%      PROGRAM1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROGRAM1.M with the given input arguments.
%
%      PROGRAM1('Property','Value',...) creates a new PROGRAM1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before program1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to program1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help program1

% Last Modified by GUIDE v2.5 30-Sep-2018 20:01:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @program1_OpeningFcn, ...
                   'gui_OutputFcn',  @program1_OutputFcn, ...
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

% --- Executes just before program1 is made visible.
function program1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to program1 (see VARARGIN)

% Choose default command line output for program1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using program1.
if strcmp(get(hObject,'Visible'),'off')
    plot(0);
end

% UIWAIT makes program1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = program1_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla;

%Get user input
n1 = str2double( get(handles.edit1, 'string') );%refractive index of 1st layer
n2 = str2double( get(handles.edit2, 'string') );%refractive index of 2nd layer
n_d = str2double( get(handles.edit3, 'string') );%refractive index of deffected layer
N = str2double( get(handles.edit4, 'string') );
c_l = str2double( get(handles.edit5, 'string') )*10^(-9); %chosen_length
value = get(handles.checkbox1, 'Value');

% Calculate data
delt = str2double( get(handles.edit6, 'string') )*10^(-9); %step in m
wl_range = delt:delt:2*10^(-6); %the values of the wavelengths
len = length(wl_range); %number of counts
[k,T] = mac(len,wl_range,c_l,n1,n2,N,value,n_d);
popup_sel_index = get(handles.popupmenu1, 'Value');
switch popup_sel_index
    case 1
        plot(wl_range*10^(9),real(k),'b-','LineWidth',1);
        axis([100 2000 -inf inf])
        xticks(0:100:2000)
        title('Зависимость блоховского волнового числа от длины волны',...
            'FontName', 'Times New Roman','fontsize',14)
        xlabel('Длина волны, нм','FontName', 'Times New Roman','fontsize',14)
        ylabel('real(k)','FontName', 'Times New Roman','fontsize',14)
        grid on
    case 2
        plot(wl_range*10^(9),abs(imag(k)),'r-','LineWidth',1);
        axis([100 2000 -inf inf])
        xticks(0:100:2000)
        title('Зависимость блоховского волнового числа от длины волны',...
            'FontName', 'Times New Roman','fontsize',14)
        xlabel('Длина волны, нм','FontName', 'Times New Roman','fontsize',14)
        ylabel('imag(k)','FontName', 'Times New Roman','fontsize',14)
        grid on
    case 3
        plot(wl_range.*10^(9),T,'b-','LineWidth',1);
        axis([100 2000 -inf inf])
        xticks(0:100:2000)
        xlabel('Длина волны, нм','FontName', 'Times New Roman','fontsize',14)
        ylabel('Коэффициент пропускания','FontName', 'Times New Roman','fontsize',14)
        title(['Зависимость коэффициента пропускания от длины волны, при количестве слоёв N=', num2str(N)],...
            'FontName', 'Times New Roman','fontsize',14)
        grid on
end


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'real(k)', 'abs(imag(k))', 'T'});

% --------------------------------------------------------------------
function save_as_menu_Callback(hObject, eventdata, handles)
% hObject    handle to save_as_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
H = get(handles.axes1,'Children');
x = get(H, 'XData');
y = get(H, 'YData');
n1 = str2double( get(handles.edit1, 'string') );%refractive index of 1st layer
n2 = str2double( get(handles.edit2, 'string') );%refractive index of 2nd layer
n_d = str2double( get(handles.edit3, 'string') );%refractive index of deffected layer
N = str2double( get(handles.edit4, 'string') );
c_l = str2double( get(handles.edit5, 'string') )*10^(-9); %chosen_length
value = get(handles.checkbox1, 'Value');
switch get(handles.popupmenu1,'Value')   
  case 1
    of_that = 'bloch_real';
  case 2
    of_that = 'bloch_imag';
  case 3
    of_that = 'Trans';
  otherwise
end
[filename, pathname] = uiputfile({'*.txt'},'Save as',of_that);
if filename ~= 0
    fid=fopen([ pathname,filename] ,'w');
    fprintf(fid, 'n1 = %i \n', n1);
    fprintf(fid, 'n2 = %i \n', n2);
    if value
        fprintf(fid, 'n of defect = %f \n', n_d);
    else
        fprintf(fid, 'no defect \n');
    end
    fprintf(fid, 'N = %i \n', N);
    fprintf(fid, 'c_l = %i \n \n', c_l);
    fprintf(fid, 'wavelength value \n');
    fprintf(fid, '%i %i \n', [x' y']');
    fclose(fid);
end

% --------------------------------------------------------------------
function author_menu_Callback(hObject, eventdata, handles)
% hObject    handle to author_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure('Menubar','none', 'Position',[100 200 340 60],...
    'Name','Author','NumberTitle','off') ;
uicontrol('Style','text','Position',[30 20 340 30],...
    'String','Azat Ismagilov , ITMO University','FontSize', 14, 'ForegroundColor', 'b');


% --------------------------------------------------------------------
function info_menu_Callback(hObject, eventdata, handles)
% hObject    handle to info_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function file_menu_Callback(hObject, eventdata, handles)
% hObject    handle to file_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
% --- Executes during object creation, after setting all properties.

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

