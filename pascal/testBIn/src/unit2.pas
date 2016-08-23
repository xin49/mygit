unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, Spin, ActnList,
  ExtDlgs, Menus, dynlibs, RxMDI;

type

  TCallMe = procedure;

  { TForm2 }

  TForm2 = class(TForm)
    actAbout:TAction;
    actAddHistogram:TAction;
    actAutoLoadingSettings:TAction;
    actCameraCapture:TAction;
    actChangeLanguage:TAction;
    actChangeToAdvMode:TAction;
    actChangeToChinese:TAction;
    actChangeToEnglish:TAction;
    actClearallimages:TAction;
    actCloseProject:TAction;
    actCOMSettings:TAction;
    actCopyFromBaseFrame:TAction;
    actDeleteAllButton:TAction;
    actDeleteButton:TAction;
    actDFVisionHelp:TAction;
    actExit:TAction;
    actExit1:TAction;
    actFirstImage:TAction;
    actFullspeedStart:TAction;
    actFullspeedStop:TAction;
    actImage100:TAction;
    actImageAutoFit:TAction;
    actImageAutoHeight:TAction;
    actImageAutoWidth:TAction;
    actImageZoomin:TAction;
    actImageZoomOut:TAction;
    ActionList1:TActionList;
    ActionListMDIMain:TActionList;
    actLastImage:TAction;
    actlstMainState:TActionList;
    actManual:TAction;
    actNewProject:TAction;
    actNextImage:TAction;
    actOpenImage:TAction;
    actOpenProject:TAction;
    actPerformance:TAction;
    actPluginStop:TAction;
    actPreviousImage:TAction;
    actRefreshImage:TAction;
    actRunLoop:TAction;
    actRunLoopAndSaveImage:TAction;
    actRunOnce:TAction;
    actRunStop:TAction;
    actRunStop_Frame:TAction;
    actRunToolButton:TAction;
    actSaveAsProject:TAction;
    actSaveImage:TAction;
    actSaveProject:TAction;
    actScriptEdit:TAction;
    actScriptNext:TAction;
    actScriptPrevious:TAction;
    actServerConnSetting:TAction;
    actSetUiControlsCommonStateWhenReady:TAction;
    actSetUiControlsCommonStateWhenRunning:TAction;
    actSetUiControlsState:TAction;
    actSetUiControlsStateWhenNotReady:TAction;
    actViewLog:TAction;
    act_SetupMode0_SetUiControlsStateWhenReady:TAction;
    act_SetupMode0_SetUiControlsStateWhenRunning:TAction;
    act_SetupMode1_SetUiControlsStateWhenReady:TAction;
    act_SetupMode1_SetUiControlsStateWhenRunning:TAction;
    act_SetupMode2_SetUiControlsStateWhenReady:TAction;
    act_SetupMode2_SetUiControlsStateWhenRunning:TAction;
    btnFullSpeedSleep:TButton;
    btnFullSpeedSleepTimes:TButton;
    btnFullSpeedStart:TBitBtn;
    btnFullSpeedStop:TBitBtn;
    btnTestFullSpeed:TButton;
    Button1:TButton;
    dlgOpenImage:TOpenPictureDialog;
    dlgOpenProject:TOpenDialog;
    dlgSaveImage:TSavePictureDialog;
    dlgSaveProject:TSaveDialog;
    edtFullSpeedSleep:TSpinEdit;
    edtFullSpeedSleepTimes:TSpinEdit;
    GroupBox1:TGroupBox;
    imgBase:TImage;
    imglstFuncs:TImageList;
    imglstToolbar:TImageList;
    lbImgInfo:TLabel;
    lbLydgOriginal:TLabel;
    mditasks:TRxMDITasks;
    Memo1:TMemo;
    MenuItem1:TMenuItem;
    MenuItem10:TMenuItem;
    MenuItem11:TMenuItem;
    MenuItem12:TMenuItem;
    MenuItem2:TMenuItem;
    MenuItem3:TMenuItem;
    MenuItem4:TMenuItem;
    MenuItem5:TMenuItem;
    MenuItem6:TMenuItem;
    MenuItem7:TMenuItem;
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
    Panel1:TPanel;
    MDIPanel: TRxMDIPanel;
    Panel2:TPanel;
    Panel3:TPanel;
    Panel4:TPanel;
    Panel5:TPanel;
    Panel6:TPanel;
    Panel7:TPanel;
    Panel8:TPanel;
    pcPlugin:TPageControl;
    pmDiagramPanel:TPopupMenu;
    pnl0:TPanel;
    pnlFullSpeed:TPanel;
    pnlImages:TPanel;
    pnlImgSelect:TPanel;
    pnlImgThumbs:TPanel;
    pnlleft:TPanel;
    pnlMainSplitter:TPanel;
    pnlOthers:TPanel;
    pnlRBottom:TPanel;
    pnlRight:TPanel;
    pnlRTop:TPanel;
    pnlRTopInternal:TPanel;
    pnlThmnailPar:TPanel;
    pnltoolbarsplitter:TPanel;
    sbDiagram:TScrollBox;
    ScrollBar1:TScrollBar;
    SpeedButton1:TSpeedButton;
    SpeedButton2:TSpeedButton;
    SpeedButton3:TSpeedButton;
    SpeedButton4:TSpeedButton;
    SpeedButton5:TSpeedButton;
    Splitter1:TSplitter;
    Splitter2:TSplitter;
    Splitter3:TSplitter;
    Splitter4:TSplitter;
    stbMain:TStatusBar;
    tbCloseProj:TToolButton;
    tbDesignTools:TToolBar;
    tbExit:TToolButton;
    tbImageList:TTrackBar;
    tbMain:TToolBar;
    tbMemoryStatus:TToolButton;
    tbNew:TToolButton;
    tbOpen:TToolButton;
    tbRunLoopAndSaveImage:TToolButton;
    tbSave:TToolButton;
    tbSaveas:TToolButton;
    tbSaveSinglePic:TToolButton;
    tbSelect:TToolButton;
    tmAsn:TTimer;
    tmrAutoLoadingSettingsFilename:TTimer;
    ToolBar1:TToolBar;
    ToolBar2:TToolBar;
    ToolButton1:TToolButton;
    ToolButton10:TToolButton;
    ToolButton11:TToolButton;
    ToolButton12:TToolButton;
    ToolButton13:TToolButton;
    ToolButton14:TToolButton;
    ToolButton16:TToolButton;
    ToolButton19:TToolButton;
    ToolButton2:TToolButton;
    ToolButton20:TToolButton;
    ToolButton21:TToolButton;
    ToolButton22:TToolButton;
    ToolButton23:TToolButton;
    ToolButton24:TToolButton;
    ToolButton29:TToolButton;
    ToolButton30:TToolButton;
    ToolButton4:TToolButton;
    ToolButton40:TToolButton;
    ToolButton41:TToolButton;
    ToolButton42:TToolButton;
    ToolButton6:TToolButton;
    ToolButton7:TToolButton;
    ToolButton8:TToolButton;
    ToolButton9:TToolButton;
    tsBinary:TTabSheet;
    tsColor:TTabSheet;
    tsGrayscale:TTabSheet;
    tsImage:TTabSheet;
    tsMachineVision:TTabSheet;
    procedure Button1Click(Sender:TObject);
    procedure FormCreate(Sender:TObject);
    procedure FormShow(Sender:TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;
  libHandle : THandle;
	CallMe : TCallMe;

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.FormCreate(Sender:TObject);
begin
	libHandle := LoadLibrary('../testPanelNoHandle/libtestpanelnohandle.so');
	Pointer(CallMe) := GetProcedureAddress(libHandle, 'CallMe');
end;

procedure TForm2.Button1Click(Sender:TObject);
begin
	CallMe;
end;

procedure TForm2.FormShow(Sender:TObject);
begin

end;

end.

