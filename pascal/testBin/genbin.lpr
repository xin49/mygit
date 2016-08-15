program genbin;

uses
  sysutils, dynlibs,
	commonfunction;

type
	TCallMe = procedure;

var
  CallMe1, CallMe2:TCallMe;
  libHand1, libHand2:THandle;

procedure LoadAllDLl;
begin
	libHand1 := LoadLibrary('/home/ning/codes/pascal/testTComboBox/libmodule1.so');
	libHand2 := LoadLibrary('/home/ning/codes/pascal/testTComboBox/libmodule2.so');
  Pointer(CallMe1) := GetProcedureAddress(libHand1, 'CallMe');
  Pointer(CallMe2) := GetProcedureAddress(libHand1, 'CallMe');
end;

begin
  LoadAllDLl;
  CallMe1;
  CallMe2;
  CallMe1;
  CallMe2;
  CallMe1;
  CallMe2;
end.

