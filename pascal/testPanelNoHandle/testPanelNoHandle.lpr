library testPanelNoHandle;

{$mode objfpc}{$H+}

uses
  Classes, frmHaveShape, forms, pl_rx, Interfaces, Unit1;

exports
  CallMe name 'CallMe';

begin
  Application.Initialize;
	Form1 := TForm1.Create(nil);
  //form2 := TForm2.Create(nil);
end.

