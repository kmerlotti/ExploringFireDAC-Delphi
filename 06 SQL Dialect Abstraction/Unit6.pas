unit Unit6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.Phys.IB, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.IBDef;

type
  TDBType = (Interbase, SqlServer);

  TForm6 = class(TForm)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Splitter1: TSplitter;
    LinkLabel1: TLinkLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure LinkLabel1LinkClick(Sender: TObject; const Link: string;
      LinkType: TSysLinkType);
  private
    procedure GetData(DBType: TDBType);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

uses Winapi.ShellApi;

procedure TForm6.Button1Click(Sender: TObject);
begin
  GetData(TDBType.Interbase);
end;

procedure TForm6.Button2Click(Sender: TObject);
begin
  GetData(TDBType.SqlServer);
end;

procedure TForm6.GetData(DBType: TDBType);
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
  FDQuery1.SQL.Assign(Memo1.Lines);
  FDQuery1.Open();
end;

procedure TForm6.LinkLabel1LinkClick(Sender: TObject; const Link: string;
  LinkType: TSysLinkType);
begin
  ShellExecute(0, 'open', PChar(Link), nil, nil, SW_SHOWNORMAL);
end;

end.

// SELECT {IF MSSQL} TOP 10 {FI}* FROM CLIENTES {IF IB} ROWS 5 {FI}
// http://docwiki.embarcadero.com/RADStudio/Berlin/en/Preprocessing_Command_Text_(FireDAC)
