unit f_sudoku_key_and_grid;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons;

type

  { TForm1 }

  TForm1 = class(TForm)
    GroBox_GridCellAndTextColours        : TGroupBox;
      GroBox_GridCellColours             : TGroupBox;
        LabEdi_GridCellEmptyColour       : TLabeledEdit;
        LabEdi_GridCellSameColour        : TLabeledEdit;
        LabEdi_GridCellDifferentColour   : TLabeledEdit;
      GroBox_GridTextColours             : TGroupBox;
        LabEdi_GridTextEmptyColour       : TLabeledEdit;
        LabEdi_GridTextSameColour        : TLabeledEdit;
        LabEdi_GridTextDifferentColour   : TLabeledEdit;

        BitBtn_GridCancel                : TBitBtn;
        BitBtn_GridSaveColours           : TBitBtn;

      { --------------------------------------------------- }

    GroBox_KeyCellAndTextColours         : TGroupBox;
      Lab_KeyCell                        : TLabel;
        Lab_KeyCellEmpty                 : TLabel;
        Lab_KeyCellSame                  : TLabel;
        Lab_KeyCellDifferent             : TLabel;

        LabEdi_KeyCellEmptyColour        : TLabeledEdit;
        LabEdi_KeyCellSameColour         : TLabeledEdit;
        LabEdi_KeyCellDifferentColour    : TLabeledEdit;

        Lab_Key                          : TLabel;
        BitBtn_KeyCancel                 : TBitBtn;

        Lab_KeyText                      : TLabel;
          Lab_KeyTextEmpty               : TLabel;
           Lab_KeyTextSame               : TLabel;
           Lab_KeyTextDifferent          : TLabel;

           LabEdi_KeyTextEmptyColour     : TLabeledEdit;
           LabEdi_KeyTextSameColour      : TLabeledEdit;
           LabEdi_KeyTextDifferentColour : TLabeledEdit;

           Lab_KeyCellEmptySameDifferent : TLabel;
           procedure FormCreate(Sender: TObject);




  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

end.

