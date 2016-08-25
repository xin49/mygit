unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  GraphType, StdCtrls, Buttons
  ;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1:TBitBtn;
    Button1:TButton;
    Panel1:TPanel;
    Panel2:TPanel;
    Shape1:TShape;
    procedure Button1Click(Sender:TObject);
    procedure FormCreate(Sender:TObject);
    procedure FormPaint(Sender:TObject);
    procedure Panel1Paint(Sender:TObject);
    procedure Panel2Paint(Sender:TObject);
  private
    { private declarations }
  public
    aBmp:TBitMap;
    grey:Integer;
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender:TObject);
var
  i:Integer;
  widthstep, imgSize, imgWidth, imgHeight:Integer;
  pTmp:PByte;
  pImgData:PByte;
  aRawImg:TRawImage;
  aRImgDes:TRawImageDescription;
begin
  aBmp := TBitMap.Create;
  //aBmp.LoadFromFile('/root/图片/spheres.bmp');
  aBmp.PixelFormat := pf8bit;
  aBmp.SetSize(125, 125);
  aRawImg:=aBmp.RawImage;
  aRImgDes := aRawImg.Description;
  imgHeight := aRImgDes.Height;
  imgWidth := aRImgDes.Width;
  widthstep := aRImgDes.BytesPerLine;
  pImgData := aRawImg.Data;
  imgSize := aRawImg.DataSize;
  grey := 255;

  //set TBitMap content
  //for i:=0 to 64-1 do
  //begin
  //  Pointer(pTmp):=(aBmp.ScanLine[i]);
  //  FillChar(pTmp^, 125, char(255));
  //end;
end;

procedure TForm1.FormPaint(Sender:TObject);
begin
end;

procedure TForm1.Panel1Paint(Sender:TObject);
begin
end;

procedure TForm1.Button1Click(Sender:TObject);
var
  i:Integer;
  widthstep, imgSize, imgWidth, imgHeight:Integer;
  pTmp:PByte;
  pImgData:PByte;
  aRawImg:TRawImage;
  aRImgDes:TRawImageDescription;
begin
  aRawImg:=aBmp.RawImage;
  aRImgDes := aRawImg.Description;
  imgHeight := aRImgDes.Height;
  imgWidth := aRImgDes.Width;
  widthstep := aRImgDes.BytesPerLine;
  pImgData := aRawImg.Data;
  imgSize := aRawImg.DataSize;
  for i:=0 to imgHeight div 2 -1 do
  begin
    FillChar(pImgData^, imgWidth, char(grey));
    pImgData := pImgData + widthstep;
  end;
  Panel2.Canvas.Draw(0, 0, aBmp);
	if (grey) = 255 then
    grey := 0
  else
    grey := 255;
end;

procedure TForm1.Panel2Paint(Sender:TObject);
begin
  //Panel2.Canvas.Draw(0, 0, aBmp);
end;

end.

