object Form7: TForm7
  Left = 0
  Top = 0
  Caption = 'Macros'
  ClientHeight = 427
  ClientWidth = 526
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 232
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
  end
  object ValueListEditor1: TValueListEditor
    Left = 8
    Top = 8
    Width = 510
    Height = 180
    TabOrder = 1
    TitleCaptions.Strings = (
      'Macro'
      'Value')
    ColWidths = (
      150
      354)
    RowHeights = (
      18
      18)
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 194
    Width = 510
    Height = 191
    DataSource = DataSource1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button2: TButton
    Left = 443
    Top = 391
    Width = 75
    Height = 25
    Caption = 'Execute'
    TabOrder = 3
    OnClick = Button2Click
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=FireDAC'
      'User_Name=sa'
      'Password=sa123'
      'Server=W7VM-BD'
      'OSAuthent=No'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 48
    Top = 264
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from !Table Where !Field !Signal !Value')
    Left = 136
    Top = 264
    MacroData = <
      item
        Value = 'Clientes'
        Name = 'TABLE'
      end
      item
        Value = 'Id'
        Name = 'FIELD'
      end
      item
        Value = '='
        Name = 'SIGNAL'
      end
      item
        Value = '1'
        Name = 'VALUE'
      end>
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 216
    Top = 264
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 448
    Top = 40
  end
  object FDPhysMSSQLDriverLink1: TFDPhysMSSQLDriverLink
    Left = 448
    Top = 88
  end
end
