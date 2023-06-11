unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,Vcl.Controls,Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.IOUtils,
  System.Types, Vcl.ExtCtrls, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,FireDAC.Stan.Def,FireDAC.DApt,FireDAC.Stan.Async, Vcl.Imaging.pngimage;

type
  TForm1 = class(TForm)
    edtSenha: TEdit;
    ImageBackground: TImage;
    procedure edtSenhaChange(Sender: TObject);
    procedure BancoInicial(Sender: TObject);
    procedure RadioButtonBancosChecked(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  end;

  var Form1: TForm1;
  var PanelBancos: TPanel;

implementation

{$R *.dfm}
procedure TForm1.FormResize(Sender: TObject);
begin
  Constraints.MinWidth := Width;
  Constraints.MaxWidth := Width;
  Constraints.MinHeight := Height;
  Constraints.MaxHeight := Height;
end;

procedure TForm1.edtSenhaChange(Sender: TObject);
begin
    var texto: string := TEdit(Sender).Text;
    var i: Integer;
    var radioButton: TRadioButton;

    for i := PanelBancos.ControlCount - 1 downto 0 do
      begin
        PanelBancos.Controls[i].Free;
      end;

    try
      if (Trim(texto) <> '') then
      begin
          var RadioButtonBancos: TRadioButton;
          var DiretorioPai := GetCurrentDir;
          var DiretorioRaiz := TPath.Combine(DiretorioPai, '..');
          var PastaDados := TPath.Combine(DiretorioRaiz,'dados');
          var SubPastas: TStringDynArray;
          var Subpasta: String;
          var NomeDaPasta: String;
          var rest: Integer := 0;
          var altura: Integer := 10;
          var largura: Integer := 20;
          var PanelBackGroundButtons: TPanel;
          var count: Integer := 0;
          var PanelName: String;
          var stop: Integer := 1;

          subPastas := TDirectory.GetDirectories(PastaDados);
          var folderPath, folderName: string;

          for subPasta in subPastas do
            begin
              if stop = 31 then
                Break;
              NomeDaPasta := ExtractFileName(subPasta);

              if Pos(UpperCase(texto), UpperCase(NomeDaPasta)) > 0 then
                begin
                  if rest = 5 then
                    begin
                      altura := altura + 65;
                      largura := 20;
                      rest := 0;
                    end;
                  PanelBackGroundButtons := TPanel.Create(Self);
                  PanelBackGroundButtons.Parent := PanelBancos;
                  PanelBackGroundButtons.Left := largura;
                  PanelBackGroundButtons.Top := altura;
                  PanelBackGroundButtons.Width := 220;
                  PanelBackGroundButtons.Color := clWhite;
                  PanelName := Format('PanelBackGroundButtons%d', [count]);
                  PanelBackGroundButtons.Name := PanelName;
                  PanelBackGroundButtons.Font.Color := clWhite;
                  PanelBackGroundButtons.ParentBackground := False;

                  RadioButtonBancos := TRadioButton.Create(Self);
                  RadioButtonBancos.Parent := PanelBackGroundButtons;
                  RadioButtonBancos.Top := 10;
                  RadioButtonBancos.Left := 15;
                  RadioButtonBancos.Caption := NomeDaPasta;
                  RadioButtonBancos.Font.Color := clBlack;
                  RadioButtonBancos.OnClick :=  RadioButtonBancosChecked;
                  largura := largura + 230;
                  Inc(count);
                  Inc(rest);
                  Inc(stop);
                end;
            end;
      end
    else
      begin
        for i := PanelBancos.ControlCount - 1 downto 0 do
        begin
            PanelBancos.Controls[i].Free;
        end;
        BancoInicial(Self);
      end;
    except
       on E:Exception do
       begin
          ShowMessage(E.Message);
          Application.Terminate;
       end;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var PngImage: TPngImage;
    Stream: TResourceStream;
begin
  try
    Stream := TResourceStream.Create(HInstance, 'IMG_FUNDO', RT_RCDATA);
    PngImage := TPngImage.Create;

    try
      PngImage.LoadFromStream(Stream);
      ImageBackground.Picture.Graphic := PngImage;
    finally
      PngImage.Free;
      Stream.Free;
    end;
  except
    on E:Exception do
      begin
        ShowMessage(E.Message);
        Application.Terminate;
      end;
  end;
  BancoInicial(Sender);
end;

procedure TForm1.BancoInicial(Sender: TObject);
begin

  try
  var RadioButtonBancos: TRadioButton;
  var DiretorioPai := GetCurrentDir;
  var DiretorioRaiz := TPath.Combine(DiretorioPai, '..');
  var PastaDados := TPath.Combine(DiretorioRaiz,'dados');
  var SubPastas: TStringDynArray;
  var Subpasta: String;
  var NomeDaPasta: String;
  var rest: Integer := 0;
  var altura: Integer := 10;
  var largura: Integer := 20;
  var PanelBackGroundButtons: TPanel;
  var count: Integer := 0;
  var PanelName: String;
  var stop: Integer := 1;

  PanelBancos := TPanel.Create(Self);
  PanelBancos.Parent := Form1;
  PanelBancos.Left := 10;
  PanelBancos.Top := 100;
  PanelBancos.Width := 1170;
  PanelBancos.Height := 600;
  PanelBancos.BevelOuter := bvNone;
  PanelBancos.ParentBackground := True;
  PanelBancos.Color := clNone;

  subPastas := TDirectory.GetDirectories(PastaDados);

  for subPasta in subPastas do
    begin
      if stop = 31 then
        Break;
      NomeDaPasta := ExtractFileName(subPasta);
      if rest = 5 then
        begin
          altura := altura + 65;
          largura := 20;
          rest := 0;
        end;
      PanelBackGroundButtons := TPanel.Create(Self);
      PanelBackGroundButtons.Parent := PanelBancos;
      PanelBackGroundButtons.Left := largura;
      PanelBackGroundButtons.Top := altura;
      PanelBackGroundButtons.Width := 220;
      PanelBackGroundButtons.Color := clWhite;
      PanelName := Format('PanelBackGroundButtons%d', [count]);
      PanelBackGroundButtons.Name := PanelName;
      PanelBackGroundButtons.Font.Color := clWhite;
      PanelBackGroundButtons.ParentBackground := False;

      RadioButtonBancos := TRadioButton.Create(Self);
      RadioButtonBancos.Parent := PanelBackGroundButtons;
      RadioButtonBancos.Top := 10;
      RadioButtonBancos.Left := 15;
      RadioButtonBancos.Caption := NomeDaPasta;
      RadioButtonBancos.Font.Color := clBlack;
      RadioButtonBancos.OnClick :=  RadioButtonBancosChecked;
      largura := largura + 230;
      Inc(count);
      Inc(rest);
      Inc(stop);
    end;
  except
    on E: Exception do
      begin
        ShowMessage('Pasta dados não encontrada!'+sLineBreak+'Erro: '+E.Message);
        Application.Terminate;
      end;
  end;
end;

procedure TForm1.RadioButtonBancosChecked(Sender: TObject);
begin
  var i: Integer;
  try
    var DiretorioPai := GetCurrentDir;
    var DiretorioRaiz := TPath.Combine(DiretorioPai, '..');
    var PastaDados := TPath.Combine(DiretorioRaiz,'dados');
    var Dados :=  TPath.Combine(PastaDados,TRadioButton(Sender).Caption);
    var CaminhoParaDados: string := TPath.Combine(Dados,'dadosemp.fdb');

    var FDConnection1: TFDConnection;
    FDConnection1 := TFDConnection.Create(nil);
    FDConnection1.DriverName := 'FB';
    FDConnection1.Params.Add('Database='+CaminhoParaDados);
    FDConnection1.Params.Add('User_Name=sysdba');
    FDConnection1.Params.Add('Password=masterkey');
    FDConnection1.Connected := True;

    var FDQuery1: TFDQuery;
    var Msg: string;
    try
      FDQuery1 := TFDQuery.Create(nil);
      FDQuery1.Connection := FDConnection1;
      FDQuery1.SQL.Text := 'select nome,senha from usuarios;';
      FDQuery1.Open;

      Msg := '';
      FDQuery1.First;
      while not FDQuery1.Eof do
      begin
        Msg := Msg + 'Nome: ' + FDQuery1.FieldByName('nome').AsString + sLineBreak;
        Msg := Msg + 'Senha: ' + FDQuery1.FieldByName('senha').AsString + sLineBreak;
        Msg := Msg + sLineBreak;

        FDQuery1.Next;
      end;

      ShowMessage(Msg);

      FDQuery1.Free;
      FDConnection1.Free;
    except
      on E: Exception do
      begin
        ShowMessage('Erro ao conectar-se ao banco de dados.'+ sLineBreak + 'Erro: ' + E.Message);
        for i := PanelBancos.ControlCount - 1 downto 0 do
        begin
            PanelBancos.Controls[i].Free;
        end;
        BancoInicial(Self);
      end;
    end;
    for i := PanelBancos.ControlCount - 1 downto 0 do
    begin
        PanelBancos.Controls[i].Free;
    end;
    BancoInicial(Self);
  except
    on E: Exception do
      begin
        ShowMessage(E.Message);
        for i := PanelBancos.ControlCount - 1 downto 0 do
        begin
            PanelBancos.Controls[i].Free;
        end;
        BancoInicial(Self);
      end;
  end;
end;

end.
