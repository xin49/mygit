unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  //{$IFDEF UNIX}
  //cthreads, cmem,
  //{$ENDIF}
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  //canvas info
  GraphType,
  //clock_time
  linux, BaseUnix,
  FPImage, IntfGraphics, LCLType,
  //TBGRABitMap
  BGRABitmap, BGRABitmapTypes
  ;

type
  { TRefresh Canvas Thread }
  TRefreshThread = class(TThread)
  protected
    procedure Execute; override;
  public
    isStart:Boolean;
   constructor Create(CreateSuspended: Boolean;
                       const StackSize: SizeUInt = DefaultStackSize);
  end;
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
    Timer1:TTimer;
    procedure Button1Click(Sender:TObject);
    procedure Button2Click(Sender:TObject);
    procedure Button3Click(Sender:TObject);
    procedure Button4Click(Sender:TObject);
    procedure Button5Click(Sender:TObject);
    procedure Button6Click(Sender:TObject);
    procedure Button7Click(Sender:TObject);
    procedure Button8Click(Sender:TObject);
    procedure FormCreate(Sender:TObject);
    procedure Timer1Timer(Sender:TObject);
  private
    { private declarations }
  public
    bmpGray:TBitMap;
    bmpColor:TBitMap;
    bmpImgValue:Byte;
    imgSzChange:Integer;
    { public declarations }
    bmpColor1:TBitMap;
    bmpColor2:TBitMap;
    gBmpColorCur:TBitMap;
    gBGRABmpTmp:TBGRABitmap;
    flashThread:TThread;
    mainRefreshT : TRefreshThread;
    procedure CreateLazIntfImg;
    procedure SetBitMapImg(aBmpTmp:TBitMap; imgValue:Byte);
    procedure SetUIOnEvent;
    procedure PanelOnPaint(Sender: TObject);
  end;

  procedure LocalBmpToCanvas(aCanv:TCanvas);
  procedure GlobalBmpToCanvas(aCanv:TCanvas; aBmpTmp:TBitMap);
  procedure GlobalBmp2ExcToCanvas(aCanv:TCanvas;
      aBmpTmp1:TBitMap; aBmpTmp2:TBitMap; var aBmpTmpCur:TBitMap);
  procedure FillTBmp(aBmpTmp:TBitMap; aImgVal:Byte);inline;
  procedure BGRA2Canvas(aBGRABmp:TBGRABitmap; aCvTmp:TCanvas);
var
  Form1: TForm1;
  refreshThread : TRefreshThread;

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
	GlobalBmpToCanvas(Panel2.Canvas, bmpColor1);
end;

procedure TForm1.Button5Click(Sender:TObject);
begin
	//Panel2.rePaint;
  //mainRefreshT.Start;
//  while True do
//  begin
    GlobalBmp2ExcToCanvas(Panel2.Canvas, bmpColor1, bmpColor2, gBmpColorCur);
//    Sleep(1);
//  end;
end;

procedure TForm1.Button6Click(Sender:TObject);
begin
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
  bmpGray.SetSize(1025, 4000);

  bmpColor := TBitMap.Create;
  bmpColor.PixelFormat := pfDevice;
  bmpColor.SetSize(1025, 4000);
  WriteLn('BmpGray ImageSize:' + IntToStr(bmpGray.RawImage.DataSize));
  WriteLn('BmpColor ImageSize:' + IntToStr(bmpColor.RawImage.DataSize));
  imgSzChange := 0;

  bmpColor1 := TBitMap.Create;
  bmpColor1.PixelFormat := pfDevice;
  bmpColor1.SetSize(1025, 4000);
  bmpColor2 := TBitMap.Create;
  bmpColor2.PixelFormat := pfDevice;
  bmpColor2.SetSize(1025, 4000);
  gBmpColorCur := bmpColor1;
  gBGRABmpTmp := TBGRABitMap.Create(1025, 4000);

  mainRefreshT := TRefreshThread.Create(true);
  refreshThread := TRefreshThread.Create(true);

  SetUIOnEvent;

  //Timer1.Enabled := True;
end;

procedure TForm1.Timer1Timer(Sender:TObject);
begin
  Panel2.Refresh;
end;

procedure TForm1.SetBitMapImg(aBmpTmp:TBitMap; imgValue:Byte);
var
  aRawImg:TRawImage;
begin
  aRawImg := aBmpTmp.RawImage;
	FillChar(aRawImg.Data^, aRawImg.DataSize, imgValue);
end;

procedure TForm1.SetUIOnEvent;
begin
  //Panel2.OnPaint := @PanelOnPaint;
end;

procedure TForm1.PanelOnPaint(Sender: TObject);
begin
	GlobalBmp2ExcToCanvas(Panel2.Canvas, bmpColor1, bmpColor2, gBmpColorCur);
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

{ TRefreshThread }
procedure TRefreshThread.Execute;
var
  t1, t2 : timespec;
begin
  while not Terminated do
  begin  
    Clock_GetTime(CLOCK_REALTIME, @t1);

    Sleep(1);
    with Form1 do
    	GlobalBmp2ExcToCanvas(Panel2.Canvas, bmpColor1, bmpColor2, gBmpColorCur);

    Clock_GetTime(CLOCK_REALTIME, @t2);
	WriteLn('Execute Used Time:' +
  	    FloatToStr((t2.tv_sec - t1.tv_sec)*1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000));
  end;
end;

constructor TRefreshThread.Create(CreateSuspended: Boolean;
                       const StackSize: SizeUInt = DefaultStackSize);
begin
  inherited;
  isStart := False;
end;

//free function
procedure LocalBmpToCanvas(aCanv:TCanvas);
var
  aBmpTmp:TBitMap;
  t1, t2 : timespec;
begin
  Clock_GetTime(CLOCK_REALTIME, @t1);
  aBmpTmp := TBitMap.Create;
  aBmpTmp.PixelFormat := pf24bit;
  aBmpTmp.SetSize(1025, 4000);
  FillTBmp(aBmpTmp, Random(256));

  aCanv.Draw(0, 0, aBmpTmp);

  aBmpTmp.Free;

  Clock_GetTime(CLOCK_REALTIME, @t2);
  WriteLn('LocalBmpToCanvas Used Time:' + 
      FloatToStr((t2.tv_sec - t1.tv_sec)*1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000));
end;

procedure GlobalBmpToCanvas(aCanv:TCanvas; aBmpTmp:TBitMap);
var
  t1, t2 : timespec;
begin
  Clock_GetTime(CLOCK_REALTIME, @t1);

  aBmpTmp.BeginUpdate(False);
  FillTBmp(aBmpTmp, Random(256));
  aBmpTmp.EndUpdate(False);
  aCanv.Draw(0, 0, aBmpTmp);
  //application.ProcessMessages;//useless

  Clock_GetTime(CLOCK_REALTIME, @t2);
  WriteLn('GlobalBmpToCanvas Used Time:' + 
      FloatToStr((t2.tv_sec - t1.tv_sec)*1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000));
end;

procedure GlobalBmp2ExcToCanvas(aCanv:TCanvas; 
    aBmpTmp1:TBitMap; aBmpTmp2:TBitMap; var aBmpTmpCur:TBitMap);
var
  t1, t2 : timespec;
begin
  Clock_GetTime(CLOCK_REALTIME, @t1);

  if aBmpTmpCur = aBmpTmp1 then
    aBmpTmpCur := aBmpTmp2
  else
    aBmpTmpCur := aBmpTmp1;
  FillTBmp(aBmpTmpCur, Random(256));
  aCanv.Draw(0, 0, aBmpTmpCur);

  Clock_GetTime(CLOCK_REALTIME, @t2);
  WriteLn('GlobalBmp2ExcToCanvas Used Time:' +
    FloatToStr((t2.tv_sec - t1.tv_sec)*1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000));
end;

procedure FillTBmp(aBmpTmp:TBitMap; aImgVal:Byte);inline;
var
  aRawImgTmp:TRawImage;
begin
  aRawImgTmp := aBmpTmp.RawImage;
  FillChar(aRawImgTmp.Data^, aRawImgTmp.DataSize, aImgVal);
end;

procedure BGRA2Canvas(aBGRABmp:TBGRABitmap; aCvTmp:TCanvas);
var
  t1, t2 : timespec;
begin
  Clock_GetTime(CLOCK_REALTIME, @t1);

  FillChar(aBGRABmp.Data^, 10086, Random(255));
  aBGRABmp.InvalidateBitmap;

  Clock_GetTime(CLOCK_REALTIME, @t2);
  WriteLn('BGRA2Canvas Used Time:' +
    FloatToStr((t2.tv_sec - t1.tv_sec)*1000 + (t2.tv_nsec - t1.tv_nsec) / 1000000));
end;

end.

