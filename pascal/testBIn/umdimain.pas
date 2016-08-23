unit umdimain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LCLType, RxMDI, Forms, Controls,
  Graphics, Dialogs, Menus, ComCtrls, ActnList, ExtCtrls, StdCtrls,
  {uDfLicense,} IniFiles, LMessages, Messages, df_plugininterfaces,
  UfrmServerConnSetting, dfvision_global_definition,
  {$ifdef windows}
  Windows,
  HtmlHelp,
  {$else}
  df_util_sys,
  {$endif}
  df_asc_h
  ;

type

  { TfrmMDIMain }

  TfrmMDIMain = class(TForm)
    actChangeToEnglish: TAction;
    actChangeToChinese: TAction;
    actCloseProject: TAction;
    actExit: TAction;
    actAbout: TAction;
    actCOMSettings: TAction;
    actAutoLoadingSettings: TAction;
    actChangeLanguage: TAction;
    actChangeToAdvMode: TAction;
    actDFVisionHelp:TAction;
    actManual:TAction;
    actServerConnSetting:TAction;
    actSaveAsProject: TAction;
    actNewProject: TAction;
    actSaveProject: TAction;
    actOpenProject: TAction;
    ActionListMDIMain: TActionList;
    MDIPanel: TRxMDIPanel;
    mditasks: TRxMDITasks;
    MenuItem1: TMenuItem;
    MenuItem4:TMenuItem;
    MenuItem5:TMenuItem;
    mmServerConnSetting:TMenuItem;
    mmLicense: TMenuItem;
    mmApplyForLicense: TMenuItem;
    mmRmDfvAssoc: TMenuItem;
    mmAssocDfv: TMenuItem;
    mmAdvMode: TMenuItem;
    mmInfomations: TMenuItem;
    mmFontAutoZoom: TMenuItem;
    mmShowRunButton: TMenuItem;
    mmMenuOnlyOpen: TMenuItem;
    mmShowScript: TMenuItem;
    mmShowFunctions: TMenuItem;
    mmLockMenu: TMenuItem;
    MenuItem3: TMenuItem;
    mmCOMSettings: TMenuItem;
    mmOptions: TMenuItem;
    mmFileItem: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem2: TMenuItem;
    mmWindowItem: TMenuItem;
    mmWindowAcqItem: TMenuItem;
    mmWindowMainItem: TMenuItem;
    mmHelpItem: TMenuItem;
    mmLanguageItem: TMenuItem;
    miLang2: TMenuItem;
    miLang1: TMenuItem;
    mmAbout: TMenuItem;
    mmExit: TMenuItem;
    mmMain: TMainMenu;
    mmOpen: TMenuItem;
    ScrollBar1: TScrollBar;
    stbMain: TStatusBar;
    tmrAutoLoadingSettingsFilename: TTimer;
    procedure actAboutExecute(Sender:TObject);
    procedure actApplyForLicenseExecute(Sender:TObject);
    procedure actChangeToAdvModeExecute(Sender: TObject);
    procedure actAutoLoadingSettingsExecute(Sender: TObject);
    procedure actChangeLanguageExecute(Sender: TObject);
    procedure actChangeLanguageUpdate(Sender: TObject);
    procedure actChangeToChineseExecute(Sender: TObject);
    procedure actChangeToEnglishExecute(Sender: TObject);
    procedure actCloseProjectExecute(Sender: TObject);
    procedure actCOMSettingsExecute(Sender: TObject);
    procedure actDFVisionHelpExecute(Sender:TObject);
    procedure actExitExecute(Sender:TObject);
    procedure actManualExecute(Sender:TObject);
    procedure actNewProjectExecute(Sender: TObject);
    procedure actOpenProjectExecute(Sender: TObject);
    procedure actOpenProjectUpdate(Sender: TObject);
    procedure actSaveAsProjectExecute(Sender: TObject);
    procedure actSaveProjectExecute(Sender: TObject);
    procedure actSaveProjectUpdate(Sender: TObject);
    procedure actServerConnSettingExecute(Sender:TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem12Click(Sender:TObject);
    procedure mmAdvModeClick(Sender: TObject);
    procedure mmApplyForLicenseClick(Sender:TObject);
    procedure mmAssocDfvClick(Sender: TObject);
    procedure mmFontAutoZoomClick(Sender: TObject);
    procedure mmInfomationsClick(Sender: TObject);
    procedure mmLockMenuClick(Sender: TObject);
    procedure mmMenuOnlyOpenClick(Sender: TObject);
    procedure mmRmDfvAssocClick(Sender: TObject);
    procedure mmShowFunctionsClick(Sender: TObject);
    procedure mmShowRunButtonClick(Sender: TObject);
    procedure mmShowScriptClick(Sender: TObject);
    procedure mmWindowItemClick(Sender: TObject);
    procedure mmWindowAcqItemClick(Sender: TObject);
    procedure mmWindowMainItemClick(Sender: TObject);
    procedure tmrAutoLoadingSettingsFilenameTimer(Sender: TObject);
  private
    { private declarations }

  public
    { public declarations }
    procedure ButtonAcquireClick(Sender: TObject);
    procedure ButtonMainClick(Sender: TObject);
    procedure CheckSetupMode();

    //禁止调大小, 禁止移动, 禁止最小化, 禁止还原
    procedure WMPosChange(var Message: TLMWindowPosChanging);message LM_WINDOWPOSCHANGING;
  end;

var
  frmMDIMain: TfrmMDIMain;
  g_strMdiMainCopyright:string='asdf';//'Shanghai Dragonfly Vision Technology Co., Ltd.    ';


implementation

{$R *.lfm}

uses
  umain,uLYDiagramControls, ushowinfopanel, df_loadlanguage, usplash, uinitialallplugin, df_commonsettings,uautoloadsettings,
  ufullspeedrunbutton,
  {$ifdef windows}
  ucomsettings_spcomm,
  {$else}
  ucommsetting,
  {$endif}
  df_debuginterface;


{ TfrmMDIMain }

procedure TfrmMDIMain.CheckSetupMode();
begin

  DF_CheckAsn(@g_asnArg);//DF_SetupMode := DF_CheckAsn(@g_asnArg);

  //if(DF_SetupMode < asnapiRetVal_SuccessBase)then
	stbMain.Panels[0].Text := AnsiToUtf8(GetAsnStateString(g_asnArg.retVal) + ' - ' + g_mdiMainCaptionUserInfo);
end;

procedure TfrmMDIMain.ButtonAcquireClick(Sender: TObject);
begin

end;

procedure TfrmMDIMain.ButtonMainClick(Sender: TObject);
begin
  //只要有一个界面不存在，都退出
  if (not isNeedAcqUI)or(not isNeedMainUI) then
    exit;

  if frmMain.isRunLoopStart then
  begin
    frmMain.SetRunLoopStart(false);
    exit;
  end;
  //if frmAcquireImages.actDisconnectAll.Enabled then   //close all camera;
  //begin
  //  {
  //  if Application.MessageBox('Agreed to close all cameras?', 'Message',
  //    MB_ICONQUESTION + MB_YESNO) = idYes then
  //    frmAcquireImages.actDisconnectAllExecute(nil);  }
  //  Application.MessageBox('Close all cameras!', 'Message',MB_ICONQUESTION + MB_OK);
  //  frmAcquireImages.CloseAllCamera;
  //  frmAcquireImages.actDisconnectAllExecute(nil);
  //end;
end;

procedure TfrmMDIMain.mmWindowItemClick(Sender: TObject);
begin

end;

procedure TfrmMDIMain.FormShow(Sender: TObject);
var
  i: integer;
begin
  WriteLog('MdiMain', 'FormShow, begin');
  left := 0;
  top  := 0;
  width := screen.Width-15;
  height := screen.Height-76;//GetSystemTaskBarHeight;


  WriteLog('MdiMain', 'FormShow, 1');
  //if isNeedAcqUI then
  //  MDIPanel.ChildWindowsCreate(frmAcquireImages, TfrmAcquireImages);

  WriteLog('MdiMain', 'FormShow, 2');
  if isNeedMainUI then
    MDIPanel.ChildWindowsCreate(frmMain, TfrmMain);


  WriteLog('MdiMain', 'FormShow, 3');
  //只要有一个界面不存在,不显示MDITasks
  if (not isNeedAcqUI)or(not isNeedMainUI) then
  begin
    mditasks.Visible:=false;
    //这句一定要放 ChildWindowsCreate 后面，不然 visible的值会被改
  end;



  frmSplash.lblLoading.Caption := 'Loading completed!';
  WriteLog('MdiMain', 'FormShow, 4');
  application.ProcessMessages;
  WriteLog('MdiMain', 'FormShow, 5');
  for i := 0 to mditasks.Controlcount - 1 do
  begin
    if mditasks.Controls[i] is TRxMDIButton then
    begin
      if TRxMDIButton(mditasks.Controls[i]).NavForm is TfrmMain then
      begin
        TRxMDIButton(mditasks.Controls[i]).OnClick := @ButtonMainClick;
      end
      {else if TRxMDIButton(mditasks.Controls[i]).NavForm is TfrmAcquireImages then
      begin
        TRxMDIButton(mditasks.Controls[i]).OnClick := @ButtonMainClick; //@ButtonAcquireClick;
      en};
    end;
  end;
  WriteLog('MdiMain', 'FormShow, 6');
  frmSplash.hide;
  WriteLog('MdiMain', 'FormShow, 7');

  frmAutoloadSettings.LoadAllOptionsSettingValuesFromIni();
  WriteLog('MdiMain', 'FormShow, 8');
  mmLockMenu.Checked:= isStatusSetting_LockChecked;
  mmShowFunctions.Checked:= isStatusSetting_FunctionsChecked;
  mmShowScript.Checked:= isStatusSetting_ScriptChecked;
  mmMenuOnlyOpen.Checked:= isStatusSetting_Toolbar_OnlyOpen;
  //if mmShowRunButton.Visible then
  mmShowRunButton.Checked := isStatusSetting_RunButtonChecked;
  mmAdvMode.Checked := isStatusSetting_advModeChecked;
  mmInfomations.Checked := isStatusSetting_infomationsChecked;
  mmFontAutoZoom.Checked := isStatusSetting_FontAutoZoom;
  WriteLog('MdiMain', 'FormShow, 9');
  mmMenuOnlyOpenClick(nil);
  WriteLog('MdiMain', 'FormShow, 10');
  mmShowFunctionsClick(nil);
  WriteLog('MdiMain', 'FormShow, 11');
  mmShowScriptClick(nil);
  WriteLog('MdiMain', 'FormShow, 12');
  mmLockMenuClick(nil);
  WriteLog('MdiMain', 'FormShow, 13');
  mmAdvModeClick(nil);
  WriteLog('MdiMain', 'FormShow, 14');
  mmInfomationsClick(nil);
  WriteLog('MdiMain', 'FormShow, 15');
  //if mmShowRunButton.Visible then
  mmShowRunButtonClick(nil);
  WriteLog('MdiMain', 'FormShow, 16');

  //if(isStatusSetting_OpenProjectFromAssocFile = True)then
  //begin
  //  //文件名在dfvision入口就被改好了
  // 	tmrAutoLoadingSettingsFilename.Enabled:=true;
  //end
  //else
  //begin
  //  //1秒后自动加载工程
  //  if isStatusSetting_AutoLoadingSettings then//options->Serial Port Settings  [AUTOLOAD] AUTOLOADING=1 ;  1=checked;  0=unchecked
  //  begin
      tmrAutoLoadingSettingsFilename.Enabled:=true;
  //  end;
  //end;
  WriteLog('MdiMain', 'FormShow, 17');

  //从umain的formshow改到这里，因为 umain formshow时，还没有 frmAutoloadSettings.LoadAllOptionsSettingValuesFromIni();   isStatusSetting_FontAutoZoom这个值永远是false
  if isStatusSetting_FontAutoZoom then       //isStatusSetting_FontAutoZoom=true --不自动缩放
  begin
    umain.imgNew.isBarcodevalue_NormalZoomFont := false;   //条码内容打印得一样大，不考虑zoom,缩放最小也是普通大小
    umain.imgNew.isOCRvalue_NormalZoomFont := false;       //OCR内容打印得一样大，不考虑zoom,缩放最小也是普通大小
    umain.imgNew.is2dcodevalue_NormalZoomFont := false;       //OCR内容打印得一样大，不考虑zoom,缩放最小也是普通大小
  end
  else
  begin
    umain.imgNew.isBarcodevalue_NormalZoomFont := true;    //字体和图像缩放一起自动缩放
    umain.imgNew.isOCRvalue_NormalZoomFont := true;        //字体和图像缩放一起自动缩放
    umain.imgNew.is2dcodevalue_NormalZoomFont := true;        //字体和图像缩放一起自动缩放
  end;
  WriteLog('MdiMain', 'FormShow, 18');
  //如果isStatusSetting_COMAUTO=true , 自动启动com口
  if isStatusSetting_IDCOM_AUTO then
  begin
  	WriteLog('MdiMain', 'FormShow, Open Com Port');
    frmCOMSettings.actCOMPortOpenExecute(nil);
  end;
  WriteLog('MdiMain', 'FormShow, 19');
  //如果isStatusSetting_COMAUTOSEND=true,自动发送COM消息
  if isStatusSetting_CONTROLCOM_AUTOSEND then
  begin
  	WriteLog('MdiMain', 'FormShow, Com Port, Send Val');
    frmCOMSettings.SendAutoSendValues;
  end;
  WriteLog('MdiMain', 'FormShow, end');

end;

procedure TfrmMDIMain.MenuItem12Click(Sender:TObject);
begin
end;


procedure TfrmMDIMain.mmAdvModeClick(Sender: TObject);
begin
  if mmAdvMode.Checked then
  begin
    frmMain.ToolButton6.Show;
    frmMain.tbRunLoopAndSaveImage.Show;
  end
  else
  begin
  	//?>	20141226 隐藏某些按钮 begin
    //ToolButton13.Hide;//->
    frmMain.ToolButton6.Hide;//oo>
  	//ToolButton7.Hide;//口
    frmMain.tbRunLoopAndSaveImage.Hide;
    //ToolButton41.Hide;//x
    //ToolButton42.Hide;//X

    //		20141226 隐藏某些按钮 end
  end;
	isStatusSetting_advModeChecked := mmAdvMode.Checked;
end;

procedure TfrmMDIMain.mmApplyForLicenseClick(Sender:TObject);
var
  str:string;
begin
 // WriteLog('MdiMain', 'Create TIniFile, DFSN.ini, begin');
	//with TIniFile.Create(ExtractFilePath(ParamStr(0))+'DFSN.ini') do
 // begin
 //  	str := ReadString('DFLICENSE', 'DFLICENSECODE', '');
 //   if((Length(str) = 20) and (DF_SetupMode>=0))then
 //   begin
 //     frmDfLicense.edtLicense.Text := str[1..5]+'-'+str[6..10]+'-'+str[11..15]+'-'+str[16..20];
 //   end;
 //   Free;
 // end;
	WriteLog('MdiMain', 'Show License Modal');
  frmDfLicense.ShowModal;
	WriteLog('MdiMain', 'Hide License Modal');
end;

procedure TfrmMDIMain.mmAssocDfvClick(Sender: TObject);
begin
  AssociateFileType(PChar('dfv'), PChar('Dfvision Project File'), PChar(ParamStr(0)), PChar(DFVISION_GLOBAL_CONF_PATH+'Dfv.ico'));
end;

procedure TfrmMDIMain.mmLockMenuClick(Sender: TObject);
begin
  if mmLockMenu.Checked then
  begin
    mmShowFunctions.Checked:=false;
    mmShowScript.Checked:=false;
    mmMenuOnlyOpen.Checked:=false;
    /////////
    mmShowFunctions.Enabled:=false;
    mmShowScript.Enabled:=false;
    mmMenuOnlyOpen.Enabled:=false;
  end
  else
  begin
    mmShowFunctions.Checked:=true;
    mmShowScript.Checked:=true;
    mmMenuOnlyOpen.Checked:=true;
    /////////
    mmShowFunctions.Enabled:=true;
    mmShowScript.Enabled:=true;
    mmMenuOnlyOpen.Enabled:=true;
  end;
  isStatusSetting_LockChecked := mmLockMenu.Checked;

  mmShowFunctionsClick(nil);
  mmShowScriptClick(nil);
  mmMenuOnlyOpenClick(nil);

  umain.frmMain.actImageAutoFitExecute(nil);

end;

procedure TfrmMDIMain.mmMenuOnlyOpenClick(Sender: TObject);
begin
  if mmMenuOnlyOpen.Checked then
  begin

    actNewProject.Visible:=true;
    //actOpenProject.Visible:=true;
    actSaveProject.Visible:=true;
    actSaveasProject.Visible:=true;
    actCloseProject.Visible:=true;
    frmmain.pnltoolbarsplitter.visible := true;
    {
    frmmain.tbNew.Visible := true;
    frmmain.tbOpen.Visible:= true;
    frmmain.tbSave.Visible:= true;
    frmmain.tbSaveas.Visible:= true;
    frmmain.tbcloseproj.Visible :=true;
    frmmain.pnltoolbarsplitter.visible := true;  }
    if isNeedShowMemoryStatus then
    begin
      frmmain.tbSaveSinglePic.Visible:= true;
      //frmmain.tbMemoryStatus.Visible := true;
    end;


  end
  else
  begin
    if isNeedShowMemoryStatus then
    begin
      //frmmain.tbMemoryStatus.Visible := false;
      frmmain.tbSaveSinglePic.Visible:= false;
    end;
    frmmain.pnltoolbarsplitter.visible := false;
    actCloseProject.Visible:=false;
    actSaveasProject.Visible:=false;
    actSaveProject.Visible:=false;
    //actOpenProject.Visible:=false;
    actNewProject.Visible:=false;
    {
    frmmain.pnltoolbarsplitter.Visible:=false;
    frmmain.tbCloseProj.Visible:=false;
    frmmain.tbSaveas.Visible:= false;
    frmmain.tbSave.Visible:= false;
    frmmain.tbNew.Visible := false;  }

  end;
  isStatusSetting_Toolbar_OnlyOpen := mmShowFunctions.Checked;
end;

procedure TfrmMDIMain.mmRmDfvAssocClick(Sender: TObject);
begin
  RemoveAssociatedFileType(PChar('dfv'), PChar(ParamStr(0)));
end;

procedure TfrmMDIMain.mmShowFunctionsClick(Sender: TObject);
begin
  if mmShowFunctions.Checked then
  begin
    frmmain.pnlLeft.Visible:= true;
    frmmain.pnlMainSplitter.Width:= 5;
  end
  else
  begin
    frmmain.pnlLeft.Visible:= false;
    frmmain.pnlMainSplitter.Width:= 0;
  end;
  isStatusSetting_FunctionsChecked := mmShowFunctions.Checked;
end;


procedure TfrmMDIMain.mmShowScriptClick(Sender: TObject);
begin
  if mmShowScript.Checked then
  begin
    frmmain.pnlRBottom.Visible:= true;
    mmShowRunButton.Checked:=false;
   // if mmShowRunButton.Visible then
    mmShowRunButtonClick(nil);
  end
  else
  begin
    frmmain.pnlRBottom.Visible:= false;
    mmShowRunButton.Checked:=true;
   // if mmShowRunButton.Visible then
    mmShowRunButtonClick(nil);
  end;
  isStatusSetting_ScriptChecked := mmShowScript.Checked;

end;


procedure TfrmMDIMain.mmShowRunButtonClick(Sender: TObject);
begin
  if mmShowRunButton.Checked then
  begin
    frmFullSpeedRunButton.Show;
  end
  else
  begin
    frmFullSpeedRunButton.Hide;
  end;
  isStatusSetting_RunButtonChecked := mmShowRunButton.Checked;
end;

procedure TfrmMDIMain.mmFontAutoZoomClick(Sender: TObject);
begin
{  if mmFontAutoZoom.Checked then
  begin
    umain.imgNew.isBarcodevalue_NormalZoomFont := false;
    umain.imgNew.isOCRvalue_NormalZoomFont := false;
  end
  else
  begin
    umain.imgNew.isBarcodevalue_NormalZoomFont := true; //条码内容打印得一样大，不考虑zoom,缩放最小也是普通大小
    umain.imgNew.isOCRvalue_NormalZoomFont := true;     //OCR内容打印得一样大，不考虑zoom,缩放最小也是普通大小
  end;       }
  isStatusSetting_FontAutoZoom := mmFontAutoZoom.Checked;

  if isStatusSetting_FontAutoZoom then       //isStatusSetting_FontAutoZoom=true --不自动缩放
  begin
    umain.imgNew.isBarcodevalue_NormalZoomFont := false;   //条码内容打印得一样大，不考虑zoom,缩放最小也是普通大小
    umain.imgNew.isOCRvalue_NormalZoomFont := false;       //OCR内容打印得一样大，不考虑zoom,缩放最小也是普通大小
    umain.imgNew.is2DCodevalue_NormalZoomFont := false;    //2D code内容打印得一样大，不考虑zoom,缩放最小也是普通大小
  end
  else
  begin
    umain.imgNew.isBarcodevalue_NormalZoomFont := true;    //字体和图像缩放一起自动缩放
    umain.imgNew.isOCRvalue_NormalZoomFont := true;        //字体和图像缩放一起自动缩放
    umain.imgNew.is2DCodevalue_NormalZoomFont := true;    //字体和图像缩放一起自动缩放
  end;
  umain.imgNew.Paint;
end;

procedure TfrmMDIMain.mmInfomationsClick(Sender: TObject);
begin
  if mmInfomations.Checked then
  begin
    umain.frmMain.pnlOthers.Show;

  	//?>主界面右侧Thumbnail图片显示 begin
    //pnlThumbnail.Painting:=True;
	  //?>主界面右侧Thumbnail图片显示 end
  end
  else
  begin
    umain.frmMain.pnlOthers.Hide;
  	//?>主界面右侧Thumbnail图片显示 begin
    //pnlThumbnail.Painting:=False;
	  //?>主界面右侧Thumbnail图片显示 end
  end;
  isStatusSetting_infomationsChecked := mmInfomations.Checked;
end;


procedure TfrmMDIMain.FormDestroy(Sender: TObject);
begin
   {//LY20140701 从mdi.formclose改到mdi.formdestroy里
  FinalAllCameraInterfaces;      //在TfrmSplash.FormShow 时 InitialAllCameraInterfaces
  FinalImageShowInterfaces;      //在TfrmSplash.FormShow 时 InitialImageShowInterfaces }

end;

procedure TfrmMDIMain.WMPosChange(var Message: TLMWindowPosChanging);
begin
  if(umain.imgnew <> nil)then
  begin
    if(umain.imgnew.EnabledUserOperation = False)then
    begin
      with Message.WindowPos^ do
      begin
      	Flags := Flags or SWP_NOMOVE or SWP_NOSIZE;//禁移动, 禁调大小
    		if(Flags = 131)or(Flags = 151)then//用打印调试跟出来的, 禁最小化和禁还原
		    	Flags := 3;
      end;
    end;
  end;
end;

procedure TfrmMDIMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  writelog('MDIMAIN','Close begin');
  if isNeedMainUI then
  begin
    writelog('MDIMAIN','Close 1');
    if (frmMain.isRunLoopStart)or(frmMain.isRunOnceStart) then
    begin
      ShowMessage('Please stop running!');
      CloseAction := caNone;
      exit;
    end;
    if umain.isFullSpeedRunning then
    begin
      CloseAction := caNone;
      exit;
    end;

    if not frmMain.FormFinalClose then
    begin
      CloseAction := caNone;
      exit;
    end;
    writelog('MDIMAIN','Close 3');
  end;

  writelog('MDIMAIN','Close 4');
  //if isNeedAcqUI then
  //  frmAcquireImages.FormFinalClose;
  writelog('MDIMAIN','Close 5');
  //if isNeedAcqUI then
  //  FinalAllCameraInterfaces;      //在TfrmSplash.FormShow 时 InitialAllCameraInterfaces
  writelog('MDIMAIN','Close 6');
  FinalImageShowInterfaces;      //在TfrmSplash.FormShow 时 InitialImageShowInterfaces

  writelog('MDIMAIN','Close 7');
  frmautoloadsettings.SaveAllOptionsSettingValuesToIni();

  writelog('MDIMAIN','Close end');

end;

procedure TfrmMDIMain.actChangeToEnglishExecute(Sender: TObject);
begin
  //{
  //case (Sender as TControl).Tag of
  //0,1: ;
  //  2: ;
  //end;  }
  ////0,1 中文    2 英文
  //if Languageindex <> 2 then //(Sender as TControl).Tag then
  //begin
  //  Languageindex := 2;
  //  ChangeLanguageFile_old(Languageindex);
  //  ShowMessage(DF_LanguageTranslater(Languageindex, 'The language has been changed, please restart the program'));
  //end;

end;





procedure TfrmMDIMain.actChangeToChineseExecute(Sender: TObject);
begin
  ////0,1 中文    2 英文
  //  Languageindex := TControl(Sender).Tag;
  //  ChangeLanguageFile_old(Languageindex);
  //  ShowMessage(DF_LanguageTranslater(Languageindex, 'The language has been changed, please restart the program'));
end;

procedure TfrmMDIMain.actAutoLoadingSettingsExecute(Sender: TObject);
begin
  with frmAutoloadSettings do
    if ShowModal=mrOK then
    begin
      isStatusSetting_AutoLoadingSettings := cbAutoLoading.Checked;
      StatusSetting_AutoLoadingSettingsFilename := utf8toansi(edtFilename.Text);
      SaveAllOptionsSettingValuesToIni;
    end;
end;

procedure TfrmMDIMain.actChangeToAdvModeExecute(Sender: TObject);
begin


end;

procedure TfrmMDIMain.actAboutExecute(Sender:TObject);
begin
  frmSplash.BorderStyle := bsSingle;
  frmSplash.ShowModal;
end;

procedure TfrmMDIMain.actApplyForLicenseExecute(Sender:TObject);

var
  str:string;
begin
 // WriteLog('MdiMain', 'Create TIniFile, DFSN.ini, begin');
	//with TIniFile.Create(ExtractFilePath(ParamStr(0))+'DFSN.ini') do
 // begin
 //  	str := ReadString('DFLICENSE', 'DFLICENSECODE', '');
 //   if((Length(str) = 20) and (DF_SetupMode>=0))then
 //   begin
 //     frmDfLicense.edtLicense.Text := str[1..5]+'-'+str[6..10]+'-'+str[11..15]+'-'+str[16..20];
 //   end;
 //   Free;
 // end;
	WriteLog('MdiMain', 'Show License Modal');
  frmDfLicense.ShowModal;
	WriteLog('MdiMain', 'Hide License Modal');
end;

procedure TfrmMDIMain.actChangeLanguageExecute(Sender: TObject);
var
  k:integer;
begin
  if Sender is TMenuItem then
  begin
    k := (Sender as TMenuItem).Tag;
  end
  else
    exit;

  if Languageindex <> k then //(Sender as TControl).Tag then
  begin
    Languageindex := k;
    ChangeLanguageFile(Languageindex);
  end;
  ShowMessage(DF_LanguageTranslater(Languageindex, 'The language has been changed, please restart the program'));

end;

procedure TfrmMDIMain.actChangeLanguageUpdate(Sender: TObject);
var
  i:integer;
begin
  //if (frmmain.actRunStop.Enabled) or (frmMain.actFullspeedStop.Enabled) then
  //begin
  //  for i:=0 to mmLanguageItem.Count-1 do
  //  begin
  //    mmLanguageItem.Items[i].Enabled:=false;
  //  end;
  //end
  //else
  //begin
  //  for i:=0 to mmLanguageItem.Count-1 do
  //  begin
  //    mmLanguageItem.Items[i].Enabled:=true;
  //  end;
  //end;
end;

procedure TfrmMDIMain.FormCreate(Sender: TObject);
var
  i:integer;
  tmpmi : TMenuItem;
begin
  WriteLog('', 'frmMdiMain, FormCreate, 1');
  left := 0;
  top  := 0;
{  width := screen.Width;
  height := screen.Height-GetSystemTaskBarHeight;    }

  //进程设置最优先级
  SetPriorityClass(GetCurrentProcess(),REALTIME_PRIORITY_CLASS);


  //LY20141005--改到TfrmSplash.formcreate里面  GetAllUISettingValue;  //读出所有界面该有什么模块，不该有什么模块的设置

  WriteLog('', 'frmMdiMain, FormCreate, 2');
  /////// software name,company name //////////
  if trim(strProjUI_SoftwareNameString)<>'' then //INI_strProjUI_SoftwareNameString = 'softwarename'; //  strProjUI_SoftwareNameString:string; //softwarename= ; mdi statusbar.panels[0]显示的字符串
  begin
    stbmain.Panels[0].Text:=strProjUI_SoftwareNameString;
    caption := strProjUI_SoftwareNameString;
    mmabout.Caption:= 'About '+strProjUI_SoftwareNameString;
  end;
  if trim(strProjUI_CompanyNameString)<>'' then //INI_strProjUI_CompanyNameString = 'companyname'; //  strProjUI_CompanyNameString:string; //companyname= ;  mdi statusbar.panels[最后一列]显示的字符串
  begin
    stbmain.Panels[stbmain.Panels.Count-1].Text:=strProjUI_CompanyNameString;
  end;
  ////////



  WriteLog('', 'frmMdiMain, FormCreate, 3');
  if not isNeedMainUI then
  begin
    mmFileItem.Visible:=false;
    mmWindowMainItem.Visible := false;
  end;
  if not isNeedAcqUI then
  begin
    mmWindowAcqItem.Visible := false;
  end;

  if not isNeedProjUI then
  begin
    mmFileItem.Visible:=false;
    actNewProject.Visible:=false;
    actOpenProject.Visible:=false;
    actSaveProject.Visible:=false;
    actSaveAsProject.Visible:=false;
    actCloseProject.Visible:=false;
  end;


  //Caption := umain.MAINFORMCAPTION;

 /////////////////////
 //厂家定制的代码放在这里
 // 1.caption =
 // 2.stbmain.panels.0
 // 3.stbmain.panels.3
 /////////////////////





  {
  //LY20141005 delete
  case Languageindex of
  0,1: actChangeToChinese.Checked := true;
    2: actChangeToEnglish.Checked := true;
  end;
  }

  WriteLog('', 'frmMdiMain, FormCreate, 5');
  if isNeedMainUI_menu_language then
  begin
    if lstLanguageName.Count>1 then   //lstLanguageName[0] is default, default is chinese
    begin
      miLang1.Free;
      miLang2.Free;
      for i:=1 to lstLanguageName.Count-1 do
      begin
        tmpmi := TMenuItem.Create(mmMain);
        with tmpmi do
        begin
          Caption := lstLanguageName[i];
          tag := i;
        end;
        tmpmi.OnClick:= @actChangeLanguageExecute;//tmpmi.Action := actChangeLanguage; 如果这么赋值的话，caption会变成action的，而且只有一个
        if Languageindex=i then
          tmpmi.Checked := true;
        mmLanguageItem.Add(tmpmi);
      end;

    end
    else
    begin
      case Languageindex of
      0,1: actChangeToChinese.Checked := true;
        2: actChangeToEnglish.Checked := true;
      end;
    end;
  end
  else
  begin
    mmLanguageItem.Visible:=false;
  end;

  WriteLog('', 'frmMdiMain, FormCreate, 6');
  //改copyright字符串
  stbMain.Panels[5].Text := frmSplash.lbCopyright.Caption + '   ';
  Caption := AnsiToUtf8(ChangeFileExt(ExtractFileName(ParamStr(0)), ''));

  if NeedSaveFormCaptionToIni then
    SaveCaptionListToIni(self);
  OpenCaptionListFromIni(self);
  WriteLog('', 'frmMdiMain, FormCreate, end');
end;

procedure TfrmMDIMain.mmWindowAcqItemClick(Sender: TObject);
begin
  //MDIPanel.ShowWindow(frmAcquireImages);
  //MDIPanel.ChildWindowsCreate(frmAcquireImages, TfrmAcquireImages);
end;

procedure TfrmMDIMain.mmWindowMainItemClick(Sender: TObject);
begin
  MDIPanel.ShowWindow(frmMain);
  //MDIPanel.ChildWindowsCreate(frmMain, TfrmMain);
end;

procedure TfrmMDIMain.tmrAutoLoadingSettingsFilenameTimer(Sender: TObject);
begin

  tmrAutoLoadingSettingsFilename.Enabled := false;
  frmMain.runningState := 1;
  if(isStatusSetting_OpenProjectFromAssocFile)then
  begin
    frmShowInfoPanel.pnlShowInfo.Caption:='Loading, please wait!';
    frmShowInfoPanel.Show;
    umain.frmmain.OpenProject_Auto(StatusSetting_OpenProjectFromAssocFilename);
    frmShowInfoPanel.Hide;
    exit;
  end;

  //自动加载工程
  if (isStatusSetting_AutoLoadingSettings )then//options->Serial Port Settings  [AUTOLOAD] AUTOLOADING=1 ;  1=checked;  0=unchecked
  begin
    frmShowInfoPanel.pnlShowInfo.Caption:='Loading, please wait!';
    frmShowInfoPanel.Show;
    umain.frmmain.OpenProject_Auto(StatusSetting_AutoLoadingSettingsFilename);
    frmShowInfoPanel.Hide;
    exit;
  end;
end;


procedure TfrmMDIMain.actCloseProjectExecute(Sender: TObject);
begin
  actNewProjectExecute(sender);
end;

procedure TfrmMDIMain.actCOMSettingsExecute(Sender: TObject);
begin
  frmCOMSettings.Show;//frmCOMSettings.ShowModal;
end;

procedure TfrmMDIMain.actDFVisionHelpExecute(Sender:TObject);
begin
  //Done:打开chm
  //uses HtmlHelp
  HtmlHelpA(Self.WindowHandle, PChar(Utf8ToAnsi(DFVISION_GLOBAL_DOC_PATH+DFVISION_GLOBAL_DOC_HELP_PATH+'Dragonfly Vision Assistant帮助文档.chm')), HH_DISPLAY_TOPIC, 0);
end;

procedure TfrmMDIMain.actExitExecute(Sender:TObject);
begin
  Close;
end;

procedure TfrmMDIMain.actManualExecute(Sender:TObject);
begin
  ExecuteProcess('', (Utf8ToAnsi(DFVISION_GLOBAL_DOC_PATH+'用户手册.pdf')), []);
  //ShellExecute(Self.WindowHandle, 'open', PChar(Utf8ToAnsi(DFVISION_GLOBAL_DOC_PATH+'用户手册.pdf')), nil, nil, SW_SHOWNORMAL);
end;


procedure TfrmMDIMain.actNewProjectExecute(Sender: TObject);
begin
  umain.frmMain.ClearDiagram;
end;

procedure TfrmMDIMain.actOpenProjectExecute(Sender: TObject);
begin
  umain.frmMain.OpenProject;
  {
  //1. 检查现在工程是否保存
  if (umain.frmMain.Modified) then
  begin
    tmpresult := Application.MessageBox('The current project will be closed, save or not ?', 'Question',
      MB_ICONQUESTION + MB_YESNOCANCEL);
    //MessageDlg ('Question','The current project will be closed, save or not ?', mtConfirmation,[mbYes, mbNo, mbCancel],0);
    if tmpresult = IDYES then       //(1)"是"就保存 , "否"就直接清空
    begin
      actSaveProjectExecute(sender);
    end
    else if tmpresult= IDCANCEL then  //(2)取消就退出
    begin
      exit;
    end;

  end;

  if dlgOpenProject.Execute then
  begin
    FSaveDocName := dlgOpenProject.FileName;
    umain.frmMain.LoadProjectFromFile(dlgOpenProject.FileName);
  end;     }
end;



procedure TfrmMDIMain.actSaveProjectExecute(Sender: TObject);
begin
  umain.frmMain.SaveProject;
end;

procedure TfrmMDIMain.actOpenProjectUpdate(Sender: TObject);
begin
  if MDIPanel.CurrentChildWindow=frmMain then
    actOpenProject.Enabled := true
  else
    actOpenProject.Enabled := false;
end;

procedure TfrmMDIMain.actSaveAsProjectExecute(Sender: TObject);
begin
  umain.frmMain.SaveAsProject;
end;

procedure TfrmMDIMain.actSaveProjectUpdate(Sender: TObject);
begin
  if not isNeedMainUI then  //如果没有主模块直接退出
  begin
    exit;
  end;

  if MDIPanel.CurrentChildWindow=frmMain then
  begin


    actNewProject.Enabled := true;
    actOpenProject.Enabled := true;
    if umain.frmMain.Modified and (lyDgPanel.Count>0) then
      actSaveProject.Enabled := true
    else
      actSaveProject.Enabled := false;
    if(lyDgPanel <> nil)then
    begin
      if (lyDgPanel.Count>0) then
        actSaveAsProject.Enabled := true
      else
        actSaveAsProject.Enabled := false;
    end;

    actCloseProject.Enabled := true;
  end
  else
  begin
    actNewProject.Enabled := false;
    actOpenProject.Enabled := false;
    actSaveProject.Enabled := false;
    actSaveAsProject.Enabled := false;
    actCloseProject.Enabled := false;
  end;

end;

procedure TfrmMDIMain.actServerConnSettingExecute(Sender:TObject);
begin
  frmServerConnSetting.ShowModal;
end;



end.


