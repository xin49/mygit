unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  TimeKeeper;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1:TButton;
    Panel1:TPanel;
    Panel2:TPanel;
    Timer1:TTimer;
    procedure Button1Click(Sender:TObject);
    procedure FormCreate(Sender:TObject);
    procedure Timer1Timer(Sender:TObject);
  private
    { private declarations }
  public
    t1 : Double;
    t2 : Double;
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Timer1Timer(Sender:TObject);
begin
  Timer1.Enabled := False;
  t1 := GetTime;
  WriteLn('Timer1Timer:', FloatToStr(t1 - t2));
  t2 := GetTime;
  sleep(1000);
  Timer1.Enabled := True;
end;

procedure TForm1.FormCreate(Sender:TObject);
begin
  Form1.Canvas.Font.Size := 50;
end;

procedure TForm1.Button1Click(Sender:TObject);
begin
  Timer1.Enabled := Not(Timer1.Enabled);
  WriteLn(IntToStr(Integer(Timer1.Interval)));
  Sleep(10);
  WriteLn(IntToStr(Integer(Timer1.Interval)));
end;

end.

