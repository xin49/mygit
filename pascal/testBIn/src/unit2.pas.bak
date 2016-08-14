unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, dynlibs;

type

  TCallMe = procedure;

  { TForm2 }

  TForm2 = class(TForm)
    Button1:TButton;
    Panel1:TPanel;
    procedure Button1Click(Sender:TObject);
    procedure FormCreate(Sender:TObject);
    procedure FormShow(Sender:TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;
  libHandle : THandle;
	CallMe : TCallMe;

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.FormCreate(Sender:TObject);
begin
	libHandle := LoadLibrary('/libtestpanelnohandle.so');
	Pointer(CallMe) := GetProcedureAddress(libHandle, 'CallMe');
end;

procedure TForm2.Button1Click(Sender:TObject);
begin
	CallMe;
end;

procedure TForm2.FormShow(Sender:TObject);
begin

end;

end.

