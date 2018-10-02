function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 30-Sep-2018 23:53:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in browse_button.
function browse_button_Callback(hObject, eventdata, handles)
% hObject    handle to browse_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try 
    [Filename, Pathname]=uigetfile({'*.png';'*.jpg';}, 'File Selector');
    name = strcat(Pathname,Filename);
    img=imread(name);
    guidata(hObject,handles);
    axes(handles.axes1);
    imshow(img);
catch
    f = errordlg('File type doesnt match','File Eror');
end
   

function filename_text_Callback(hObject, eventdata, handles)
% hObject    handle to filename_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename_text as text
%        str2double(get(hObject,'String')) returns contents of filename_text as a double


% --- Executes during object creation, after setting all properties.
function filename_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in zoomin_button.
function zoomin_button_Callback(hObject, eventdata, handles)
% hObject    handle to zoomin_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes1);
if isempty(image)
    errordlg( 'Please upload an image' )
    return
else
    row = 2*size(image,1);
    column = 2*size(image,2);
    newImage = zeros(row, column, 3);
    m = 1; n = 1;
    for i = 1:size(image,1)
        for j = 1:size(image,2)
            newImage(m,n,:) = image(i,j,:);
            newImage(m,n+1,:) = image(i,j,:);
            newImage(m+1,n,:) = image(i,j,:);
            newImage(m+1,n+1,:) = image(i,j,:);
            n = n+2;
        end
        m = m+2;
        n = 1;    
    end
    newImage = uint8(newImage);
    guidata(hObject,handles);
    figure, imshow(newImage);
end


% --- Executes on button press in zoomout_button.
function zoomout_button_Callback(hObject, eventdata, handles)
% hObject    handle to zoomout_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = getimage(handles.axes1);
if isempty(image)
    errordlg( 'Please upload an image' )
    return
else
    newImage = zeros(round(size(image,1)/2), round(size(image,2)/2), 3);
    m = 1; n = 1;
    for i = 1:size(newImage,1)
        for j = 1:size(newImage,2)
            newImage(i,j,:) = image(m,n,:);
            n = round(n+2);
        end
        m = round(m+2);
        n = 1;
    end
    newImage = uint8(newImage);
    guidata(hObject,handles);
    figure, imshow(newImage);
end

% --- Executes on button press in grayscale_button.
function grayscale_button_Callback(hObject, eventdata, handles)
% hObject    handle to grayscale_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = getimage(handles.axes1);
if isempty(image)
    errordlg( 'Please upload an image' )
    return
else
    R = img(:,:,1);
    G = img(:,:,2);
    B = img(:,:,3);
    gray = 0.4*R + 0.3*G + 0.3*B;
    guidata(hObject,handles);
    axes(handles.axes2);
    imshow(gray);
end


% --- Executes on button press in textplus.
function textplus_Callback(hObject, eventdata, handles)
% hObject    handle to textplus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = getimage(handles.axes1);
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

newImg = img;
val = str2num(get(handles.textplus,'String'));
newImg(:,:,1) = R+val;
newImg(:,:,2) = G+val;
newImg(:,:,3) = B+val;

guidata(hObject,handles);
axes(handles.axes2);
imshow(newImg);

% --- Executes during object creation, after setting all properties.
function textplus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textplus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function textmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function textmulti_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textmulti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textdiv_Callback(hObject, eventdata, handles)
% hObject    handle to textdiv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textdiv as text
%        str2double(get(hObject,'String')) returns contents of textdiv as a double


% --- Executes during object creation, after setting all properties.
function textdiv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textdiv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in brightminus.
function brightminus_Callback(hObject, eventdata, handles)
% hObject    handle to brightminus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = getimage(handles.axes1);
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

newImg = img;
val = str2num(get(handles.textmin,'String'));
newImg(:,:,1) = R-val;
newImg(:,:,2) = G-val;
newImg(:,:,3) = B-val;

guidata(hObject,handles);
axes(handles.axes2);
imshow(newImg);

% --- Executes on button press in brightmulti.
function brightmulti_Callback(hObject, eventdata, handles)
% hObject    handle to brightmulti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = getimage(handles.axes1);
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

newImg = img;
val = str2num(get(handles.textmulti,'String'));
newImg(:,:,1) = R*val;
newImg(:,:,2) = G*val;
newImg(:,:,3) = B*val;

guidata(hObject,handles);
axes(handles.axes2);
imshow(newImg);

% --- Executes on button press in brightdiv.
function brightdiv_Callback(hObject, eventdata, handles)
% hObject    handle to brightdiv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = getimage(handles.axes1);
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

newImg = img;
val = str2num(get(handles.textdiv,'String'));
newImg(:,:,1) = R/val;
newImg(:,:,2) = G/val;
newImg(:,:,3) = B/val;

guidata(hObject,handles);
axes(handles.axes2);
imshow(newImg);


% --- Executes on button press in leftbutton.
function leftbutton_Callback(hObject, eventdata, handles)
% hObject    handle to leftbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img = getimage(handles.axes1);
[tinggi, lebar] = size(img);
sx = 145;
sy = -135;

F2 = double(img);
G = zeros(size(F2));
for y=1 :tinggi
    for x=1 :lebar
        xlama = x;
        ylama = y + sy;
        
        if (xlama >= 1) && (xlama<=lebar) && (ylama>=1) && (ylama<=tinggi)
            G(y,x) = F2(ylama,xlama);
        else
            G(y,x) = 0;
        end
    end
end

G = uint8(G);
axes(handles.axes2);
imshow(G);