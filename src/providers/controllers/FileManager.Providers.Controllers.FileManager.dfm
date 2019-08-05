inherited ControllerFileManager: TControllerFileManager
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 106
  Width = 412
  object mmtPastas: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 248
    Top = 40
    object mmtPastasCOD_PAS: TLargeintField
      FieldName = 'COD_PAS'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object mmtPastasCOD_AGR_PAS: TLargeintField
      FieldName = 'COD_AGR_PAS'
    end
    object mmtPastasDESCR_PAS: TStringField
      FieldName = 'DESCR_PAS'
      Size = 150
    end
    object mmtPastasLOGIN_INC_PAS: TStringField
      FieldName = 'LOGIN_INC_PAS'
      Size = 30
    end
    object mmtPastasDTA_INC_PAS: TDateTimeField
      FieldName = 'DTA_INC_PAS'
    end
    object mmtPastasLOGIN_ALT_PAS: TStringField
      FieldName = 'LOGIN_ALT_PAS'
      Size = 30
    end
    object mmtPastasDTA_ALT_PAS: TDateTimeField
      FieldName = 'DTA_ALT_PAS'
    end
  end
  object mmtArquivos: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 336
    Top = 40
    object mmtArquivosCOD_ARQ: TLargeintField
      FieldName = 'COD_ARQ'
      Origin = 'COD_ARQ'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object mmtArquivosCOD_PAS_ARQ: TLargeintField
      FieldName = 'COD_PAS_ARQ'
      Origin = 'COD_PAS_ARQ'
    end
    object mmtArquivosCONTENT_TYPE_ARQ: TStringField
      FieldName = 'CONTENT_TYPE_ARQ'
      Origin = 'CONTENT_TYPE_ARQ'
      Size = 150
    end
    object mmtArquivosCAMINHO_ARQ: TStringField
      FieldName = 'CAMINHO_ARQ'
      Origin = 'CAMINHO_ARQ'
      Size = 150
    end
    object mmtArquivosNOME_ARQ: TStringField
      FieldName = 'NOME_ARQ'
      Origin = 'NOME_ARQ'
      Size = 255
    end
    object mmtArquivosDESCRICAO_ARQ: TStringField
      FieldName = 'DESCRICAO_ARQ'
      Origin = 'DESCRICAO_ARQ'
      Size = 255
    end
    object mmtArquivosTAMANHO_ARQ: TIntegerField
      FieldName = 'TAMANHO_ARQ'
      Origin = 'TAMANHO_ARQ'
    end
    object mmtArquivosLOGIN_INC_ARQ: TStringField
      FieldName = 'LOGIN_INC_ARQ'
      Origin = 'LOGIN_INC_ARQ'
      Size = 30
    end
    object mmtArquivosDTA_INC_ARQ: TSQLTimeStampField
      FieldName = 'DTA_INC_ARQ'
      Origin = 'DTA_INC_ARQ'
    end
    object mmtArquivosLOGIN_ALT_ARQ: TStringField
      FieldName = 'LOGIN_ALT_ARQ'
      Origin = 'LOGIN_ALT_ARQ'
      Size = 30
    end
    object mmtArquivosDTA_ALT_ARQ: TSQLTimeStampField
      FieldName = 'DTA_ALT_ARQ'
      Origin = 'DTA_ALT_ARQ'
    end
  end
  object mmtAgrupamento: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 160
    Top = 40
    object mmtAgrupamentoCOD_AGR: TLargeintField
      FieldName = 'COD_AGR'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object mmtAgrupamentoCOD_CAD_AGR: TIntegerField
      FieldName = 'COD_CAD_AGR'
    end
    object mmtAgrupamentoRAIZ_AGR: TStringField
      FieldName = 'RAIZ_AGR'
      Size = 1
    end
    object mmtAgrupamentoCOD_AGR_AGR: TLargeintField
      FieldName = 'COD_AGR_AGR'
    end
    object mmtAgrupamentoLOGIN_INC_AGR: TStringField
      FieldName = 'LOGIN_INC_AGR'
      Size = 30
    end
    object mmtAgrupamentoDTA_INC_AGR: TDateTimeField
      FieldName = 'DTA_INC_AGR'
    end
    object mmtAgrupamentoLOGIN_ALT_AGR: TStringField
      FieldName = 'LOGIN_ALT_AGR'
      Size = 30
    end
    object mmtAgrupamentoDTA_ALT_AGR: TDateTimeField
      FieldName = 'DTA_ALT_AGR'
    end
  end
  object mmtCadastro: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 56
    Top = 40
    object mmtCadastroCOD_CAD: TLargeintField
      FieldName = 'COD_CAD'
      Origin = 'COD_CAD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object mmtCadastroORIGEM_CAD: TStringField
      FieldName = 'ORIGEM_CAD'
      Origin = 'ORIGEM_CAD'
      Size = 150
    end
    object mmtCadastroTABELA_CAD: TStringField
      FieldName = 'TABELA_CAD'
      Origin = 'TABELA_CAD'
      Size = 150
    end
    object mmtCadastroSISTEMA_CAD: TStringField
      FieldName = 'SISTEMA_CAD'
      Origin = 'SISTEMA_CAD'
      Size = 150
    end
    object mmtCadastroLOGIN_INC_CAD: TStringField
      FieldName = 'LOGIN_INC_CAD'
      Origin = 'LOGIN_INC_CAD'
      Size = 30
    end
    object mmtCadastroDTA_INC_CAD: TSQLTimeStampField
      FieldName = 'DTA_INC_CAD'
      Origin = 'DTA_INC_CAD'
    end
    object mmtCadastroLOGIN_ALT_CAD: TStringField
      FieldName = 'LOGIN_ALT_CAD'
      Origin = 'LOGIN_ALT_CAD'
      Size = 30
    end
    object mmtCadastroDTA_ALT_CAD: TSQLTimeStampField
      FieldName = 'DTA_ALT_CAD'
      Origin = 'DTA_ALT_CAD'
    end
  end
end
