library module1;

{$mode objfpc}{$H+}

uses
  Classes, Forms, Interfaces,
  unit1
  { you can add units after this };

exports
	CallMe name 'CallMe';

begin
  Application.Initialize;
  //form1 := TForm1.Create(nil);
  //form1.ComboBox1.Items.Add('11');
  //form1.ComboBox1.Items.Add('12');
  //form1.ComboBox1.Items.Add('13');
  //form1.ComboBox1.Items.Add('14');
end.
