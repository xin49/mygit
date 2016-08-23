unit uSImgLoadLib;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, dynlibs, cv_types;

Type
  TcvCreateImage=function(size:CvSize; depth:Integer; channels:Integer):PIplImage;cdecl;
  TcvSaveImage=procedure(imgName:PChar; pImg:PIplImage);cdecl;
  TcvLoadImage=function(imgName:PChar; colorMod:Integer):PIplImage;cdecl;
  TcvShowImage=procedure(fileName:PChar; pImg:PIplImage);cdecl;
  TcvNamedWindow=procedure(windowName:PChar; sizeMod:Integer);cdecl;
  TcvWaitKey=procedure(waitTimes:Integer);cdecl;

//function Dlopen(Name : PChar; Flags : longint) : Pointer; cdecl; external libdl;
function GenerLoadDlib(libName:string; var libHand:THandle):Integer;
function GenerGetFuncAdree(libHand:THandle; funcName:string; var pFunc:Pointer):Integer;
//procedure GenerFreeDlib();

var
  hDLibHighgui:THandle;
	cvCreateImage:TcvCreateImage;
	cvSaveImage:TcvSaveImage;
  hDLibLegacy:THandle;
  cvShowImage:TcvShowImage;
	cvLoadImage:TcvLoadImage;
  cvNamedWindow:TcvNamedWindow;
  cvWaitKey:TcvWaitKey;

implementation
function GenerLoadDlib(libName:string; var libHand:THandle):Integer;
begin
  libHand := 0;
  //if not FileExists(libName) then
  //	Exit(-2);
	libHand := LoadLibrary(libName);
  if libHand = 0 then
    Exit(-1)
  else
    Exit(0);
end;

function GenerGetFuncAdree(libHand:THandle; funcName:string; var pFunc:Pointer):Integer;
begin
	pFunc := nil;
  if libHand = 0 then
    Exit(-2);
  pFunc := GetProcedureAddress(libHand, funcName);
  if pFunc = nil then
    Exit(-1)
   else
     Exit(0);
end;

var
  retVal:Integer;

initialization
	//retVal:=GenerLoadDlib('/usr/local/lib/libopencv_legacy.so', hDLibLegacy);
 // retVal:=GenerGetFuncAdree(hDLibLegacy, 'cvCreateImage', Pointer(cvCreateImage));
	retVal:=GenerLoadDlib('libopencv_highgui.so', hDLibHighgui);
  retVal:=GenerGetFuncAdree(hDLibHighgui, 'cvLoadImage', Pointer(cvLoadImage));
  retVal:=GenerGetFuncAdree(hDLibHighgui, 'cvSaveImage', Pointer(cvSaveImage));
  retVal:=GenerGetFuncAdree(hDLibHighgui, 'cvNamedWindow', Pointer(cvNamedWindow));
  retVal:=GenerGetFuncAdree(hDLibHighgui, 'cvWaitKey', Pointer(cvWaitKey));
  retVal:=GenerGetFuncAdree(hDLibHighgui, 'cvShowImage', Pointer(cvShowImage));
finalization

end.

