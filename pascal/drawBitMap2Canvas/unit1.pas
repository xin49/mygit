unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  GraphType, StdCtrls, Buttons, LCLType,
  ctypes,
  linux,
  Baseunix,
  //TLazIntfImage
  intfgraphics, lazcanvas, fpImage;

type

  TRGBTripleArray = array[0..32767] of TRGBTriple;
  PRGBTripleArray = ^TRGBTripleArray;
  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1:TBitBtn;
    Button1:TButton;
    Button2:TButton;
    Button3:TButton;
    Button4:TButton;
    Button5:TButton;
    Button6:TButton;
    Button7:TButton;
    Panel1:TPanel;
    Panel2:TPanel;
    Shape1:TShape;
    procedure BitBtn1Click(Sender:TObject);
    procedure Button1Click(Sender:TObject);
    procedure Button2Click(Sender:TObject);
    procedure Button3Click(Sender:TObject);
    procedure Button4Click(Sender:TObject);
    procedure Button5Click(Sender:TObject);
    procedure Button6Click(Sender:TObject);
    procedure Button7Click(Sender:TObject);
    procedure FormCreate(Sender:TObject);
    procedure FormPaint(Sender:TObject);
    procedure Panel1Paint(Sender:TObject);
    procedure Panel2Paint(Sender:TObject);
  private
    { private declarations }
  public
    aBmpColor:TBitMap;
    aBmpGray:TBitMap;
    aBmpTmp:TBitMap;
    fillVal:Char;
    gRawImg:TRawImage;
    gLazImg:TLazIntfImage;
    { public declarations }
    procedure SetBitMapMem(aBitMap:TBitMap; memVal:Byte);
    procedure StretchDrawBitmapToBitmap(SourceBitmap, DestBitmap: TBitmap;
                DestWidth, DestHeight: Integer);
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
procedure TForm1.StretchDrawBitmapToBitmap(SourceBitmap, DestBitmap: TBitmap;
            DestWidth, DestHeight: Integer);
var
  DestIntfImage, SourceIntfImage: TLazIntfImage;
  DestCanvas: TLazCanvas;
begin
  // Prepare the destination

  DestIntfImage := TLazIntfImage.Create(0, 0);
  DestIntfImage.LoadFromBitmap(DestBitmap.Handle, 0);

  DestCanvas := TLazCanvas.Create(DestIntfImage);

  //Prepare the source
  SourceIntfImage := TLazIntfImage.Create(0, 0);
  SourceIntfImage.LoadFromBitmap(SourceBitmap.Handle, 0);

  // Execute the stretch draw via TFPSharpInterpolation
  DestCanvas.Interpolation := TFPSharpInterpolation.Create;
  DestCanvas.StretchDraw(0, 0, DestWidth, DestHeight, SourceIntfImage);

  // Reload the image into the TBitmap
  DestBitmap.LoadFromIntfImage(DestIntfImage);

  SourceIntfImage.Free;
  DestCanvas.Interpolation.Free;
  DestCanvas.Free;
  DestIntfImage.Free;
end;

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
 		SetSize(123, 125);
  end;
	aBmpColor := TBitMap.Create;
  with aBmpColor do
  begin
		PixelFormat := pfDevice;
 		SetSize(1000, 1000);
  end;
  aRawImg := aBmpGray.RawImage;
  FillChar(aRawImg.Data^, aRawImg.DataSize, Char(255));
  aRawImg := aBmpColor.RawImage;
  FillChar(aRawImg.Data^, aRawImg.DataSize, Char(50));
  fillVal := Char(0);
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
var
  t1, t2:timespec;
  i, j : Integer;
begin
  if aBmpTmp = aBmpGray then
  begin
  	aBmpTmp := aBmpColor;
    writeLn('aBmpColor');
  end
  else
  begin
	  aBmpTmp := aBmpGray;
    writeLn('aBmpGray');
  end;
  clock_gettime(CLOCK_REALTIME, @t1);
	for i:=0 to 1000-1 do
  begin
		Panel2.Canvas.Draw(0, 0, aBmpTmp);
  end;
	clock_gettime(CLOCK_REALTIME, @t2);
  WriteLn('Button1Click Used Time:' + FloatToStr((t2.tv_sec - t1.tv_sec) * 1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000));
end;

procedure TForm1.Button2Click(Sender:TObject);
var
  aRawImg:TRawImage;
begin
  if fillVal = Char(0) then
  	fillVal := Char(255)
  else
  	fillVal := Char(0);
  aBmpColor.FreeImage;
  aBmpColor.PixelFormat := pf24bit;
 	aBmpColor.SetSize(1000, 1000);
  aRawImg:=aBmpColor.RawImage;
  FillChar(aRawImg.Data^, aRawImg.DataSize, fillVal);
end;

procedure TForm1.Button3Click(Sender:TObject);
var
  t1, t2:timespec;
begin
	clock_gettime(CLOCK_REALTIME, @t1);
	Panel2.Canvas.Draw(0, 0, aBmpGray);
	clock_gettime(CLOCK_REALTIME, @t2);
  WriteLn('Button3Click Used Time:' + FloatToStr((t2.tv_sec - t1.tv_sec) * 1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000));
end;

procedure TForm1.Button4Click(Sender:TObject);
var
  aRawImg:TRawImage;
begin
  if fillVal = Char(0) then
  	fillVal := Char(255)
  else
  	fillVal := Char(0);
  aBmpGray.FreeImage;
  aBmpGray.PixelFormat := pf8bit;
 	aBmpGray.SetSize(1000, 1000);
  aRawImg:=aBmpGray.RawImage;
  FillChar(aRawImg.Data^, aRawImg.DataSize, fillVal);
end;

procedure TForm1.Button5Click(Sender:TObject);
var
  aRawImg:TRawImage;
  lazImg: TLazIntfImage;
  Row1, Row2: PRGBTripleArray;
  i, j : Integer;
begin
  if fillVal = Char(100) then
  	fillVal := Char(255)
  else
  	fillVal := Char(100);
  lazImg := aBmpColor.CreateIntfImage;
  for i:=0 to lazImg.Height-1 do
  begin
  	Row1 := lazImg.GetDataLineStart(i);
    for j:=0 to aBmpColor.Width-1 do
    begin
    	Row1^[j].rgbtRed := Byte(fillval);
    	Row1^[j].rgbtGreen := Byte(fillval);
    	Row1^[j].rgbtBlue := Byte(fillval);
    end;
  end;
  aBmpColor.LoadFromIntfImage(lazImg);
  aBmpColor.SaveToFile('aBmpColor.bmp');
end;

procedure TForm1.Button6Click(Sender:TObject);
var
  aRawImg:TRawImage;
  lazImg: TLazIntfImage;
  pImgData:PByte;
  i, j : Integer;
  Row1:PRGBTripleArray;
begin
  if fillVal = Char(100) then
  	fillVal := Char(255)
  else
  	fillVal := Char(100);
  lazImg := aBmpGray.CreateIntfImage;
  for i:=0 to lazImg.Height-1 do
  begin
    pImgData := PByte(lazImg.PixelData);
    for j:=0 to lazImg.Width-1 do
    begin
    	pImgData[i] := Byte(fillVal);
    end;
  end;
  aBmpGray.LoadFromIntfImage(lazImg);
  WriteLn('lazImg size:' + IntToStr(aBmpGray.RawImage.DataSize));
  lazImg.Free;
end;

procedure TForm1.Button7Click(Sender:TObject);
begin
	gRawImg.Init;
  gRawImg.Description.Init_BPP24_B8G8R8_BIO_TTB(1000, 1000);
  gRawImg.CreateData(False);
  FillChar(gRawImg.Data^, gRawImg.DataSize, Byte(150));
  gLazImg := TLazIntfImage.Create(0, 0);
  gLazImg.SetRawImage(gRawImg);
end;

procedure TForm1.BitBtn1Click(Sender:TObject);
var
  t1, t2:timespec;
begin
	clock_gettime(CLOCK_REALTIME, @t1);
	Panel2.Canvas.Draw(0, 0, aBmpColor);
	clock_gettime(CLOCK_REALTIME, @t2);
  WriteLn('BitBtn1Click Used Time:' + FloatToStr((t2.tv_sec - t1.tv_sec) * 1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000));
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

