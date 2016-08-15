library testTComboBox;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  uMain,
  Forms, commonFunction
  { you can add units after this };
exports
	CallMe name 'CallMe';
{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TFrmMain, frmMain);
  frmMain.Hide;
  Application.Run;
end.

