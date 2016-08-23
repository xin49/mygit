unit frmHaveShape;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons, StdCtrls, ComCtrls, ActnList, Unit1;

type

  { TForm1 }

  TForm1 = class(TForm)
    actDeleteAllShapes:TAction;
    actDeleteSelectedShape:TAction;
    actImage100:TAction;
    actImageAutoFit:TAction;
    actImageZoomin:TAction;
    actImageZoomOut:TAction;
    ActionList1:TActionList;
    actLimitsSetting:TAction;
    actLimitVisualize:TAction;
    actlstLimits:TActionList;
    BitBtn1:TBitBtn;
    btnCancel:TButton;
    btnLimits:TButton;
    btnOK:TButton;
    btntest:TButton;
    cbRefCoordinate:TCheckBox;
    cbRefCoordinateNameList:TComboBox;
    ComboBox1:TComboBox;
    edtStepname:TEdit;
    imgICO:TImage;
    imglstToolbar:TImageList;
    Label1:TLabel;
    Label10:TLabel;
    Label11:TLabel;
    Label12:TLabel;
    Label13:TLabel;
    Label14:TLabel;
    Label15:TLabel;
    Label16:TLabel;
    Label17:TLabel;
    Label18:TLabel;
    Label19:TLabel;
    Label2:TLabel;
    Label20:TLabel;
    Label21:TLabel;
    Label22:TLabel;
    Label23:TLabel;
    Label24:TLabel;
    Label25:TLabel;
    Label26:TLabel;
    Label27:TLabel;
    Label28:TLabel;
    Label29:TLabel;
    Label3:TLabel;
    Label30:TLabel;
    Label31:TLabel;
    Label32:TLabel;
    Label33:TLabel;
    Label34:TLabel;
    Label35:TLabel;
    Label36:TLabel;
    Label37:TLabel;
    Label38:TLabel;
    Label39:TLabel;
    Label4:TLabel;
    Label40:TLabel;
    Label41:TLabel;
    Label42:TLabel;
    Label43:TLabel;
    Label44:TLabel;
    Label45:TLabel;
    Label46:TLabel;
    Label47:TLabel;
    Label48:TLabel;
    Label49:TLabel;
    Label5:TLabel;
    Label50:TLabel;
    Label51:TLabel;
    Label52:TLabel;
    Label53:TLabel;
    Label54:TLabel;
    Label55:TLabel;
    Label56:TLabel;
    Label57:TLabel;
    Label58:TLabel;
    Label59:TLabel;
    Label6:TLabel;
    Label60:TLabel;
    Label61:TLabel;
    Label62:TLabel;
    Label63:TLabel;
    Label64:TLabel;
    Label65:TLabel;
    Label66:TLabel;
    Label67:TLabel;
    Label68:TLabel;
    Label69:TLabel;
    Label7:TLabel;
    Label70:TLabel;
    Label71:TLabel;
    Label72:TLabel;
    Label73:TLabel;
    Label74:TLabel;
    Label75:TLabel;
    Label76:TLabel;
    Label77:TLabel;
    Label78:TLabel;
    Label79:TLabel;
    Label8:TLabel;
    Label80:TLabel;
    Label81:TLabel;
    Label82:TLabel;
    Label9:TLabel;
    lblRefCoordinate:TLabel;
    maxvalue01:TLabel;
    maxvalue02:TLabel;
    maxvalue03:TLabel;
    maxvalue11:TLabel;
    maxvalue12:TLabel;
    maxvalue13:TLabel;
    maxvalue21:TLabel;
    maxvalue22:TLabel;
    maxvalue23:TLabel;
    maxvalue31:TLabel;
    maxvalue32:TLabel;
    maxvalue33:TLabel;
    maxvalueG:TLabel;
    meanvalue01:TLabel;
    meanvalue02:TLabel;
    meanvalue03:TLabel;
    meanvalue11:TLabel;
    meanvalue12:TLabel;
    meanvalue13:TLabel;
    meanvalue21:TLabel;
    meanvalue22:TLabel;
    meanvalue23:TLabel;
    meanvalue31:TLabel;
    meanvalue32:TLabel;
    meanvalue33:TLabel;
    meanvalueG:TLabel;
    minvalue01:TLabel;
    minvalue02:TLabel;
    minvalue03:TLabel;
    minvalue11:TLabel;
    minvalue12:TLabel;
    minvalue13:TLabel;
    minvalue21:TLabel;
    minvalue22:TLabel;
    minvalue23:TLabel;
    minvalue31:TLabel;
    minvalue32:TLabel;
    minvalue33:TLabel;
    minvalueG:TLabel;
    Notebook1:TNotebook;
    numbervalue01:TLabel;
    numbervalue02:TLabel;
    numbervalue03:TLabel;
    numbervalue11:TLabel;
    numbervalue12:TLabel;
    numbervalue13:TLabel;
    numbervalue21:TLabel;
    numbervalue22:TLabel;
    numbervalue23:TLabel;
    numbervalue31:TLabel;
    numbervalue32:TLabel;
    numbervalue33:TLabel;
    numbervalueG:TLabel;
    Page0:TPage;
    Page1:TPage;
    Page2:TPage;
    Page3:TPage;
    Page4:TPage;
    Panel1:TPanel;
    Panel2:TPanel;
    Panel3:TPanel;
    Panel4:TPanel;
    Panel5:TPanel;
    pnlCoordinate:TPanel;
    PnlGray:TPanel;
    PnlHistoBlue:TPanel;
    PnlHistoGreen:TPanel;
    PnlHistoHue1:TPanel;
    PnlHistoHue2:TPanel;
    PnlHistoHue3:TPanel;
    PnlHistoInte3:TPanel;
    PnlHistoLum2:TPanel;
    PnlHistoRed:TPanel;
    PnlHistoSat1:TPanel;
    PnlHistoSat2:TPanel;
    PnlHistoSat3:TPanel;
    PnlHistoValue1:TPanel;
    pnlImage:TPanel;
    pnlleft:TPanel;
    pnlRBBottom:TPanel;
    pnlRBottom:TPanel;
    pnlRBTop:TPanel;
    pnlRBTTop:TPanel;
    pnlRight:TPanel;
    pnlRImg:TPanel;
    pnlState:TShape;
    Shape1:TShape;
    StaticText1:TStaticText;
    stdvalue01:TLabel;
    stdvalue02:TLabel;
    stdvalue03:TLabel;
    stdvalue11:TLabel;
    stdvalue12:TLabel;
    stdvalue13:TLabel;
    stdvalue21:TLabel;
    stdvalue22:TLabel;
    stdvalue23:TLabel;
    stdvalue31:TLabel;
    stdvalue32:TLabel;
    stdvalue33:TLabel;
    stdvalueG:TLabel;
    ToolBar2:TToolBar;
    ToolButton1:TToolButton;
    ToolButton10:TToolButton;
    ToolButton11:TToolButton;
    ToolButton2:TToolButton;
    ToolButton20:TToolButton;
    ToolButton21:TToolButton;
    ToolButton24:TToolButton;
    ToolButton25:TToolButton;
    ToolButton3:TToolButton;
    ToolButton4:TToolButton;
    ToolButton5:TToolButton;
    ToolButton6:TToolButton;
    ToolButton7:TToolButton;
    ToolButton8:TToolButton;
    procedure BitBtn1Click(Sender:TObject);
    procedure cbShowHistModelChange(Sender:TObject);
    procedure FormCreate(Sender:TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
	procedure CallMe;export;
var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender:TObject);
begin

end;

procedure TForm1.BitBtn1Click(Sender:TObject);
var
  x : Integer;
begin
  Form2 := TForm2.Create(nil);
 	form2.Shape1.Brush.Color := clRed;
  x := form2.Shape1.Canvas.TextWidth('Pass');
  Form2.Free;
  Form1.Free;
end;

procedure TForm1.cbShowHistModelChange(Sender:TObject);
begin

end;

procedure CallMe;export;
begin
  Form1.BitBtn1Click(Form1);
end;

end.

