unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.VCLUI.Wait,
  FireDAC.Phys.IBBase, FireDAC.Phys.IB, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, FireDAC.VCLUI.Error, FireDAC.Phys.IBDef;

type
  TDBType = (Interbase, SqlServer);

  TForm8 = class(TForm)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDQuery1CAMPO01: TSQLTimeStampField;
    FDQuery1CAMPO02: TSingleField;
    FDQuery1CAMPO03: TFloatField;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    CheckBox1: TCheckBox;
    FDGUIxErrorDialog1: TFDGUIxErrorDialog;
    CheckBox2: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
    procedure SetData(DBType: TDBType);
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}
{ TForm8 }

procedure TForm8.Button1Click(Sender: TObject);
begin
  SetData(TDBType.Interbase);
end;

procedure TForm8.Button2Click(Sender: TObject);
begin
  SetData(TDBType.SqlServer);
end;

procedure TForm8.CheckBox1Click(Sender: TObject);
begin
  CheckBox2.Enabled := CheckBox1.Checked;
end;

procedure TForm8.SetData(DBType: TDBType);
begin
  FDConnection1.Close();
  case DBType of
    Interbase:
      begin
        FDConnection1.Params.Values['DriverID'] := 'IB';
        FDConnection1.Params.Values['Database'] := 'C:\Users\Kelver\Desktop\CodeRage XI\FireDAC\DB\FireDAC.GDB';
        FDConnection1.Params.Values['Protocol'] := 'TCPIP';
        FDConnection1.Params.Values['Server'] := 'localhost';
        FDConnection1.Params.Values['User_Name'] := 'sysdba';
        FDConnection1.Params.Values['Password'] := 'masterkey';
      end;
    SqlServer:
      begin
        FDConnection1.Params.Values['DriverID'] := 'MSSQL';
        FDConnection1.Params.Values['Database'] := 'FireDAC';
        FDConnection1.Params.Values['User_Name'] := 'sa';
        FDConnection1.Params.Values['Password'] := 'sa123';
        FDConnection1.Params.Values['Server'] := 'W7VM-BD';
        FDConnection1.Params.Values['OSAuthent'] := 'No';
      end;
  end;

  if CheckBox1.Checked then //uses EFDEngineException
  begin
    try
      FDQuery1.ExecSQL('insert into Clientes values(:Codigo, :Nome, :Data)',
        [1, 'Kelver Merlotti', '1985-11-27']);
    except
      on E: EFDDBEngineException do
      begin
        if E.Kind = ekUKViolated then
        begin
          if CheckBox2.Checked then //shows FD GUI Error Dialog
          begin
            FDGUIxErrorDialog1.Execute(E);
          end
          else //show a generic message
          begin
            case DBType of
              Interbase:
                Memo1.Lines.Text := 'Duplicated information';
              SqlServer:
                Memo2.Lines.Text := 'Duplicated information';
            end;
          end;
        end;
      end;
    end;
  end
  else //does not use EFDEngineException
  begin
    try
      FDQuery1.ExecSQL
        ('insert into Clientes values(1, ''Kelver Merlotti'', ''1985-11-27'')')
    except
      on E: Exception do
      begin
        case DBType of
          Interbase:
            Memo1.Lines.Text := E.Message;
          SqlServer:
            Memo2.Lines.Text := E.Message;
        end;
      end;
    end;
  end;
end;

end.
