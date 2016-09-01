unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  //canvas info
  GraphType,
  //clock_time
  linux, BaseUnix,
  FPImage, IntfGraphics, LCLType
  ;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1:TButton;
    Button2:TButton;
    Button3:TButton;
    Button4:TButton;
    Button5:TButton;
    Button6:TButton;
    Button7:TButton;
    Button8:TButton;
    GroupBox1:TGroupBox;
    GroupBox2:TGroupBox;
    GroupBox3:TGroupBox;
    Panel1:TPanel;
    Panel2:TPanel;
    Panel3:TPanel;
    procedure Button1Click(Sender:TObject);
    procedure Button2Click(Sender:TObject);
    procedure Button3Click(Sender:TObject);
    procedure Button4Click(Sender:TObject);
    procedure Button5Click(Sender:TObject);
    procedure Button6Click(Sender:TObject);
    procedure Button7Click(Sender:TObject);
    procedure Button8Click(Sender:TObject);
    procedure FormCreate(Sender:TObject);
    procedure Panel2Paint(Sender:TObject);
  private
    { private declarations }
  public
    bmpGray:TBitMap;
    bmpColor:TBitMap;
    bmpImgValue:Byte;
    imgSzChange:Integer;
    { public declarations }
    procedure CreateLazIntfImg;
    procedure SetBitMapImg(aBmpTmp:TBitMap; imgValue:Byte);
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender:TObject);
var
  t1, t2 : timespec;
begin
  Clock_GetTime(CLOCK_REALTIME, @t1);
	//bmpColor.BeginUpdate(False);
  if bmpImgValue = Byte(200) then
  	bmpImgValue := Byte(100)
  else
  	bmpImgValue := Byte(200);
  SetBitMapImg(bmpColor, bmpImgValue);
	//bmpColor.EndUpdate(False);
  Panel2.Canvas.Draw(0, 0, bmpColor);
  //application.ProcessMessages;
  Clock_GetTime(CLOCK_REALTIME, @t2);
	WriteLn('Button1Click BmpColor Used Time:' +
  	FloatToStr((t2.tv_sec - t1.tv_sec)*1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000));
end;

procedure TForm1.Button2Click(Sender:TObject);
var
  t1, t2 : timespec;
begin
  Clock_GetTime(CLOCK_REALTIME, @t1);
	//bmpGray.BeginUpdate(False);
  if bmpImgValue = Byte(200) then
  	bmpImgValue := Byte(100)
  else
  	bmpImgValue := Byte(200);
  SetBitMapImg(bmpGray, bmpImgValue);
	//bmpGray.EndUpdate(False);
  Panel2.Canvas.Draw(0, 0, bmpGray);
  Clock_GetTime(CLOCK_REALTIME, @t2);
	WriteLn('Button1Click bmpGray Used Time:' +
  	FloatToStr((t2.tv_sec - t1.tv_sec)*1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000));
end;

procedure TForm1.Button3Click(Sender:TObject);
var
  t1, t2 : timespec;
begin
  Clock_GetTime(CLOCK_REALTIME, @t1);
	bmpColor.BeginUpdate(False);
  if bmpImgValue = Byte(200) then
  	bmpImgValue := Byte(100)
  else
  	bmpImgValue := Byte(200);
  SetBitMapImg(bmpColor, bmpImgValue);
	bmpColor.EndUpdate(False);
  Panel2.Canvas.Draw(0, 0, bmpColor);
  Clock_GetTime(CLOCK_REALTIME, @t2);
	WriteLn('Button1Click BmpColor Used Time:' +
  	FloatToStr((t2.tv_sec - t1.tv_sec)*1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000));

  Clock_GetTime(CLOCK_REALTIME, @t1);
	bmpGray.BeginUpdate(False);
  if bmpImgValue = Byte(200) then
  	bmpImgValue := Byte(100)
  else
  	bmpImgValue := Byte(200);
  SetBitMapImg(bmpGray, bmpImgValue);
	bmpGray.EndUpdate(False);
  Panel2.Canvas.Draw(0, 0, bmpGray);
  Clock_GetTime(CLOCK_REALTIME, @t2);
	WriteLn('Button1Click bmpGray Used Time:' +
  	FloatToStr((t2.tv_sec - t1.tv_sec)*1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000));
end;

procedure TForm1.Button4Click(Sender:TObject);
begin

end;

procedure TForm1.Button5Click(Sender:TObject);
begin
  CreateLazIntfImg;
end;

procedure TForm1.Button6Click(Sender:TObject);
var
  t1, t2 : timespec;
  aBmpTmp : TBitMap;
begin
  Clock_GetTime(CLOCK_REALTIME, @t1);
  aBmpTmp := TBitMap.Create;
  aBmpTmp.PixelFormat := pf8bit;
  aBmpTmp.SetSize(1255, 4000);
  if bmpImgValue = Byte(200) then
  	bmpImgValue := Byte(100)
  else
  	bmpImgValue := Byte(200);
  SetBitMapImg(aBmpTmp, bmpImgValue);
  Panel2.Canvas.Draw(0, 0, aBmpTmp);
  aBmpTmp.Free;
  Clock_GetTime(CLOCK_REALTIME, @t2);
	WriteLn('Button1Click BmpColor Used Time:' +
  	FloatToStr((t2.tv_sec - t1.tv_sec)*1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000));

  Clock_GetTime(CLOCK_REALTIME, @t1);
  aBmpTmp := TBitMap.Create;
  aBmpTmp.PixelFormat := pf24bit;
  aBmpTmp.SetSize(1255, 4000);
  if bmpImgValue = Byte(200) then
  	bmpImgValue := Byte(100)
  else
  	bmpImgValue := Byte(200);
  SetBitMapImg(aBmpTmp, bmpImgValue);
  Panel2.Canvas.Draw(0, 0, aBmpTmp);
  aBmpTmp.Free;
  Clock_GetTime(CLOCK_REALTIME, @t2);
	WriteLn('Button1Click BmpColor Used Time:' +
  	FloatToStr((t2.tv_sec - t1.tv_sec)*1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000));
end;

procedure TForm1.Button7Click(Sender:TObject);
var
  t1, t2 : timespec;
  aBmpTmp : TBitMap;
begin
  Clock_GetTime(CLOCK_REALTIME, @t1);
  if bmpImgValue = Byte(200) then
  	bmpImgValue := Byte(100)
  else
  	bmpImgValue := Byte(200);
  aBmpTmp := bmpColor;
  SetBitMapImg(aBmpTmp, bmpImgValue);
  Panel2.Canvas.Draw(0, 0, aBmpTmp);
  application.ProcessMessages;
  Sleep(1000);
  Clock_GetTime(CLOCK_REALTIME, @t2);
	WriteLn('Button7Click BmpColor Used Time:' +
  	FloatToStr((t2.tv_sec - t1.tv_sec)*1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000));

  Clock_GetTime(CLOCK_REALTIME, @t1);
  if bmpImgValue = Byte(200) then
  	bmpImgValue := Byte(100)
  else
  	bmpImgValue := Byte(200);
  aBmpTmp := bmpGray;
  SetBitMapImg(aBmpTmp, bmpImgValue);
  Panel2.Canvas.Draw(0, 0, aBmpTmp);
  application.ProcessMessages;
  Sleep(1000);
  Clock_GetTime(CLOCK_REALTIME, @t2);
	WriteLn('Button7Click bmpGray Used Time:' +
  	FloatToStr((t2.tv_sec - t1.tv_sec)*1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000));
end;

procedure TForm1.Button8Click(Sender:TObject);
var
  t1, t2 : timespec;
begin
  Clock_GetTime(CLOCK_REALTIME, @t1);
	bmpGray.PixelFormat := pf8bit;
  bmpGray.SetSize(1001 - imgSzChange, 4000 - imgSzChange);
  Clock_GetTime(CLOCK_REALTIME, @t2);
	WriteLn('BmpGray Set Size Used Time:' +
  	FloatToStr((t2.tv_sec - t1.tv_sec)*1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000));

  Clock_GetTime(CLOCK_REALTIME, @t1);
	bmpColor.PixelFormat := pf24bit;
  bmpColor.SetSize(1001 - imgSzChange, 4000 - imgSzChange);
  Clock_GetTime(CLOCK_REALTIME, @t2);
	WriteLn('BmpColor Set Size Used Time:' +
  	FloatToStr((t2.tv_sec - t1.tv_sec)*1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000));
  imgSzChange := imgSzChange + 1;
end;

procedure TForm1.FormCreate(Sender:TObject);
begin
  bmpGray := TBitMap.Create;
  bmpGray.PixelFormat := pf8bit;
  bmpGray.SetSize(1255, 4000);

  bmpColor := TBitMap.Create;
  bmpColor.PixelFormat := pfDevice;
  bmpColor.SetSize(1255, 4000);
  WriteLn('BmpGray ImageSize:' + IntToStr(bmpGray.RawImage.DataSize));
  WriteLn('BmpColor ImageSize:' + IntToStr(bmpColor.RawImage.DataSize));
  imgSzChange := 0;
end;

procedure TForm1.Panel2Paint(Sender:TObject);
var
  t1, t2 : timespec;
  aBmpTmp : TBitMap;
begin
 // Clock_GetTime(CLOCK_REALTIME, @t1);
 // if bmpImgValue = Byte(200) then
 // 	bmpImgValue := Byte(100)
 // else
 // 	bmpImgValue := Byte(200);
 // aBmpTmp := bmpColor;
 // aBmpTmp.Transparent := True;
 // SetBitMapImg(aBmpTmp, bmpImgValue);
 // Panel2.Canvas.Draw(0, 0, aBmpTmp);
 // //application.ProcessMessages;
 // Sleep(1000);
 // Clock_GetTime(CLOCK_REALTIME, @t2);
	//WriteLn('Paint BmpColor Used Time:' +
 // 	FloatToStr((t2.tv_sec - t1.tv_sec)*1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000));

 // Clock_GetTime(CLOCK_REALTIME, @t1);
 // if bmpImgValue = Byte(200) then
 // 	bmpImgValue := Byte(100)
 // else
 // 	bmpImgValue := Byte(200);
 // aBmpTmp := bmpGray;
 // SetBitMapImg(aBmpTmp, bmpImgValue);
 // Panel2.Canvas.Draw(0, 0, aBmpTmp);
 // application.ProcessMessages;
 // Sleep(1000);
 // Clock_GetTime(CLOCK_REALTIME, @t2);
	//WriteLn('Paint bmpGray Used Time:' +
 // 	FloatToStr((t2.tv_sec - t1.tv_sec)*1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000));
end;

procedure TForm1.SetBitMapImg(aBmpTmp:TBitMap; imgValue:Byte);
var
  aRawImg:TRawImage;
begin
  aRawImg := aBmpTmp.RawImage;
	FillChar(aRawImg.Data^, aRawImg.DataSize, imgValue);
end;

procedure TForm1.CreateLazIntfImg;
var
  SrcIntfImg, TempIntfImg: TLazIntfImage;
  ImgHandle,ImgMaskHandle: HBitmap;
  FadeStep: Integer;
  px, py: Integer;
  CurColor: TFPColor;
  TempBitmap: TBitmap;
begin
  SrcIntfImg:=TLazIntfImage.Create(0,0);
  SrcIntfImg.LoadFromBitmap(bmpColor.Handle,bmpColor.MaskHandle);
  TempIntfImg:=TLazIntfImage.Create(0,0);
  TempIntfImg.LoadFromBitmap(bmpColor.Handle,bmpColor.MaskHandle);
  TempBitmap:=TBitmap.Create;
  for FadeStep:=1 to 32 do
  begin
    for py:=0 to SrcIntfImg.Height-1 do
    begin
      for px:=0 to SrcIntfImg.Width-1 do
      begin
        CurColor:=SrcIntfImg.Colors[px,py];
        CurColor.Red:=(CurColor.Red*FadeStep) shr 5;
        CurColor.Green:=(CurColor.Green*FadeStep) shr 5;
        CurColor.Blue:=(CurColor.Blue*FadeStep) shr 5;
        TempIntfImg.Colors[px,py]:=CurColor;
      end;
    end;
    TempIntfImg.CreateBitmaps(ImgHandle,ImgMaskHandle,false);
    TempBitmap.Handle:=ImgHandle;
    TempBitmap.MaskHandle:=ImgMaskHandle;
    Panel2.Canvas.Draw(0,0,TempBitmap);
  end;
  SrcIntfImg.Free;
  TempIntfImg.Free;
  TempBitmap.Free;
end;

end.

