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

% Last Modified by GUIDE v2.5 24-Nov-2018 14:03:58

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
global img;
try 
    [Filename, Pathname]=uigetfile({'*.png';'*.jpg';}, 'File Selector');
    name = strcat(Pathname,Filename);
    img=imread(name);
    axes(handles.axes1);
    imshow(img);
catch
    f = errordlg('File type doesnt match/empty or you close the browser','File Eror');
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
global img;
if isempty(img)
    errordlg( 'Please upload an image' );
    return
else
    axes(handles.axes1);
    imshow(img);
end;
row = 2*size(img,1);
column = 2*size(img,2);
newImage = zeros(row, column, 3);
m = 1; n = 1;
for i = 1:size(img,1)
    for j = 1:size(img,2)
        newImage(m,n,:) = img(i,j,:);
        newImage(m,n+1,:) = img(i,j,:);
        newImage(m+1,n,:) = img(i,j,:);
        newImage(m+1,n+1,:) = img(i,j,:);
        n = n+2;
    end
    m = m+2;
    n = 1;    
end
newImage = uint8(newImage);
figure, imshow(newImage);



% --- Executes on button press in zoomout_button.
function zoomout_button_Callback(hObject, eventdata, handles)
% hObject    handle to zoomout_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
if isempty(img)
    errordlg( 'Please upload an image' );
    return
else
    axes(handles.axes1);
    imshow(img);
end;
newImage = zeros(round(size(img,1)/2), round(size(img,2)/2), 3);
m = 1; n = 1;
for i = 1:size(newImage,1)
    for j = 1:size(newImage,2)
        newImage(i,j,:) = img(m,n,:);
        n = round(n+2);
    end
    m = round(m+2);
    n = 1;
end
newImage = uint8(newImage);
figure, imshow(newImage);


% --- Executes on button press in grayscale_button.
function grayscale_button_Callback(hObject, eventdata, handles)
% hObject    handle to grayscale_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
if isempty(img)
    errordlg( 'Please upload an image' );
    return
else
    axes(handles.axes1);
    imshow(img);
end;
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);
gray = 0.4*R + 0.3*G + 0.3*B;

axes(handles.axes2);
imshow(gray);


% --- Executes on button press in textplus.
function textplus_Callback(hObject, eventdata, handles)
% hObject    handle to textplus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
global img;
if isempty(img)
    errordlg( 'Please upload an image' );
    return
else
    axes(handles.axes1);
    imshow(img);
end;
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

newImg = img;
val = str2num(get(handles.textmin,'String'));
if isempty(val) || isnan(val)
    errordlg( 'Please input numeric value in the side box' );
    return
end
newImg(:,:,1) = R-val;
newImg(:,:,2) = G-val;
newImg(:,:,3) = B-val;

axes(handles.axes2);
imshow(newImg);

% --- Executes on button press in brightmulti.
function brightmulti_Callback(hObject, eventdata, handles)
% hObject    handle to brightmulti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
if isempty(img)
    errordlg( 'Please upload an image' );
    return
else
    axes(handles.axes1);
    imshow(img);
end;
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

newImg = img;
val = str2num(get(handles.textmulti,'String'));
if isempty(val) || isnan(val)
    errordlg( 'Please input numeric value in the side box' );
    return
end
newImg(:,:,1) = R*val;
newImg(:,:,2) = G*val;
newImg(:,:,3) = B*val;

axes(handles.axes2);
imshow(newImg);

% --- Executes on button press in brightdiv.
function brightdiv_Callback(hObject, eventdata, handles)
% hObject    handle to brightdiv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
if isempty(img)
    errordlg( 'Please upload an image' );
    return
else
    axes(handles.axes1);
    imshow(img);
end;
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

newImg = img;
val = str2num(get(handles.textdiv,'String'));
if isempty(val) || isnan(val)
    errordlg( 'Please input numeric value in the side box' );
    return
end
newImg(:,:,1) = R/val;
newImg(:,:,2) = G/val;
newImg(:,:,3) = B/val;

axes(handles.axes2);
imshow(newImg);


% --- Executes on button press in bottombutton.
function bottombutton_Callback(hObject, eventdata, handles)
% hObject    handle to bottombutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
if isempty(img)
    errordlg( 'Please upload an image' );
    return
else
    axes(handles.axes1);
    imshow(img);
end;
[h, w] = size(img);
movePixel = - str2num(get(handles.textbottom,'String'));
if isempty(movePixel) || isnan(movePixel)
    errordlg( 'Please input numeric value in the side box' );
    return
end
tempImg = double(img);
newImg = zeros(size(tempImg));
for y=1 :h
    for x=1 :w
        oldx = x;
        oldy = y + movePixel;
        
        if (oldx >= 1) && (oldx<=w) && (oldy>=1) && (oldy<=h)
            newImg(y,x) = tempImg(oldy,oldx);
        else
            newImg(y,x) = 0;
        end
    end
end

newImg = uint8(newImg);
axes(handles.axes2);
imshow(newImg);



function textbottom_Callback(hObject, eventdata, handles)
% hObject    handle to textbottom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textbottom as text
%        str2double(get(hObject,'String')) returns contents of textbottom as a double


% --- Executes during object creation, after setting all properties.
function textbottom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textbottom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in upbutton.
function upbutton_Callback(hObject, eventdata, handles)
% hObject    handle to upbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
if isempty(img)
    errordlg( 'Please upload an image' );
    return
else
    axes(handles.axes1);
    imshow(img);
end;
[h, w] = size(img);
movePixel = str2num(get(handles.textup,'String'));
if isempty(movePixel) || isnan(movePixel)
    errordlg( 'Please input numeric value in the side box' );
    return
end
tempImg = double(img);
newImg = zeros(size(tempImg));
for y=1 :h
    for x=1 :w
        oldx = x;
        oldy = y + movePixel;
        
        if (oldx >= 1) && (oldx<=w) && (oldy>=1) && (oldy<=h)
            newImg(y,x) = tempImg(oldy,oldx);
        else
            newImg(y,x) = 0;
        end
    end
end
newImg = uint8(newImg);
axes(handles.axes2);
imshow(newImg);

function textup_Callback(hObject, eventdata, handles)
% hObject    handle to textup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textup as text
%        str2double(get(hObject,'String')) returns contents of textup as a double


% --- Executes during object creation, after setting all properties.
function textup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textleft_Callback(hObject, eventdata, handles)
% hObject    handle to textleft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textleft as text
%        str2double(get(hObject,'String')) returns contents of textleft as a double


% --- Executes during object creation, after setting all properties.
function textleft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textleft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textright_Callback(hObject, eventdata, handles)
% hObject    handle to textright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textright as text
%        str2double(get(hObject,'String')) returns contents of textright as a double


% --- Executes during object creation, after setting all properties.
function textright_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in leftbutton.
function leftbutton_Callback(hObject, eventdata, handles)
% hObject    handle to leftbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
if isempty(img)
    errordlg( 'Please upload an image' );
    return
else
    axes(handles.axes1);
    imshow(img);
end;
[h, w] = size(img);
movePixel = str2num(get(handles.textleft,'String'));
if isempty(movePixel) || isnan(movePixel)
    errordlg( 'Please input numeric value in the side box' );
    return
end
tempImg = double(img);
newImg = zeros(size(tempImg));
for y=1 :h
    for x=1 :w
        oldx = x + movePixel;
        oldy = y;
        
        if (oldx >= 1) && (oldx<=w) && (oldy>=1) && (oldy<=h)
            newImg(y,x) = tempImg(oldy,oldx);
        else
            newImg(y,x) = 0;
        end
    end
end
newImg = uint8(newImg);
axes(handles.axes2);
imshow(newImg);

% --- Executes on button press in rightbutton.
function rightbutton_Callback(hObject, eventdata, handles)
% hObject    handle to rightbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
if isempty(img)
    errordlg( 'Please upload an image' );
    return
else
    axes(handles.axes1);
    imshow(img);
end;
[h, w] = size(img);
movePixel = str2num(get(handles.textright,'String'));
if isempty(movePixel) || isnan(movePixel)
    errordlg( 'Please input numeric value in the side box' );
    return
end
tempImg = double(img);
newImg = zeros(size(tempImg));
for y=1 :h
    for x=1 :w
        oldx = x - movePixel;
        oldy = y;
        
        if (oldx >= 1) && (oldx<=w) && (oldy>=1) && (oldy<=h)
            newImg(y,x) = tempImg(oldy,oldx);
        else
            newImg(y,x) = 0;
        end
    end
end
newImg = uint8(newImg);
axes(handles.axes2);
imshow(newImg);

% --- Executes on button press in brightplus.
function brightplus_Callback(hObject, eventdata, handles)
% hObject    handle to brightplus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
if isempty(img)
    errordlg( 'Please upload an image' );
    return
else
    axes(handles.axes1);
    imshow(img);
end;
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

newImg = img;
val = str2num(get(handles.textplus,'String'));
if isempty(val) || isnan(val)
    errordlg( 'Please insert numeric value in the side box' );
    return
end
newImg(:,:,1) = R+val;
newImg(:,:,2) = G+val;
newImg(:,:,3) = B+val;

axes(handles.axes2);
imshow(newImg);



function textmin_Callback(hObject, eventdata, handles)
% hObject    handle to textmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textmin as text
%        str2double(get(hObject,'String')) returns contents of textmin as a double



function textmulti_Callback(hObject, eventdata, handles)
% hObject    handle to textmulti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textmulti as text
%        str2double(get(hObject,'String')) returns contents of textmulti as a double


% --- Executes on button press in equalizer.
function equalizer_Callback(hObject, eventdata, handles)
% hObject    handle to equalizer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
if isempty(img)
    errordlg( 'Please upload an image' );
    return
else
    newImg= HistEqualize(img);
    axes(handles.axes2);
    imshow(newImg);
end;


% --- Executes on button press in histogram.
function histogram_Callback(hObject, eventdata, handles)
% hObject    handle to histogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
if isempty(img)
    errordlg( 'Please upload an image' );
    return
else
    red = zeros(256,1);
    green = zeros(256,1);
    blue = zeros(256,1);
    for i =1:size(img,1)
        for j = 1:size(img,2)
            x = img(i,j,1)+1;
            y = img(i,j,2)+1;
            z = img(i,j,3)+1;
            red(x) = red(x)+1;
            green(y) = green(y)+1;
            blue(z) = blue(z)+1;
        end
    end
    axes(handles.axes2);
    plot(red);
    plot(green);
    plot(blue);
end;


% --- Executes on button press in edgebutton.
function edgebutton_Callback(hObject, eventdata, handles)
% hObject    handle to edgebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
Kernel = [-1 0 -1; 0 4 0; -1 0 -1];
newImg = Konvolusi(img,Kernel);
newImg = uint8(newImg);
axes(handles.axes2);
imshow(newImg);


% --- Executes on button press in blur.
function blur_Callback(hObject, eventdata, handles)
% hObject    handle to blur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
Kernel = 1/9 * [1 1 1; 1 1 1; 1 1 1];
newImg = Konvolusi(img,Kernel);
newImg = uint8(newImg);
axes(handles.axes2);
imshow(newImg);

% --- Executes on button press in sharp.
function sharp_Callback(hObject, eventdata, handles)
% hObject    handle to sharp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img;
Kernel = [0 -1 0; -1 5 -1; 0 -1 0];
newImg = Konvolusi(img,Kernel);
newImg = uint8(newImg);
axes(handles.axes2);
imshow(newImg);
