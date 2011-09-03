inherited frGenericTaskItemView: TfrGenericTaskItemView
  Left = 1064
  Top = 166
  Caption = 'frGenericTaskItemView'
  PixelsPerInch = 96
  TextHeight = 13
  inherited ViewControl: TcxGroupBox
    inherited pcMain: TcxPageControl
      ActivePage = tsMain
      inherited tsMain: TcxTabSheet
        inherited grMain: TcxDBVerticalGrid
          OptionsView.ValueWidth = 335
          Version = 1
        end
      end
      inherited tsData: TcxTabSheet
        inherited grData: TcxDBVerticalGrid
          Version = 1
        end
        inherited grDataRec: TcxGrid
          Top = 233
          Height = 222
        end
        inherited cxSplitter1: TcxSplitter
          Height = 8
        end
      end
    end
  end
end
