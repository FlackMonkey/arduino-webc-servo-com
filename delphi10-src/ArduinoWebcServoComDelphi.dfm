object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'arduino-webc-servo-com'
  ClientHeight = 300
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 182
    Width = 146
    Height = 49
    Caption = 'Left'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 241
    Top = 183
    Width = 146
    Height = 47
    Caption = 'Right'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 120
    Top = 131
    Width = 146
    Height = 45
    Caption = 'Up'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 120
    Top = 236
    Width = 146
    Height = 40
    Caption = 'Down'
    TabOrder = 3
    OnClick = Button4Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 379
    Height = 105
    Caption = 'Actions Monitor'
    TabOrder = 4
    object Memo1: TMemo
      Left = 3
      Top = 16
      Width = 373
      Height = 86
      Lines.Strings = (
        'COM Port 3 used by default')
      ReadOnly = True
      TabOrder = 0
    end
  end
  object Button5: TButton
    Left = 160
    Top = 182
    Width = 75
    Height = 49
    Caption = 'Center'
    TabOrder = 5
    OnClick = Button5Click
  end
  object ComboBox1: TComboBox
    Left = 296
    Top = 143
    Width = 57
    Height = 21
    AutoDropDown = True
    ItemHeight = 13
    TabOrder = 6
    Text = 'Angle'
    OnChange = ComboBox1Change
    Items.Strings = (
      '90'
      '60'
      '45'
      '30'
      '15'
      '5')
  end
end
