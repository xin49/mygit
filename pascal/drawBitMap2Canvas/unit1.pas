unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  GraphType, StdCtrls, Buttons, LCLType,
  ctypes,
  linux,
  Baseunix
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
    aBmpColor:TBitMap;
    aBmpGray:TBitMap;
    { public declarations }
    procedure SetBitMapMem(aBitMap:TBitMap; memVal:Byte);
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
 		SetSize(10000, 10000);
  end;
	aBmpColor := TBitMap.Create;
  with aBmpColor do
  begin
		PixelFormat := pf24bit;
 		SetSize(10000, 10000);
  end;
  aRawImg := aBmpGray.RawImage;
  FillChar(aRawImg.Data^, aRawImg.DataSize, Char(255));
  aRawImg := aBmpColor.RawImage;
  FillChar(aRawImg.Data^, aRawImg.DataSize, Char(255));
  aRawImg := aBmpGray.RawImage;
  WriteLn('ABmpGray ImgSize:' + IntToStr(aRawImg.DataSize));
  aRawImg := aBmpColor.RawImage;
  WriteLn('ABmpColor ImgSize:' + IntToStr(aRawImg.DataSize));
end;

procedure TForm1.FormPaint(Sender:TObject);
begin
end;

procedure TForm1.Panel1Paint(Sender:TObject);
begin
end;

procedure TForm1.Button1Click(Sender:TObject);
Label
  DRAW_BTMMAP;
var
  i:Integer;
  widthstep, imgSize, imgWidth, imgHeight:Integer;
  pTmp:PByte;
  pImgData:PByte;
  aRawImg:TRawImage;
  aRImgDes:TRawImageDescription;
  hdcTmp:HDC;
  t1, t2, t3, t4:timespec;
  j : Integer;
  grayTime, colorTime, useTime, allTime:Double;
  aBmpTmp:TBitMap;
  aMemVal:Byte;
begin
  clock_gettime(CLOCK_REALTIME, @t3);
  aBmpTmp := aBmpGray;
	aMemVal := Byte(0);
DRAW_BTMMAP:
  clock_gettime(CLOCK_REALTIME, @t1);
	for i:=0 to 100-1 do
  begin
    SetBitMapMem(aBmpTmp, aMemVal);
    Panel2.Canvas.Draw(0, 0, aBmpTmp);
    aMemVal := Not(aMemVal);
  end;
  clock_gettime(CLOCK_REALTIME, @t2);
  //if (aBmpTmp = aBmpGray) then
  //begin
  //  grayTime := (t2.tv_sec - t1.tv_sec) * 1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000;
  //  aBmpTmp := aBmpGray;
  //  goto DRAW_BTMMAP;
  //end
  //else
  //begin
  //	colorTime := (t2.tv_sec - t1.tv_sec) * 1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000;
  //end;
  useTime := (t2.tv_sec - t1.tv_sec) * 1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000;
  WriteLn('useTime:' + FloatToStr(useTime));
  //WriteLn('grayTime:' + FloatToStr(grayTime));
  //WriteLn('colorTime:' + FloatToStr(colorTime));
  clock_gettime(CLOCK_REALTIME, @t4);
	allTime := (t4.tv_sec - t3.tv_sec) * 1000 + (t4.tv_nsec - t3.tv_nsec) / 1000000;
  WriteLn('allTime:' + FloatToStr(allTime));
  WriteLn('///////////////////////////////////////////////');
end;

procedure TForm1.Panel2Paint(Sender:TObject);
begin
end;

procedure TForm1.SetBitMapMem(aBitMap:TBitMap; memVal:Byte);
var
  aRawImg:TRawImage;
begin
	aRawImg := aBitMap.RawImage;
  FillChar(aRawImg.Data^, aRawImg.DataSize, memVal);
end;

end.

