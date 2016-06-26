unit u_colour_grid;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls, Menus, ExtCtrls, FileCtrl, StrUtils, Math;


type
   // Used in the function FCol_ShowCellColour //
  TArrSinCol_Result    = array [ 1..9        ] of TColor;

  // Used in the variable GArrDubCol_ShowCellColours //
  TArrDubCol_Result    = array [ 1..9 , 1..9 ] of TColor;

  TArrSinByt_Result    = array [ 1..3        ] of byte;

  // Used in the variable GArrDubStr_Store_E_S_Or_D  //
  TArrDubStr_Result    = array [ 1..9 , 1..9 ] of string;

  function FCol_ShowCellColour : TArrSinCol_Result;


const
  G_EMPTY_COLOUR =  1 ; G_SAME_COLOUR =  2 ; G_DIFFERENT_COLOUR =  3 ;
  G_EMPTY_CELL   = 'E'; G_SAME_CELL   = 'S'; G_DIFFERENT_CELL   = 'D';


var

  GArrDubCol_ShowCellColours      : TArrDubCol_Result;
  GArrDubStr_Store_E_S_Or_D       : TArrDubStr_Result;


implementation
uses u_registry,u_sudoku_constants;

function FCol_ShowCellColour : TArrSinCol_Result;
begin
  Result[1] := clWhite;

  if FStr_SendToRegistry ( 'Read'          ,
                            GSTR_SETTINGS  ,
                           'Tutor'         ,
                           ''              ) = 'No'
  then
    Result[2] := clWhite
  else
    Result[2] := clLime;

  Result[3] := clRed;
end; // FCol_ShowCellColour //



end.

