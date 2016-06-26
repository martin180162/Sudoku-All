unit u_components;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  Grids, ExtCtrls;


procedure P_EmptyGrid              ( PStrGri_EmptyGrid  : TStringGrid );
procedure P_DisplayNumbersInHeader ( PStrGri_Display    : TStringGrid );


procedure P_CopyContents           ( PStrGri_CopyFrom   : TStringGrid      ;
                                     PStrGri_CopyTo     : TStringGrid     );


implementation

procedure P_EmptyGrid ( PStrGri_EmptyGrid : TStringGrid );


const
  L_EMPTY_CELL = '';
var
   LByt_Across, LByt_Down : byte;
begin
  with PStrGri_EmptyGrid do
    begin
      if VisibleRowCount = 1
        then
          for LByt_Across := 1 to 9 do
           cells[LByt_Across,1] := L_EMPTY_CELL
        else
           for LByt_Across := 1 to 9 do
             for LByt_Down := 1 to 9 do
               cells[LByt_Down,LByt_Across] := L_EMPTY_CELL;



    end; // with PStrGri_EmptyGrid //

end; // P_EmptyGrid //

procedure P_DisplayNumbersInHeader (PStrGri_Display : TStringGrid);
var
  LByt_HowManyColumns, LByt_HowManyRows,
  LByt_Across        , LByt_Down       : byte;
begin
  LByt_HowManyColumns := PStrGri_Display.VisibleColCount;
  LByt_HowManyRows    := PStrGri_Display.VisibleRowCount;

  for LByt_Across := 1 to LByt_HowManyColumns do
    PStrGri_Display.Cells[LByt_Across,0] := inttostr(LByt_Across);

  for LByt_Down := 1 to LByt_HowManyRows do
    PStrGri_Display.Cells[0,LByt_Down] := inttostr(LByt_Down);
end; // P_DisplayNumbersInHeader //



procedure P_CopyContents ( PStrGri_CopyFrom   : TStringGrid;
                           PStrGri_CopyTo: TStringGrid );
var
  LByt_Across, LByt_Down : byte;
begin
  for LByt_Across := 1 to 9 do
    for LByt_Down := 1 to 9 do
      PStrGri_CopyTo  .cells[LByt_Down,LByt_Across] :=
      PStrGri_CopyFrom.cells[LByt_Down,LByt_Across];

end; // P_CopyContents //



//procedure P_FindTheCorrectPosition ( PStrGri_CorrectPosition : TStringGrid;
          //                           PStr_CellContents       : string);


//procedure P_SelectMenuItem         ( PMenIte_Choice    : TMenuItem);
{procedure P_FindTheCorrectPosition ( PStrGri_CorrectPosition : TStringGrid);


begin
  with PStrGri_CorrectPosition do
    begin



    end; // with PStrGri_CorrectPosition //
  { var
 	       nCol : integer;
 	       nRow : integer;
              begin
 	       for nCol := 1 to StringGrid1.ColCount - 1 do
 	         begin
 		   nRow := StringGrid1.Cols[nCol].IndexOf('47');
 		   if (nRow > -1) then
 		     ShowMessage('Found it at Column: ' + IntToStr(nCol) +
                      ' and Row: ' + IntToStr(nRow));
 	         end;
              end;

            }
end; // P_FindTheCorrectPosition //  }

{procedure P_ShowAndHideStringGrids( PStrGri_Show : TStringGrid;
                                    PStrGri_Hide : TStringGrid );
const
   L_PUZZLEGRID = 1; L_EMPTYGRID = 4;
var
   LByt_Grid : byte;
begin
  with PStrGri_Show do
    begin
      LByt_Grid := Tag;
        case LByt_Grid of

          L_PUZZLEGRID : .Visible := true; // Show Puzzle Grid //

          L_EMPTYGRID :
            begin
              .top := 32; // move EmptyGrid to where Puzzle Grid is //
               P_DisplayNumbersInHeader  (StrGri_EmptyGrid);
               .visible := true;
            end; // L_EMPTYGRID //

        end; // case LByt_Grid //
    end; // with PStrGri_Show //
  with PStrGri_Hide do
    LByt_Grid := Tag;
      case LByt_Grid of
        L_PUZZLEGRID : .visible := false; // Hide Puzzle Grid //

        L_EMPTYGRID :
          begin
            .top := 275; // Move EmptyGrid to its Original Position //
            .visible := false; // Hide Empty Grid //
          end; // L_EMPTYGRID //
      end; // case LByt_Grid //
end; // P_ShowAndHideStringGrids //  }



end.

