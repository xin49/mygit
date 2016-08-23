library module2;

{$mode objfpc}{$H+}

uses
  Classes, Forms, Interfaces,
  unit2
  { you can add units after this };

procedure CallMe;
begin
  form2 := TForm2.Create(nil);
  form2.Show;
end;

exports
	CallMe name 'CallMe';
begin
  Application.Initialize;
  //form2 := TForm2.Create(nil);
  //form2.ComboBox1.Items.Add('21');
  //form2.ComboBox1.Items.Add('22');
  //form2.ComboBox1.Items.Add('23');
  //form2.ComboBox1.Items.Add('24');
end.

