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
    Left = 24
    Top = 100
    Width = 26
    Height = 13
    Caption = 'Table'
  end
  object lblOrigem: TLabel
    Left = 24
    Top = 54
    Width = 33
    Height = 13
    Caption = 'Origin'
  end
  object lblTamanhoMaximo: TLabel
    Left = 591
    Top = 204
    Width = 104
    Height = 13
    Caption = 'Max File Size (in MB)'
  end
  object lblCadastro: TLabel
    Left = 24
    Top = 8
    Width = 47
    Height = 13
    Caption = 'Group ID'
  end
  object lblSistema: TLabel
    Left = 24
    Top = 146
    Width = 35
    Height = 13
    Caption = 'System'
  end
  object lblPai: TLabel
    Left = 182
    Top = 8
    Width = 69
    Height = 13
    Caption = 'Father Group'
  end
  object Label1: TLabel
    Left = 182
    Top = 54
    Width = 94
    Height = 13
    Caption = 'Main Folder Name'
  end
  object btnAbrir: TButton
    Left = 24
    Top = 200
    Width = 137
    Height = 25
    Caption = 'View'
    DoubleBuffered = False
    ParentDoubleBuffered = False
    TabOrder = 5
    OnClick = btnAbrirClick
  end
  object edtTableName: TEdit
    Left = 24
    Top = 119
    Width = 137
    Height = 21
    TabOrder = 4
  end
  object edtIdOrigin: TEdit
    Left = 24
    Top = 73
    Width = 137
    Height = 21
    TabOrder = 1
  end
  object edtMaxFileSize: TEdit
    Left = 591
    Top = 223
    Width = 137
    Height = 21
    TabOrder = 6
    Text = '1'
  end
  object grpFilesType: TGroupBox
    Left = 591
    Top = 8
    Width = 226
    Height = 190
    Caption = 'Files Type (optional)'
    TabOrder = 7
    object chkImages: TCheckBox
      Left = 16
      Top = 21
      Width = 200
      Height = 17
      Caption = 'Images'
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
    object chkZIP: TCheckBox
      Left = 16
      Top = 113
      Width = 200
      Height = 17
      Caption = 'ZIP'
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
  object edtIdGroup: TEdit
    Left = 24
    Top = 27
    Width = 137
    Height = 21
    TabOrder = 0
  end
  object edtFatherGroup: TEdit
    Left = 182
    Top = 27
    Width = 137
    Height = 21
    TabOrder = 2
  end
  object edtMainFolderName: TEdit
    Left = 182
    Top = 73
    Width = 137
    Height = 21
    TabOrder = 3
  end
  object grpPermissions: TGroupBox
    Left = 350
    Top = 8
    Width = 226
    Height = 115
    Caption = 'Permissions (optional)'
    TabOrder = 8
    object chkUpdate: TCheckBox
      Left = 16
      Top = 21
      Width = 200
      Height = 17
      Caption = 'Update'
      TabOrder = 0
    end
    object chkDelete: TCheckBox
      Left = 16
      Top = 44
      Width = 200
      Height = 17
      Caption = 'Delete'
      TabOrder = 1
    end
    object chkDownload: TCheckBox
      Left = 16
      Top = 67
      Width = 200
      Height = 17
      Caption = 'Download'
      TabOrder = 2
    end
    object chkUpload: TCheckBox
      Left = 16
      Top = 90
      Width = 200
      Height = 17
      Caption = 'Upload'
      TabOrder = 3
    end
  end
  object GroupBox3: TGroupBox
    Left = 350
    Top = 129
    Width = 226
    Height = 115
    Caption = 'Group Permission (optional)'
    TabOrder = 9
    object chkGroupUpdate: TCheckBox
      Left = 16
      Top = 21
      Width = 200
      Height = 17
      Caption = 'Update'
      TabOrder = 0
    end
    object chkGroupDelete: TCheckBox
      Left = 16
      Top = 44
      Width = 200
      Height = 17
      Caption = 'Delete'
      TabOrder = 1
    end
    object chkGroupDownload: TCheckBox
      Left = 16
      Top = 67
      Width = 200
      Height = 17
      Caption = 'Download'
      TabOrder = 2
    end
    object chkGroupUpload: TCheckBox
      Left = 16
      Top = 90
      Width = 200
      Height = 17
      Caption = 'Upload'
      TabOrder = 3
    end
  end
  object edtSystemName: TEdit
    Left = 24
    Top = 165
    Width = 137
    Height = 21
    TabOrder = 10
  end
end
