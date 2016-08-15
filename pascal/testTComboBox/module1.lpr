library module1;

{$mode objfpc}{$H+}

uses
  Classes, unit1
  { you can add units after this };
procedure CallMe;
begin
  form1 := TForm1.Create(nil);
  form1.Show;
  form1.Free;
end;

exports
	CallMe name 'CallMe';

begin
end.

