program drawBitMap2Canvas;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Unit1, Unit2
  { you can add units after this };

{$R *.res}

begin
  Application.Initialize;
  Form1 := TForm1.Create(nil);
  Form1.Show;
  Application.Run;
  Form1.Free;
//  RequireDerivedFormResource := True;
//  Application.Initialize;
//  Application.CreateForm(TForm1, Form1);
//  Application.CreateForm(TForm2, Form2);
//  Application.Run;
end.

