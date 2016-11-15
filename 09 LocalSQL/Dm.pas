unit Dm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  FireDAC.Phys.ODBCBase, FireDAC.Comp.Client, FireDAC.Phys.SQLiteVDataSet,
  Data.DB, FireDAC.Comp.DataSet;

type
  TDtm = class(TDataModule)
    FDConnINTERBASE: TFDConnection;
    FDConnMSSQL: TFDConnection;
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDLocalSQL1: TFDLocalSQL;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    sqlCustomers: TFDQuery;
    sqlSales: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetCustomers();
    procedure GetSales();
    procedure GetSalessInnerCustomers();
  end;

var
  Dtm: TDtm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDtm }

procedure TDtm.GetCustomers;
begin
  sqlCustomers.Open();
end;

procedure TDtm.GetSales;
begin
  sqlSales.Open();
end;

procedure TDtm.GetSalessInnerCustomers;
begin
  FDQuery1.Open();
end;

end.
