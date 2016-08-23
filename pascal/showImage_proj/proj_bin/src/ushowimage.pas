unit uShowImage;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  uSImgLoadLib, cv_types;

type

  { TfrmShowImage }

  TfrmShowImage = class(TForm)
    procedure FormCreate(Sender:TObject);
    procedure FormDestroy(Sender:TObject);
    procedure FormShow(Sender:TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

  //function cvLoadImage(imgName:PChar; colorMod:Integer):PIplImage;cdecl; external 'libopencv_legacy.so';

var
  frmShowImage: TfrmShowImage;

implementation

{$R *.lfm}

{ TfrmShowImage }

procedure TfrmShowImage.FormCreate(Sender:TObject);
var
  pImgSrc:PIplImage;
begin
///root/图片/配置dfvision.png
  if FileExists('/root/图片/proj_plugin缺少.png') then
  	pImgSrc:=cvLoadImage('/root/图片/proj_plugin缺少.png', 1);
  cvNamedWindow('Image Test', 1);
	cvShowImage('Image Test', pImgSrc);
  cvWaitKey(0);
  cvSaveImage('pImgSrc.bmp', pImgSrc);
end;

procedure TfrmShowImage.FormDestroy(Sender:TObject);
begin
end;

procedure TfrmShowImage.FormShow(Sender:TObject);
begin

end;

end.

