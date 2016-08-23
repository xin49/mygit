program genbin;

{$mode objfpc}{$H+}
uses
  sysutils, dynlibs, Forms, Interfaces,
	genbinbunit;

begin
	Application.CreateForm(TForm1, form1);
  form1.Show;
end.

