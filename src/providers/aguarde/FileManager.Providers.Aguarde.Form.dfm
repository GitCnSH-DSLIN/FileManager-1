object FrmAguarde: TFrmAguarde
  Left = 0
  Top = 0
  AlphaBlend = True
  AlphaBlendValue = 135
  BorderStyle = bsNone
  Caption = 'FrmAguarde'
  ClientHeight = 86
  ClientWidth = 405
  Color = clBlack
  TransparentColor = True
  TransparentColorValue = clOlive
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  DesignSize = (
    405
    86)
  PixelsPerInch = 96
  TextHeight = 13
  object lblContent: TLabel
    Left = 82
    Top = 14
    Width = 303
    Height = 48
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'Message Text'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -16
    Font.Name = 'Segoe UI Semibold'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
    WordWrap = True
  end
  object ActivityIndicator: TActivityIndicator
    Left = 17
    Top = 14
    Animate = True
    IndicatorColor = aicWhite
    IndicatorSize = aisLarge
  end
end
