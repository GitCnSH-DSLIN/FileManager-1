object FrmServidorArquivos: TFrmServidorArquivos
  Left = 0
  Top = 0
  Caption = 'Servidor de Arquivos'
  ClientHeight = 307
  ClientWidth = 730
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
    Left = 24
    Top = 146
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
    Left = 175
    Top = 100
    Width = 35
    Height = 13
    Caption = 'System'
  end
  object lblPai: TLabel
    Left = 175
    Top = 8
    Width = 83
    Height = 13
    Caption = 'Father Group ID'
  end
  object lblMainFolderName: TLabel
    Left = 175
    Top = 54
    Width = 94
    Height = 13
    Caption = 'Main Folder Name'
  end
  object lblServerURL: TLabel
    Left = 24
    Top = 192
    Width = 54
    Height = 13
    Caption = 'Server URL'
  end
  object Label1: TLabel
    Left = 175
    Top = 146
    Width = 55
    Height = 13
    Caption = 'User Name'
  end
  object btnExecute: TButton
    Left = 24
    Top = 248
    Width = 145
    Height = 30
    Caption = 'Execute'
    DoubleBuffered = False
    ParentDoubleBuffered = False
    TabOrder = 5
    OnClick = btnExecuteClick
  end
  object edtTableName: TEdit
    Left = 24
    Top = 119
    Width = 145
    Height = 21
    TabOrder = 4
    Text = 'GR_PESSOAS'
  end
  object edtIdOrigin: TEdit
    Left = 24
    Top = 73
    Width = 145
    Height = 21
    TabOrder = 1
    Text = '1'
  end
  object edtMaxFileSize: TEdit
    Left = 24
    Top = 165
    Width = 145
    Height = 21
    Alignment = taRightJustify
    TabOrder = 6
    Text = '5'
  end
  object grpFilesType: TGroupBox
    Left = 350
    Top = 8
    Width = 356
    Height = 132
    Caption = 'Files Type (optional)'
    TabOrder = 7
    object chkImages: TCheckBox
      Left = 16
      Top = 21
      Width = 100
      Height = 17
      Caption = 'Images'
      TabOrder = 0
    end
    object chkWord: TCheckBox
      Left = 16
      Top = 44
      Width = 100
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
      Left = 152
      Top = 21
      Width = 100
      Height = 17
      Caption = 'ZIP'
      TabOrder = 4
    end
    object chkPDF: TCheckBox
      Left = 152
      Top = 44
      Width = 100
      Height = 17
      Caption = 'PDF'
      TabOrder = 5
    end
  end
  object edtIdGroup: TEdit
    Left = 24
    Top = 27
    Width = 145
    Height = 21
    Alignment = taRightJustify
    TabOrder = 0
  end
  object edtFatherGroup: TEdit
    Left = 175
    Top = 27
    Width = 145
    Height = 21
    Alignment = taRightJustify
    TabOrder = 2
  end
  object edtMainFolderName: TEdit
    Left = 175
    Top = 73
    Width = 145
    Height = 21
    TabOrder = 3
    Text = 'Pessoa 1'
  end
  object grpPermissions: TGroupBox
    Left = 531
    Top = 146
    Width = 175
    Height = 132
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
  object grpGroupPermissions: TGroupBox
    Left = 350
    Top = 146
    Width = 175
    Height = 132
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
    Left = 175
    Top = 119
    Width = 145
    Height = 21
    TabOrder = 10
    Text = 'SIA'
  end
  object edtServerURL: TEdit
    Left = 24
    Top = 211
    Width = 296
    Height = 21
    TabOrder = 11
    Text = 
      'http://192.168.0.54:8092/fileserver/fileserver.dll//fiorilli/api' +
      '/files'
  end
  object btnClear: TButton
    Left = 175
    Top = 248
    Width = 145
    Height = 30
    Caption = 'Clear'
    DoubleBuffered = False
    ParentDoubleBuffered = False
    TabOrder = 12
    OnClick = btnClearClick
  end
  object edtUserName: TEdit
    Left = 175
    Top = 165
    Width = 145
    Height = 21
    TabOrder = 13
    Text = '@mateusvicente'
  end
end
