unit Unit_DengLu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm_DengLu = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit_MM: TEdit;
    ComboBox_YHM: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_DengLu: TForm_DengLu;
  MM : string ;

implementation

uses
  Unit_Zhu , Unit_SJK;

{$R *.dfm}

procedure TForm_DengLu.Button1Click(Sender: TObject);
var
  y : integer;
begin
  y := ComboBox_YHM.ItemIndex ;
  dm_sjk.ADOQ_SJK.MoveBy(y);
  if Edit_MM.Text = DM_SJK.ADOQ_SJK.FieldByName('mm').AsString then
    begin
      DM_SJK.ADOQ_SJK.Close;
      Form_Zhu.Show;
      Form_DengLu.Free;
    end
  else
    begin
      ShowMessage('对不起，您输入的密码错误。');
    end;
end;

procedure TForm_DengLu.Button2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm_DengLu.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TForm_DengLu.FormShow(Sender: TObject);
var
  i : integer ;
begin
  ComboBox_YHM.Clear;
  DM_SJK.ADOQ_SJK.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=db.mdb;Persist Security Info=False';
  DM_SJK.ADOQ_SJK.SQL.Text := 'select * from yonghu' ;
  DM_SJK.ADOQ_SJK.Open ;
  DM_SJK.ADOQ_SJK.First;
  for i := 0 to DM_SJK.ADOQ_SJK.RecordCount - 1 do
    begin
      ComboBox_YHM.Items.Add(DM_SJK.ADOQ_SJK.FieldByName('yhm').AsString);
      DM_SJK.ADOQ_SJK.Next;
    end;
  ComboBox_YHM.ItemIndex := 0 ;
end;

end.
