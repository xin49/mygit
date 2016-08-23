unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1:TButton;
    ComboBox1:TComboBox;
    procedure Button1Click(Sender:TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

procedure CallMe;

var
  Form1: TForm1;

implementation

{$R *.lfm}

procedure CallMe;
begin
  form1 := TForm1.Create(nil);
  form1.Show;
end;

{ TForm1 }

procedure TForm1.Button1Click(Sender:TObject);
begin
  form1.Hide;
  form1.Free;
end;

end.

