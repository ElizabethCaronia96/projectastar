function varargout = astar_gui(varargin)
% ASTAR_GUI MATLAB code for astar_gui.fig
%      ASTAR_GUI, by itself, creates a new ASTAR_GUI or raises the existing
%      singleton*.
%
%      H = ASTAR_GUI returns the handle to a new ASTAR_GUI or the handle to
%      the existing singleton*.
%
%      ASTAR_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ASTAR_GUI.M with the given input arguments.
%
%      ASTAR_GUI('Property','Value',...) creates a new ASTAR_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before astar_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to astar_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help astar_gui

% Last Modified by GUIDE v2.5 12-Feb-2018 22:41:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @astar_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @astar_gui_OutputFcn, ...
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


% --- Executes just before astar_gui is made visible.
function astar_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to astar_gui (see VARARGIN)

% Choose default command line output for astar_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes astar_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = astar_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function x1_Callback(hObject, eventdata, handles)
% hObject    handle to x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x1 as text
%        str2double(get(hObject,'String')) returns contents of x1 as a double

% --- Executes during object creation, after setting all properties.
function x1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y1_Callback(hObject, eventdata, handles)
% hObject    handle to y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y1 as text
%        str2double(get(hObject,'String')) returns contents of y1 as a double

% --- Executes during object creation, after setting all properties.
function y1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x2_Callback(hObject, eventdata, handles)
% hObject    handle to x2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x2 as text
%        str2double(get(hObject,'String')) returns contents of x2 as a double

% --- Executes during object creation, after setting all properties.
function x2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y2_Callback(hObject, eventdata, handles)
% hObject    handle to y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y2 as text
%        str2double(get(hObject,'String')) returns contents of y2 as a double

% --- Executes during object creation, after setting all properties.
function y2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in forward.
function forward_Callback(hObject, eventdata, handles)
% hObject    handle to forward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%0 as an uninitalized box doesn't work, everything starts as 1
%wall  =-1, start = 2, space = 1, target = 0
mapwidth = 6;
mapheight = 6;
diagram = ones(mapwidth, mapheight);
startX = str2double(get(handles.x1, 'String'));
startY = str2double(get(handles.y1, 'String'));
diagram(startY, startX) = 2;
plot(handles.mapPlot, startX,startY,  'bo')
grid on;
hold all;

goalX = str2double(get(handles.x2, 'String'));
goalY = str2double(get(handles.y2, 'String'));
diagram(goalX,goalY) = 0;
plot(handles.mapPlot, goalX, goalY, 'ro')
%loop though diagram 3 times to get obstacles, costs, and final path
repeated_forward(startX, startY, goalX, goalY, diagram, handles.mapPlot)
%row, col; row, col; map


function yobstacle_Callback(hObject, eventdata, handles)
% hObject    handle to yobstacle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yobstacle as text
%        str2double(get(hObject,'String')) returns contents of yobstacle as a double


% --- Executes during object creation, after setting all properties.
function yobstacle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yobstacle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xobstacle_Callback(hObject, eventdata, handles)
% hObject    handle to xobstacle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xobstacle as text
%        str2double(get(hObject,'String')) returns contents of xobstacle as a double


% --- Executes during object creation, after setting all properties.
function xobstacle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xobstacle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in obstacleOk.
function obstacleOk_Callback(hObject, eventdata, handles)
% hObject    handle to obstacleOk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
xVal = str2double(get(handles.xobstacle,'String'));
yVal = str2double(get(handles.yobstacle,'String'));
diagram(xVal, yVal) = -1;
surf(handles.mapPlot,diagram)


% --- Executes on button press in loadMap1.
function loadMap1_Callback(hObject, eventdata, handles)
% hObject    handle to loadMap1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mapwidth = 6;
mapheight = 6;
%hard coded obstacles
keyRows = [1, 2, 3, 4];
valCols = [3, 3, 3, 3];
for i= 1:length(keyRows)
    diagram(keyRows(i), valCols(i)) = -1;
end
plot(handles.mapPlot, valCols,keyRows,  'ko')
axis(handles.mapPlot, [1 mapwidth 1 mapheight])
set(handles.mapPlot, 'XTick', (1:mapwidth), 'YTick', (1:mapheight))
hold all;


% --- Executes on button press in addObstacles.
function addObstacles_Callback(hObject, eventdata, handles)
% hObject    handle to addObstacles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
