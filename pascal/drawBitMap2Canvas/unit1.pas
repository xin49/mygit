unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Panel1:TPanel;
    Panel2:TPanel;
    procedure FormCreate(Sender:TObject);
    procedure Panel2Paint(Sender:TObject);
  private
    { private declarations }
  public
    aBmp:TBitMap;
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
  widthstep, imgSize:Integer;
  pTmp:PByte;
  pImgData:PByte;
begin
  aBmp := TBitMap.Create;
  //aBmp.LoadFromFile('/root/图片/spheres.bmp');
  aBmp.PixelFormat := pf1bit;
  aBmp.SetSize(125, 125);
  widthstep := aBmp.RawImage.Description.BytesPerLine;
  pImgData := aBmp.RawImage.Data;
  imgSize := aBmp.RawImage.DataSize;
  //set TBitMap content
  //for i:=0 to 64-1 do
  //begin
  //  Pointer(pTmp):=(aBmp.ScanLine[i]);
  //  FillChar(pTmp^, 125, char(255));
  //end;
  for i:=0 to imgSize div 2 -1 do
  begin
    pImgData[i] := Byte(255);
  end;
end;

procedure TForm1.Panel2Paint(Sender:TObject);
begin
  Panel2.Canvas.Draw(0, 0, aBmp);
end;

end.

