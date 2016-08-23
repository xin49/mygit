unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, RxMDI, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls, Menus, ActnList, ExtCtrls;

type

  { TForm4 }

  TForm4 = class(TForm)
    actAbout:TAction;
    actAutoLoadingSettings:TAction;
    actChangeLanguage:TAction;
    actChangeToAdvMode:TAction;
    actChangeToChinese:TAction;
    actChangeToEnglish:TAction;
    actCloseProject:TAction;
    actCOMSettings:TAction;
    actDFVisionHelp:TAction;
    actExit:TAction;
    ActionListMDIMain:TActionList;
    actManual:TAction;
    actNewProject:TAction;
    actOpenProject:TAction;
    actSaveAsProject:TAction;
    actSaveProject:TAction;
    actServerConnSetting:TAction;
    MDIPanel:TRxMDIPanel;
    mditasks:TRxMDITasks;
    MenuItem1:TMenuItem;
    MenuItem10:TMenuItem;
    MenuItem11:TMenuItem;
    MenuItem12:TMenuItem;
    MenuItem2:TMenuItem;
    MenuItem3:TMenuItem;
    MenuItem4:TMenuItem;
    MenuItem5:TMenuItem;
    miLang1:TMenuItem;
    miLang2:TMenuItem;
    mmAbout:TMenuItem;
    mmAdvMode:TMenuItem;
    mmApplyForLicense:TMenuItem;
    mmAssocDfv:TMenuItem;
    mmCOMSettings:TMenuItem;
    mmExit:TMenuItem;
    mmFileItem:TMenuItem;
    mmFontAutoZoom:TMenuItem;
    mmHelpItem:TMenuItem;
    mmInfomations:TMenuItem;
    mmLanguageItem:TMenuItem;
    mmLicense:TMenuItem;
    mmLockMenu:TMenuItem;
    mmMain:TMainMenu;
    mmMenuOnlyOpen:TMenuItem;
    mmOpen:TMenuItem;
    mmOptions:TMenuItem;
    mmRmDfvAssoc:TMenuItem;
    mmServerConnSetting:TMenuItem;
    mmShowFunctions:TMenuItem;
    mmShowRunButton:TMenuItem;
    mmShowScript:TMenuItem;
    mmWindowAcqItem:TMenuItem;
    mmWindowItem:TMenuItem;
    mmWindowMainItem:TMenuItem;
    ScrollBar1:TScrollBar;
    stbMain:TStatusBar;
    tmrAutoLoadingSettingsFilename:TTimer;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.lfm}

end.

