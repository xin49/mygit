library testPanelNoHandle;

{$mode objfpc}{$H+}

uses
  Classes, frmHaveShape, forms, Interfaces;

exports
  CallMe name 'CallMe';

begin
  Application.Initialize;
	Form1 := TForm1.Create(nil);
end.

