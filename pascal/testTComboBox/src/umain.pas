unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls
  , Unit1, Unit2
  ;

type

  { TFrmMain }

  TFrmMain = class(TForm)
    Button1:TButton;
    procedure Button1Click(Sender:TObject);
    procedure FormCreate(Sender:TObject);
  private
    { private declarations }
    fFrmIndex:Integer;
		procedure CreateUint(var argIdx:Integer);
  public
    { public declarations }
  end;

  procedure CallMe;export;

var
  frmMain: TFrmMain;
  frm1: TForm1;
  frm2: TForm2;

implementation

{$R *.lfm}

procedure CallMe;export;
begin
  frmMain.Button1Click(nil);
end;

{ TFrmMain }

procedure TFrmMain.CreateUint(var argIdx:Integer);
begin
  if argIdx = 1 then
  begin
    frm1.Free;
    frm2 := TForm2.Create(nil);
    frm2.Show;
    argIdx := 2;
  end
  else
  begin
    frm2.Free;
    frm1 := TForm1.Create(nil);
    frm1.Show;
    argIdx := 1;
  end;
end;

procedure TFrmMain.FormCreate(Sender:TObject);
begin
	frm1 := TForm1.Create(nil);
  fFrmIndex := 1;
  frm1.Hide;
end;

procedure TFrmMain.Button1Click(Sender:TObject);
begin
  CreateUint(fFrmIndex);
end;

end.

