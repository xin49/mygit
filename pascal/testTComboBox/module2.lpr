library module2;

{$mode objfpc}{$H+}

uses
  Classes, unit2
  { you can add units after this };

procedure CallMe;
begin
  form2 := TForm2.Create(nil);
  form2.Show;
  form2.Free;
end;

exports
	CallMe name 'CallMe';
begin
end.

