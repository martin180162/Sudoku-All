unit f_change_colours;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, ExtCtrls, Buttons;


type

  { TFor_ChangeColours }

  TFor_ChangeColours = class(TForm)
    BitBtn1: TBitBtn;

    GroBox_ColourKey             : TGroupBox;
      GroBox_CellColour           : TGroupBox;
         LabEdi_CellEmpty          : TLabeledEdit;
         LabEdi_CellSame           : TLabeledEdit;
         LabEdi_CellDifferent      : TLabeledEdit;

      GroBox_TextColour     : TGroupBox;
        LabEdi_TextEmpty     : TLabeledEdit;
        LabEdi_TextSame      : TLabeledEdit;
        LabEdi_TextDifferent : TLabeledEdit;

      BitBtn_Cancel : TBitBtn;

       ColDia_ChangeColour: TColorDialog;


      procedure LabEdi_CellClick(Sender: TObject);





 // --------------------------------------------- //


  private
    { private declarations }

  public
    { public declarations }

  end;

var
  For_ChangeColours: TFor_ChangeColours;

implementation

{$R *.lfm}

{ TFor_ChangeColours }


procedure TFor_ChangeColours.LabEdi_CellClick(Sender: TObject);
begin
  with ColDia_ChangeColour do
    if execute
      then

        // ------------ //
        // Cell Colours //
        // ------------ //

        if Sender = LabEdi_CellEmpty
          then
            LabEdi_CellEmpty.Color:= ColDia_ChangeColour.Color;

        if Sender = LabEdi_CellSame
          then
            LabEdi_CellSame.Color:= ColDia_ChangeColour.Color;

         if Sender = LabEdi_CellDifferent
          then
            LabEdi_CellDifferent.Color:= ColDia_ChangeColour.Color;

end;





end.

