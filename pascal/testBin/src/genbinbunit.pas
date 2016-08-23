unit genbinbunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, dynlibs;

type
  TCallMe = procedure;

  { TForm1 }

  TForm1 = class(TForm)
    Button1:TButton;
    procedure Button1Click(Sender:TObject);
    procedure FormCreate(Sender:TObject);
  private
    { private declarations }
    callIdx:Integer;
  public
    { public declarations }
  end;
var
  CallMe1, CallMe2:TCallMe;
  libHand1, libHand2:THandle;

	procedure LoadAllDLl;

var
  Form1: TForm1;

implementation
procedure LoadAllDLl;
begin
  libHand1 := LoadLibrary('/root/codes/mygit/pascal/testTComboBox/libmodule1.so');
  libHand2 := LoadLibrary('/root/codes/mygit/pascal/testTComboBox/libmodule2.so');
  Pointer(CallMe1) := GetProcedureAddress(libHand1, 'CallMe');
  Pointer(CallMe2) := GetProcedureAddress(libHand2, 'CallMe');
end;

procedure FreeAllDll;
begin
	FreeLibrary(libHand1);
	FreeLibrary(libHand2);
  CallMe1 := nil;
  CallMe2 := nil;
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender:TObject);
begin
  LoadAllDLl;
  callIdx:=2;
end;

procedure TForm1.Button1Click(Sender:TObject);
begin
  if callIdx = 1 then
  begin
    CallMe2;
    callIdx := 2;
  end
  else
  begin
    CallMe1;
    callIdx := 1;
  end;
end;

{$R *.lfm}

end.

