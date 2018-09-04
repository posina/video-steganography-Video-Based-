function varargout = gui(varargin)
% GUI M-file for gui.fig
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
%      applied to the GUI before gui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
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

a=ones(256,256);
imshow(a);
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


% --- Executes on button press in Browse.
function Browse_Callback(hObject, eventdata, handles)
% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 [filename, pathname] = uigetfile('*.avi', 'Pick an video');
        msg='Input Video Is selected';
        set(handles.edit3,'string',msg)
    if isequal(filename,0) | isequal(pathname,0)
        
        msg='File is not selected';
        set(handles.edit3,'string',msg)
       %warndlg('File is not selected');
       
        
    else
        
        a=aviread(filename);
        movie(a);
handles.filename=filename
    % Update handles structure
guidata(hObject, handles);    
    end

 

% --- Executes on button press in Watermark.
function Watermark_Callback(hObject, eventdata, handles)
% hObject    handle to Watermark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


str2='.bmp'
Bitstream=[];
Bitstream1=[];
j1=1;
%  h = waitbar(0,'Encoding...');
bitbudget = 1000000;

%   h = waitbar(0,'Please wait...');

            % computation here %


  

for i=1:5
 filename_1=strcat(strcat(num2str(i)),str2);%%%%%%%%%%%%%% form filename
%              waitbar(i/5,h)
%  Image1=imread(filename_1);

%  clear;
 X=imread(filename_1);
 
% X=magic(8);
X=imresize(X,[256,256]); 
sX = size(X);
 [r_1 c_1]=size(X);
 Input_filesize=r_1*c_1*10;
% set wavelet filter to haar as it is the simplest
filter = 'haar';

% record start time
tic;

% perform single-level decomposition of X. 
[cA1,cH1,cV1,cD1] = dwt2(X, filter);

% record wavelet transform time and output
dwttime = toc;

% fprintf('\nDWT time:    %6.3f seconds\n', dwttime);
cA1 = fix(cA1); 
cH1 = fix(cH1); 
cV1 = fix(cV1); 
cD1 = fix(cD1); 
%%%%%%%%%%%%%%%%%%%%%data hiding


%%%%%%vesselimage
% ice=imread('n64.bmp');
ice=cA1;
original=ice;
sz1=size(original);
K=sz1(1);
N=sz1(1)*sz1(2);
target=reshape(original,[1 N]);
A=target;
size1=N;

% re=reshape(target,[64 64]);
%%%%%%%%%copyright

fid = fopen('message.txt','r');
ice1= fread(fid);
s = char(ice1');
fclose(fid);

% ice1=imread('cs.jpg');
original1=ice1;
sz2=size(original1);
M=sz2(1)*sz2(2);
K1=sz2(1);
target1=reshape(original1,[1 M]);
B=target1;

% re1=reshape(target,[64 64]);

size2=sz2(1);



if size2> size1 
    fprintf('\nImage File Size  %d\n',N);
    fprintf('Text  File Size  %d\n',M);
    disp('Text File is too Large');
else
    fprintf('\nImage File Size  %d\n',N);
    fprintf('Text  File Size  %d\n',M);
    disp('Text File is Small');
   
%     [r1,r2,r3]=hidetext(o1,o2,o3,a); 


%         A1=bitand(A,254);
A1=zeros(1,N);
for i=1:N
    b1=A(i);
     b2=A1(i);
       b2=bitand(b1,510);
       A1(i)=b2;
    i=i+1;
end

        
        
      i=1;
      j=1;
      while j<M
          
            if bitand(B(j),128)== 128
               A1(i)=bitor(A1(i),1);
               
            end
            i=i+1;

            if bitand(B(j),64)== 64
                A1(i)=bitor(A1(i),1);
            end
            i=i+1;

            if bitand(B(j),32)== 32
            A1(i)=bitor(A1(i),1);
            end
            i=i+1;
            if bitand(B(j),16)== 16
            A1(i)=bitor(A1(i),1);
            end
            i=i+1;
            if bitand(B(j),8)== 8
            A1(i)=bitor(A1(i),1);
            end
             i=i+1;
            if bitand(B(j),4)== 4
            A1(i)=bitor(A1(i),1);
            end
            i=i+1;
            if bitand(B(j),2)== 2
            A1(i)=bitor(A1(i),1);
            end
            i=i+1;
            if bitand(B(j),1)== 1
            A1(i)=bitor(A1(i),1);
            end
            i=i+1;
            j=j+1;
    
        end
    
    HIDEN=reshape(A1,[K K]);
    imshow(HIDEN);
    imwrite(HIDEN,'embed.bmp','bmp');
    
    
    
end 




b=A1;







output1=b;
cA1=b;


cA1=reshape(b,[K K]);


% put it into the tree structure
dec2d = [... 
        cA1,     cH1;     ... 
        cV1,     cD1      ... 
        ];
      dec2d=double(dec2d);  
% round all coefficients
% dec2d = fix(dec2d);        
input=dec2d;
% reset start time


% perform SPIHT compression where encoded contains output and bits contains
% the amount of bits used.
[encoded bits] = cSPIHT(dec2d, 1, bitbudget);

% record cSPIHT time and output

 
 Bitstream{j1}=encoded;
  Bitstream1(j1)=bits;
j1=j1+1;

end
%  close(h)
%       close(h)
% 
Compresed_file_size=sum(Bitstream1)
Compresed_file_size=Compresed_file_size;
%  close(h)
 Comp_RATIO= Input_filesize/Compresed_file_size;
 save Comp_RATIO Comp_RATIO;
  save Bitstream;

save Bitstream1;

%warndlg('Process completed');
        msg='Process Completed';
        set(handles.edit3,'string',msg)

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A_2='.bmp';
A_3='.jpg';
 load Bitstream;
  load Bitstream1;
  filter='haar';
  
%          h = waitbar(0,'Please wait...');


      
       

  
  
  
  for i=1:5
             A_1=num2str(i);
		encoded = Bitstream{i};
		
% 		            waitbar(i/5,h)
		bits= Bitstream1(i);
		
		[decoded level] = dSPIHT(encoded, bits);
		
		% record cSPIHT time and output
		
		
		
		% put it back into the form wanted by idwt2
		cA1 = decoded(1:(sX(1)/2), 1:(sX(1)/2));
		cH1 = decoded(1:(sX(1)/2), (sX(1)/2 + 1):sX(1));
		cV1 = decoded((sX(1)/2 + 1):sX(1), 1:(sX(1)/2));
		cD1 = decoded((sX(1)/2 + 1):sX(1), (sX(1)/2 + 1):sX(1));
		
		% reset start time
		
		%%%%%%%%%%%%%%%%%%%%%%data retrival
		A1=cA1;
		i=1;
		j=1;
		txt=zeros(1,M);  
		while j<M
		
		
				if bitand(A1(i),1)== 1 
				txt(j)=bitor(txt(j),128);
				end
				i=i+1;
				if bitand(A1(i),1)== 1
				txt(j)=bitor(txt(j),64);
				end
                 i=i+1;
				if bitand(A1(i),1)== 1 
				txt(j)=bitor(txt(j),32);
				end
                 i=i+1;
				if bitand(A1(i),1)== 1 
				txt(j)=bitor(txt(j),16);
                   end
                    i=i+1;
				if bitand(A1(i),1)== 1 
				txt(j)=bitor(txt(j),8);
				end
                 i=i+1;
				if bitand(A1(i),1)== 1 
				txt(j)=bitor(txt(j),4);
				end
                 i=i+1;
				if bitand(A1(i),1)== 1 
				txt(j)=bitor(txt(j),2);
				end
                 i=i+1;
				if bitand(A1(i),1)== 1 
				txt(j)=bitor(txt(j),1);
				end
                 i=i+1;
                 j=j+1;
		end
		
		output=txt;
%          close(h)
        
          fid = fopen('output.txt','wb');
        fwrite(fid,char(txt),'char');
        fclose(fid);
        
% 		RETRIVE=reshape(txt,[K1 K1]);
% 		imshow(RETRIVE,[]);
	
		
		filename1=strcat(A_1,A_3);
cd ('output');
% 		RETRIVE=uint8(RETRIVE);
		%  aa=imresize(RETRIVE,[256 256]); %%%%%%%%%%% resize into original file
% 		imwrite(RETRIVE,filename1); %%%%%%%%%%%%%% store it as an image
		%  imshow(aa,[]);
		cd ..;
		%%%%%%%%%%%%%%%%%%%%%%%%
		
		
		
		
		
		
		
		
		dec2d2 = [... 
            cA1,     cH1;     ... 
            cV1,     cD1      ... 
            ];
            
            output=dec2d2;
		% reconstruct image from wavelet coefficients
		dec = idwt2(cA1,cH1,cV1,cD1,filter);
		
		filename=strcat(A_1,A_2);
%  figure;
%%%%%%%%%%%%%%%%%%%%%%%%%%%change the directory for output
cd ('output');
 aa=uint8(dec);
 aa=imresize(aa,[256 256]); %%%%%%%%%%% resize into original file
 imwrite(aa,filename); %%%%%%%%%%%%%% store it as an image
%  imshow(aa,[]);
 cd ..;
end


%%%%%%%%%%%%%%%%% convert movie frame frames

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%convert frame to movies
% frm_cnt=handles.frm_cnt;
 frm_cnt=5;
number_of_frames=frm_cnt;
filetype='.bmp';
display_time_of_frame=1;
cd ('output');
Movie_from_frames(filetype,number_of_frames,display_time_of_frame)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 cd ..;
 

% --- Executes on button press in Display_Watermark.
function Display_Watermark_Callback(hObject, eventdata, handles)
% hObject    handle to Display_Watermark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


str1= '.jpg'

cd ('\output');
figure;
%frm_cnt=handles.frm_cnt;
frm_cnt=10;
for i=1:frm_cnt
    
    b=num2str(i);
    c=strcat(b,str1);
    file=imread(c);
    subplot(1,frm_cnt,i);
    imshow(file);
end

cd ..;
%warndlg('Process completed');
        msg='Process completed';
        set(handles.edit3,'string',msg)





% --- Executes on button press in Clear.
function Clear_Callback(hObject, eventdata, handles)
% hObject    handle to Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%delete *.bmp
%delete *.mat
a=[];
set(handles.psnr,'string',a)
set(handles.cr,'string',a)
set(handles.edit3,'string',a)

axes(handles.one);cla


% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close


% --- Executes during object deletion, before destroying properties.
function Display_Watermark_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to Display_Watermark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function psnr_Callback(hObject, eventdata, handles)
% hObject    handle to psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of psnr as text
%        str2double(get(hObject,'String')) returns contents of psnr as a double


% --- Executes during object creation, after setting all properties.
function cr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



function cr_Callback(hObject, eventdata, handles)
% hObject    handle to cr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cr as text
%        str2double(get(hObject,'String')) returns contents of cr as a double


% --- Executes on button press in Validate.
function Validate_Callback(hObject, eventdata, handles)
% hObject    handle to Validate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


load Comp_RATIO;

cd ('output');
a=imread('1.bmp');%%%%%%%%%%% read the input image
% a=rgb2gray(a);
a=imresize(a,[256,256]);
Input= a;
Input=double(Input);
cd ..;

b=imread('1.bmp'); %%%%%%%%%%%%%%%% read the output image
b=imresize(b,[256,256]);
output=b;
output=double(output);
n=size(Input);
M=n(1);
N=n(2);

% output=imresize(output,[M N]);
%%%%%%%%%%%%%%%%%%%calcilate mean square error
MSE = sum(sum((Input-output).^2))/(M*N);
set(handles.edit4,'String',MSE);
%fprintf('\nMSE: %7.2f ', MSE);
PSNR = 10*log10(255*255/MSE);
PSNR=num2str(PSNR); %%%%%%%%%%%%%%%%%%calculate psnr
% fprintf('\nMSE: %7.2f ', PSNR);
set(handles.psnr,'String',PSNR);
Comp_RATIO=num2str(Comp_RATIO);
set(handles.cr,'String',Comp_RATIO);
cd ..;


% --- Executes on button press in Back.
function Back_Callback(hObject, eventdata, handles)
% hObject    handle to Back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

guidemo


% --- Executes on button press in View_Message.
function View_Message_Callback(hObject, eventdata, handles)
% hObject    handle to View_Message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

open('message.txt');

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('output.txt');


% --- Executes on button press in Frame_Conversion.
function Frame_Conversion_Callback(hObject, eventdata, handles)
% hObject    handle to Frame_Conversion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


filename = handles.filename;
str2='.bmp'
file=aviinfo(filename); % to get inforamtaion abt video file
frm_cnt=file.NumFrames          % No.of frames in the video file  
handles.frm_cnt=frm_cnt;
    h = waitbar(0,'Please wait...');
for i=1:frm_cnt
    frm(i)=aviread(filename,i);         % read the Video file
    frm_name=frame2im(frm(i));    
      frm_name=rgb2gray(frm_name);                                                  % Convert Frame to image file
    filename1=strcat(strcat(num2str(i)),str2);
    imwrite(frm_name,filename1);      % Write image file  
     waitbar(i/frm_cnt,h)
end
 close(h)
 guidata(hObject, handles);
 
        msg='Frame Seperation is Completed';
        set(handles.edit3,'string',msg)
 %helpdlg('Frame seperation is Completed');   
 
 
 
 
 
 


% --- Executes on button press in Play_Movie.
function Play_Movie_Callback(hObject, eventdata, handles)
% hObject    handle to Play_Movie (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



[filename, pathname] = uigetfile('*.avi', 'Pick an video');
    if isequal(filename,0) | isequal(pathname,0)
        
       warndlg('File is not selected');
       
        
    else
        filename=strcat(pathname,filename);
        a=aviread(filename);
        movie(a);
% handles.filename=filename
    % Update handles structure
guidata(hObject, handles);    
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


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=[];
set(handles.psnr,'string',a)
set(handles.cr,'string',a)
set(handles.edit3,'string',a)

axes(handles.one);cla



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


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
