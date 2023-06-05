object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 164
  ClientWidth = 460
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Image1: TImage
    Left = 72
    Top = 22
    Width = 300
    Height = 75
    ParentShowHint = False
    Proportional = True
    ShowHint = True
  end
  object Image2: TImage
    Left = 378
    Top = 96
    Width = 74
    Height = 60
  end
  object LabeledEdit1: TLabeledEdit
    Left = 72
    Top = 120
    Width = 219
    Height = 23
    EditLabel.Width = 284
    EditLabel.Height = 15
    EditLabel.Caption = 'To continue, type the characters you see in the picture'
    TabOrder = 0
  end
  object Button1: TButton
    Left = 297
    Top = 119
    Width = 75
    Height = 25
    Caption = 'Validate'
    TabOrder = 1
    OnClick = Button1Click
  end
end
