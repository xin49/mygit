unit frmHaveShape;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons;

type

  { TForm1 }

  TForm1 = class(TForm)
    BitBtn1:TBitBtn;
    Panel1:TPanel;
    Shape1:TShape;
    procedure BitBtn1Click(Sender:TObject);
    procedure FormCreate(Sender:TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
	procedure CallMe;export;
var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender:TObject);
begin

end;

procedure TForm1.BitBtn1Click(Sender:TObject);
var
  x : Integer;
begin
 	Shape1.Brush.Color := clRed;
  x := Shape1.Canvas.TextWidth('Pass');
end;

procedure CallMe;export;
begin
  //Form1.Show;
  Form1.BitBtn1Click(Form1);
end;

end.

