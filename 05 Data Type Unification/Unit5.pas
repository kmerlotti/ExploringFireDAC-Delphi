unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Vcl.StdCtrls,
  Vcl.ExtCtrls, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.VCLUI.Wait,
  FireDAC.Phys.IBBase, FireDAC.Phys.IB, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL, FireDAC.Comp.UI, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Phys.IBDef, FireDAC.Phys.MSSQLDef;

type
  TDBType = (Interbase, SqlServer);

  TForm5 = class(TForm)
    FDConnection1: TFDConnection;
    Button1: TButton;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    Button2: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    FDQuery1: TFDQuery;
    FDQuery1CAMPO01: TSQLTimeStampField;
    FDQuery1CAMPO02: TFloatField;
    FDQuery1CAMPO03: TFloatField;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure GetData(DBType: TDBType);
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}
{ TForm5 }

procedure TForm5.Button1Click(Sender: TObject);
begin
  GetData(TDBType.Interbase);
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
  GetData(TDBType.SqlServer);
end;

procedure TForm5.GetData(DBType: TDBType);
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
  FDQuery1.Close();
  Application.ProcessMessages; sleep(500); //just to see screen updating
  FDQuery1.Open();
end;

end.
