object FrmInput: TFrmInput
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Informa'#231#245'es do Arquivo'
  ClientHeight = 86
  ClientWidth = 383
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblDescricao: TLabel
    Left = 10
    Top = 10
    Width = 49
    Height = 13
    Caption = 'Descri'#231#227'o'
  end
  object edtDescricao: TEdit
    Left = 10
    Top = 29
    Width = 366
    Height = 21
    TabOrder = 0
  end
  object btnSalvar: TButton
    Left = 220
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Salvar'
    ImageIndex = 1
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancelar: TButton
    Left = 301
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    ImageIndex = 0
    ModalResult = 2
    TabOrder = 2
  end
end
