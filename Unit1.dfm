object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Senhas'
  ClientHeight = 499
  ClientWidth = 1188
  Color = clNone
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'SenhasUI'
  Font.Style = []
  OnCreate = FormCreate
  OnResize = FormResize
  TextHeight = 15
  object ImageBackground: TImage
    Left = 0
    Top = 0
    Width = 1188
    Height = 499
    Align = alClient
    ExplicitWidth = 1196
    ExplicitHeight = 500
  end
  object edtSenha: TEdit
    Left = 24
    Top = 20
    Width = 1137
    Height = 23
    TabOrder = 0
    Text = 'Filtrar por nome'
    OnChange = edtSenhaChange
  end
end
