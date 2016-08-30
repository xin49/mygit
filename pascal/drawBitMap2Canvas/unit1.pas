unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  GraphType, StdCtrls, Buttons, LCLType,
  ctypes,
  linux,
  Baseunix,
  intfgraphics,
  lazcanvas,
  fpImage
  ;

type
  TRGBTripleArray = array[0..32767] of TRGBTriple;
  PRGBTripleArray = ^TRGBTripleArray;

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1:TBitBtn;
    BitBtn2:TBitBtn;
    Button1:TButton;
    Button2:TButton;
    Button3:TButton;
    Button4:TButton;
    Panel1:TPanel;
    Panel2:TPanel;
    Shape1:TShape;
    procedure BitBtn1Click(Sender:TObject);
    procedure BitBtn2Click(Sender:TObject);
    procedure Button1Click(Sender:TObject);
    procedure Button2Click(Sender:TObject);
    procedure Button3Click(Sender:TObject);
    procedure Button4Click(Sender:TObject);
    procedure FormCreate(Sender:TObject);
    procedure FormPaint(Sender:TObject);
    procedure Panel1Paint(Sender:TObject);
    procedure Panel2Paint(Sender:TObject);
  private
    { private declarations }
  public
    memVal : Integer;
    aBmpColor:TBitMap;
    aBmpGray:TBitMap;
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
	aBmpGray := TBitMap.Create;
  with aBmpGray do
  begin
		PixelFormat := pf8bit;
 		SetSize(5000, 5000);
  end;
	aBmpColor := TBitMap.Create;
  with aBmpColor do
  begin
		PixelFormat := pf24bit;
 		SetSize(5000, 5000);
  end;
  aRawImg := aBmpGray.RawImage;
  FillChar(aRawImg.Data^, aRawImg.DataSize, Char(0));
  aRawImg := aBmpColor.RawImage;
  FillChar(aRawImg.Data^, aRawImg.DataSize, Char(255));
  aRawImg := aBmpGray.RawImage;
  WriteLn('ABmpGray ImgSize:' + IntToStr(aRawImg.DataSize));
  aRawImg := aBmpColor.RawImage;
  WriteLn('ABmpColor ImgSize:' + IntToStr(aRawImg.DataSize));
  memVal := 100;
end;

procedure TForm1.FormPaint(Sender:TObject);
begin
end;

procedure TForm1.Panel1Paint(Sender:TObject);
begin
end;

procedure TForm1.Button1Click(Sender:TObject);
var
	t1, t2 : timespec;
begin
  clock_gettime(CLOCK_REALTIME, @t1);
  Panel2.Canvas.Draw(0, 0, aBmpColor);
  clock_gettime(CLOCK_REALTIME, @t2);
  WriteLn('ABmpColor Used Time:' +
  	FloatToStr((t2.tv_sec - t1.tv_sec) * 1000 + (t2.tv_nsec - t2.tv_nsec) / 1000000) + 'ms');
end;

procedure TForm1.BitBtn1Click(Sender:TObject);
var
  aRawImg:TRawImage;
begin
  aRawImg := aBmpColor.RawImage;
  if aRawImg.Data[0] = Byte(255) then
    FillChar(aRawImg.Data^, aRawImg.DataSize, Char(0))
  else
    FillChar(aRawImg.Data^, aRawImg.DataSize, Char(255));
end;

procedure TForm1.BitBtn2Click(Sender:TObject);
var
  aRawImg:TRawImage;
begin
  aRawImg := aBmpGray.RawImage;
  if aRawImg.Data[0] = Byte(255) then
    FillChar(aRawImg.Data^, aRawImg.DataSize, Char(0))
  else
    FillChar(aRawImg.Data^, aRawImg.DataSize, Char(255));
end;

procedure TForm1.Button2Click(Sender:TObject);
var
	t1, t2 : timespec;
begin
  clock_gettime(CLOCK_REALTIME, @t1);
  Panel2.Canvas.Draw(0, 0, aBmpGray);
  clock_gettime(CLOCK_REALTIME, @t2);
  WriteLn('ABmpGray Used Time:' +
  	FloatToStr((t2.tv_sec - t1.tv_sec) * 1000 + (t2.tv_nsec - t2.tv_nsec) / 1000000) + 'ms');
end;

procedure TForm1.Button3Click(Sender:TObject);
var
  aLazImg:TLazIntfImage;
  row:PRGBTripleArray;
  i,j : Integer;
  pImgData:PByte;
begin
  if memVal = 200 then
    memVal := 100
  else
    memVal := 200;
	aLazImg := aBmpColor.CreateIntfImage;
	for i:=0 to aBmpColor.Height-1 do
  begin
    pImgData := PByte(aLazImg.GetDataLineStart(i));
    for j:=0 to aBmpColor.Width-1 do
    begin
      PimgData[4 * j + 0] := Byte(memVal);
      PimgData[4 * j + 1] := Byte(memVal - 50);
      PimgData[4 * j + 2] := Byte(memVal - 90);
      //row^[j].rgbtRed:= Byte(memVal);
      //row^[j].rgbtGreen := Byte(memVal - 50);
      //row^[j].rgbtBlue := Byte(memVal - 90);
    end;
  end;
  aBmpColor.LoadFromIntfImage(aLazImg);
  aLazImg.Free;
  aBmpColor.SaveToFile('aBmpColor.bmp');
end;

procedure TForm1.Button4Click(Sender:TObject);
begin

end;

procedure TForm1.Panel2Paint(Sender:TObject);
begin
end;

end.

