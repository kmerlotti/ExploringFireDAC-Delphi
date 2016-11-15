unit Unit2;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL, Data.DB, FireDAC.Comp.DataSet, FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef;

type
  TDataModule2 = class(TDataModule)
    FDQuery1: TFDQuery;
    FDQuery2: TFDQuery;
    FDQuery4: TFDQuery;
    FDConnection1: TFDConnection;
    FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDMemTable1: TFDMemTable;
    FDMemTable2: TFDMemTable;
    FDMemTable4: TFDMemTable;
    FDMemTable5: TFDMemTable;
    FDQuery1Id: TFDAutoIncField;
    FDQuery1Nome: TStringField;
    FDQuery2Id: TFDAutoIncField;
    FDQuery2Produto: TStringField;
    FDQuery2Valor: TBCDField;
    FDQuery1DataNascimento: TWideStringField;
  private
    { Private declarations }
    procedure ClearMemTable(pTag: byte);
  public
    { Public declarations }
    function SQLNormal(): Integer;
    function SQLBatches(): Integer;
  end;

var
  DataModule2: TDataModule2;

implementation

uses
  Winapi.Windows;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule2 }

procedure TDataModule2.ClearMemTable(pTag: byte);
var
  I: Integer;
begin
  for I := 0 to ComponentCount -1 do
  begin
    if (Components[I] is TFDMemTable) and (TFDMemTable(Components[I]).Tag = pTag) then
    begin
      if (TFDMemTable(Components[I]).Active) and (not TFDMemTable(Components[I]).IsEmpty) then
      begin
        TFDMemTable(Components[I]).EmptyDataSet();
        TFDMemTable(Components[I]).Close();
      end;
    end;
  end;
end;

function TDataModule2.SQLBatches: Integer;
var
  OldTime: Cardinal;
begin
  FDConnection1.Close();
  //
  FDQuery4.FetchOptions.AutoClose := False;
  //
  ClearMemTable(2);

  OldTime := GetTickCount();
  FDQuery4.Open();
  result := GetTickCount - OldTime;
  FDMemTable4.Data := FDQuery4.Data;
  FDQuery4.NextRecordSet();
  FDMemTable5.Data := FDQuery4.Data;
end;

function TDataModule2.SQLNormal: Integer;
var
  OldTime: Cardinal;
begin
  FDConnection1.Close();
  ClearMemTable(1);
  OldTime := GetTickCount();
  FDQuery1.Open();
  FDQuery2.Open();
  result := GetTickCount - OldTime;

  FDMemTable1.Data := FDQuery1.Data;
  FDMemTable2.Data := FDQuery2.Data;
end;

end.
