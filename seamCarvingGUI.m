function varargout = seamCarvingGUI(varargin)
% SEAMCARVINGGUI MATLAB code for seamCarvingGUI.fig
%      SEAMCARVINGGUI, by itself, creates a new SEAMCARVINGGUI or raises the existing
%      singleton*.
%
%      H = SEAMCARVINGGUI returns the handle to a new SEAMCARVINGGUI or the handle to
%      the existing singleton*.
%
%      SEAMCARVINGGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEAMCARVINGGUI.M with the given input arguments.
%
%      SEAMCARVINGGUI('Property','Value',...) creates a new SEAMCARVINGGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before seamCarvingGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to seamCarvingGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help seamCarvingGUI

% Last Modified by GUIDE v2.5 14-Aug-2017 14:53:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
timeTaken='';
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @seamCarvingGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @seamCarvingGUI_OutputFcn, ...
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


% --- Executes just before seamCarvingGUI is made visible.
function seamCarvingGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to seamCarvingGUI (see VARARGIN)

% Choose default command line output for seamCarvingGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes seamCarvingGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = seamCarvingGUI_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in openImage.
function openImage_Callback(hObject, eventdata, handles)
% hObject    handle to openImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.SI=figure(1);
% Get file name
[FileName,PathName] = uigetfile('*.*','Select Image');

if (FileName)==0
    disp('Invalid file name');
    return
end

FullPathName = [PathName,'',FileName];

%read in image and get size
rgbX = imread(FullPathName);
handles.rgbX = double(rgbX)/255;
handles.X = (handles.rgbX);
[pathstr,name,ext] = fileparts(FullPathName);

handles.nameOfFile=name;
numProp=str2double(get(handles.proposals,'String'));

handles.orgImg=handles.X;

%Filter the image according to object proposals from SalProp boxes
img=filterImageByProposal(handles.X,handles.nameOfFile,numProp);
edgeMap=findEnergy(img);
imshow(edgeMap);
handles.X = img;

handles.dispX=handles.orgImg;

[handles.Orows handles.Ocols handles.Odim]=size(handles.X);
[handles.rows handles.cols handles.dim]=size(handles.X);

iptsetpref('ImshowBorder','tight');
ImagePlot(handles);

guidata(hObject,handles);

return;

function ImagePlot(handles)
    figure(handles.SI)
    
    %Display the reqired Image
    imshow(handles.dispX,[min(handles.dispX(:)) max(handles.dispX(:))]);
        
    set(handles.newCols,'String',num2str(handles.cols));
    set(handles.newRows,'String',num2str(handles.rows));

return


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over openImage.
function openImage_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to openImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function newRows_Callback(hObject, eventdata, handles)
% hObject    handle to newRows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of newRows as text
%        str2double(get(hObject,'String')) returns contents of newRows as a double


% --- Executes during object creation, after setting all properties.
function newRows_CreateFcn(hObject, eventdata, handles)
% hObject    handle to newRows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function newCols_Callback(hObject, eventdata, handles)
% hObject    handle to newCols (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of newCols as text
%        str2double(get(hObject,'String')) returns contents of newCols as a double


% --- Executes during object creation, after setting all properties.
function newCols_CreateFcn(hObject, eventdata, handles)
% hObject    handle to newCols (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reduceImage.
function reduceImage_Callback(hObject, eventdata, handles)
% hObject    handle to reduceImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Get the new size of image
newcols=str2double(get(handles.newCols,'String'));
newrows=str2double(get(handles.newRows,'String'));

%Calculate the number of rows and columns to reduce
Rcols = handles.cols-newcols;
Rrows = handles.rows-newrows;

% Perform a check for limits
if abs(Rcols)>=handles.cols || abs(Rrows)>=handles.rows
    errordlg('Specified dimensions cannot be calculated, minimum image size is 1x1, and maximum is (2xCurrentSize)-1')
    set(handles.newCols,'String',handles.cols);
    set(handles.newRows,'String',handles.rows);
    return
elseif Rrows==0 && Rcols==0
    return
end

set(handles.figure1,'Pointer','watch');

refresh(seamCarvingGUI) %redraws the GUI to reflect changes
startTime=tic;
%handles.energy = findEnergy(handles.X,handles.nameOfFile);

if Rcols>0
    clear M
    %downsize image by removing vertical seams
    
    M=getSeamRemovalMap(handles.X,Rcols);
    handles.orgImg=verticalSeamCut(handles.orgImg,M);
    handles.X=verticalSeamCut(handles.X,M);
    %E=verticalSeamCut(permute(handles.energy,[2 1]),M);
    %handles.energy=permute(E,[2 1]);
    [handles.rows handles.cols handles.dim]=size(handles.X);
end

if Rrows>0
    clear M
    %downsize image by removing horizontal seams
    %disp('rows - horizontal seams');
    Y=permute(handles.X,[2,1,3]);
    M=getSeamRemovalMap(Y,Rrows);
    Y=permute(handles.orgImg,[2,1,3]);
    handles.X=permute(verticalSeamCut(Y,M),[2,1,3]);
    
    [handles.rows handles.cols handles.dim]=size(handles.orgImg);
end

endTime=toc(startTime);

textLabel = sprintf('%f secs', endTime);
set(handles.time, 'String', textLabel);

handles.dispX=handles.X;

[handles.rows handles.cols handles.dim]=size(handles.X);

ImagePlot(handles)
set(handles.figure1,'Pointer','arrow');

guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function proposals_Callback(hObject, eventdata, handles)
% hObject    handle to proposals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of proposals as text
%        str2double(get(hObject,'String')) returns contents of proposals as a double


% --- Executes during object creation, after setting all properties.
function proposals_CreateFcn(hObject, eventdata, handles)
% hObject    handle to proposals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
