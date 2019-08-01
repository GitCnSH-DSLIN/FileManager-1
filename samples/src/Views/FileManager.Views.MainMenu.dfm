object FrmServidorArquivos: TFrmServidorArquivos
  Left = 0
  Top = 0
  Caption = 'Servidor de Arquivos'
  ClientHeight = 398
  ClientWidth = 918
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object lblTable: TLabel
    Left = 695
    Top = 100
    Width = 32
    Height = 13
    Caption = 'Tabela'
  end
  object lblOrigem: TLabel
    Left = 24
    Top = 54
    Width = 38
    Height = 13
    Caption = 'Origem'
  end
  object lblTamanhoMaximo: TLabel
    Left = 695
    Top = 8
    Width = 133
    Height = 13
    Caption = 'Tamanho M'#225'ximo (em MB)'
  end
  object lblCadastro: TLabel
    Left = 24
    Top = 8
    Width = 46
    Height = 13
    Caption = 'Cadastro'
  end
  object lblSistema: TLabel
    Left = 695
    Top = 54
    Width = 39
    Height = 13
    Caption = 'Sistema'
  end
  object lblPai: TLabel
    Left = 24
    Top = 100
    Width = 89
    Height = 13
    Caption = 'Agrupamento Pai'
  end
  object Label1: TLabel
    Left = 24
    Top = 146
    Width = 103
    Height = 13
    Caption = 'Descri'#231#227'o Pasta Raiz'
  end
  object btnAbrir: TButton
    Left = 24
    Top = 192
    Width = 137
    Height = 25
    Caption = 'Visualizar'
    DoubleBuffered = False
    ParentDoubleBuffered = False
    TabOrder = 5
    OnClick = btnAbrirClick
  end
  object edtTableName: TEdit
    Left = 695
    Top = 119
    Width = 137
    Height = 21
    TabOrder = 4
  end
  object edtOrigem: TEdit
    Left = 24
    Top = 73
    Width = 137
    Height = 21
    TabOrder = 1
  end
  object edtTamanhoMaximo: TEdit
    Left = 695
    Top = 27
    Width = 137
    Height = 21
    TabOrder = 6
    Text = '1'
  end
  object GroupBox1: TGroupBox
    Left = 207
    Top = 8
    Width = 226
    Height = 236
    Caption = 'Tipos de Documentos'
    TabOrder = 7
    object chkImagens: TCheckBox
      Left = 16
      Top = 21
      Width = 200
      Height = 17
      Caption = 'Imagens'
      TabOrder = 0
    end
    object chkWord: TCheckBox
      Left = 16
      Top = 44
      Width = 200
      Height = 17
      Caption = 'Word'
      TabOrder = 1
    end
    object chkExcel: TCheckBox
      Left = 16
      Top = 67
      Width = 200
      Height = 17
      Caption = 'Excel'
      TabOrder = 2
    end
    object chkPowerPoint: TCheckBox
      Left = 16
      Top = 90
      Width = 200
      Height = 17
      Caption = 'Power Point'
      TabOrder = 3
    end
    object chkArquivosZipados: TCheckBox
      Left = 16
      Top = 113
      Width = 200
      Height = 17
      Caption = 'Arquivos Zipados'
      TabOrder = 4
    end
    object chkPDF: TCheckBox
      Left = 16
      Top = 136
      Width = 200
      Height = 17
      Caption = 'PDF'
      TabOrder = 5
    end
  end
  object edtCadastro: TEdit
    Left = 24
    Top = 27
    Width = 137
    Height = 21
    TabOrder = 0
  end
  object cbxSistema: TComboBox
    Left = 695
    Top = 73
    Width = 137
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 8
    Text = 'SIA'
    Items.Strings = (
      'SIA'
      'SIP'
      'SCPI')
  end
  object edtFatherGroup: TEdit
    Left = 24
    Top = 119
    Width = 137
    Height = 21
    TabOrder = 2
  end
  object edtDescricaoPastaRaiz: TEdit
    Left = 24
    Top = 165
    Width = 137
    Height = 21
    TabOrder = 3
  end
  object GroupBox2: TGroupBox
    Left = 455
    Top = 129
    Width = 226
    Height = 115
    Caption = 'Permiss'#245'es'
    TabOrder = 9
    object CheckBox1: TCheckBox
      Left = 16
      Top = 21
      Width = 200
      Height = 17
      Caption = 'Alterar'
      TabOrder = 0
    end
    object CheckBox2: TCheckBox
      Left = 16
      Top = 44
      Width = 200
      Height = 17
      Caption = 'Excluir'
      TabOrder = 1
    end
    object CheckBox3: TCheckBox
      Left = 16
      Top = 67
      Width = 200
      Height = 17
      Caption = 'Download'
      TabOrder = 2
    end
    object CheckBox4: TCheckBox
      Left = 16
      Top = 90
      Width = 200
      Height = 17
      Caption = 'Upload'
      TabOrder = 3
    end
  end
  object GroupBox3: TGroupBox
    Left = 455
    Top = 8
    Width = 226
    Height = 115
    Caption = 'Permiss'#245'es Agrupamento'
    TabOrder = 10
    object CheckBox5: TCheckBox
      Left = 16
      Top = 21
      Width = 200
      Height = 17
      Caption = 'Alterar'
      TabOrder = 0
    end
    object CheckBox6: TCheckBox
      Left = 16
      Top = 44
      Width = 200
      Height = 17
      Caption = 'Excluir'
      TabOrder = 1
    end
    object CheckBox7: TCheckBox
      Left = 16
      Top = 67
      Width = 200
      Height = 17
      Caption = 'Download'
      TabOrder = 2
    end
    object CheckBox8: TCheckBox
      Left = 16
      Top = 90
      Width = 200
      Height = 17
      Caption = 'Upload'
      TabOrder = 3
    end
  end
end
