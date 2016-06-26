unit u_randomize_grid;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls, Menus, ExtCtrls, FileCtrl, StrUtils, Math;

type
  TArrSinByt_Result = array [1..9]      of byte;
  TArrDubByt_Result = array [1..9,1..9] of byte;

procedure P_CreateANewRandomGrid;

procedure P_ReadCSVFileWithArray (PStr_FileName     : string;
                              var PArrDubByt_Result : TArrDubByt_Result;
                                  PByt_AddNumber    : byte = 0);
const
  G_SOLUTION_CSV           = 'sudoku_solution.csv';

var
  GArrDubByt_Solution  : TArrDubByt_Result;
  GArrSinByt_FirstLine : TArrSinByt_Result;

implementation

procedure P_CreateANewRandomGrid;

 var
  LArrSinByt_List  : TArrSinByt_Result;

  LByt_Across,LByt_Down  : byte;
{ -----------------------------------------------------------------------------}

{ -----------------------------------------------------------------------------}
  function FArrSinByt_RandomiseList : TArrSinByt_Result;
   var
     LByt_Across              : byte;

     LArrSinByt_RandomList     : TArrSinByt_Result;
{ -----------------------------------------------------------------------------}
   procedure P_ShuffleTheArray ( var PArrByt_List : TArrSinByt_Result );
   var
     LByt_RangeLoop,LByt_RandomNumber, LByt_TempNumber : byte;
   begin
     randomize;
     for LByt_RangeLoop := 9 downto 2 do
       begin
         LByt_RandomNumber := random(LByt_RangeLoop) + 1;
         if (PArrByt_List[LByt_RangeLoop] <> PArrByt_List[LByt_RandomNumber])
           then
             begin
               LByt_TempNumber := PArrByt_List[LByt_RangeLoop];
               PArrByt_List[LByt_RangeLoop] := PArrByt_List[LByt_RandomNumber];
               PArrByt_List[LByt_RandomNumber] := LByt_TempNumber
             end; // If //
       end; // For //
   end; // P_RandomShuffle //
{ -----------------------------------------------------------------------------}
   begin

   // Initialise List //
      for LByt_Across := 1 to 9 do
       LArrSinByt_RandomList[LByt_Across] := LByt_Across;

  // Create a random list of numbers (1 - 9) //
     P_ShuffleTheArray ( LArrSinByt_RandomList );


  // for LByt_Across := 1 to 9 do
     Result := LArrSinByt_RandomList;

   end; // FArrSinByt_RandomiseList //
{ -----------------------------------------------------------------------------}
  procedure P_FindTheSameNumberInGrid( PArrSinByt_SameNumber,
                                       PArrSinByt_RandomNumber
                                                  : TArrSinByt_Result);
  var
    LByt_Count,LByt_Across,LByt_Down : byte;

  begin
   for LByt_Count := 1 to 9 do
     for LByt_Across := 1 to 9 do
       for LByt_Down   := 1 to 9 do
         if GArrDubByt_Solution [LByt_Across,LByt_Down] = PArrSinByt_SameNumber
                                                                      [LByt_Count]
           then
             GArrDubByt_Solution [LByt_Across,LByt_Down] :=
                                              PArrSinByt_RandomNumber[LByt_Count];

  end; // P_FindTheSameNumberInGrid //
{ -----------------------------------------------------------------------------}

begin

  P_ReadCSVFileWithArray ( G_SOLUTION_CSV,GArrDubByt_Solution,10);


{ Copy First Line From Sudoku Grid Array }
  for LByt_Across := 1 to 9 do
    GArrSinByt_FirstLine[LByt_Across] := GArrDubByt_Solution[1,LByt_Across];

  for LByt_Across := 1 to 9 do
    LArrSinByt_List[LByt_Across] := FArrSinByt_RandomiseList[LByt_Across];


  P_FindTheSameNumberInGrid( GArrSinByt_FirstLine, LArrSinByt_List );


end; // P_CreateANewRandomGrid //
procedure P_ReadCSVFileWithArray (PStr_FileName     : string;
                                  var PArrDubByt_Result : TArrDubByt_Result;
                                  PByt_AddNumber : byte = 0);
 var
   LStr_PathAndFilename ,
   LStr_Line            : string;

   LByt_Row,LByt_Col,
   LByt_Comma,LByt_Value    : byte;

   LTexFil_FileName         : TextFile;
 begin
   LStr_PathAndFilename := GetCurrentDir + '\' + PStr_FileName;

   AssignFile(LTexFil_FileName,PStr_FileName);
   reset(LTexFil_FileName);

   LByt_Row := 1;

   while not eof(LTexFil_FileName) do
     begin
       LByt_Col := 1;
       readln(LTexFil_FileName,LStr_Line);
         repeat
           LByt_Comma :=  pos(',',LStr_Line);
           LByt_Value := strtoint(copy(LStr_Line,1,LByt_Comma - 1))+PByt_AddNumber;
           delete(LStr_Line,1,LByt_Comma);
           PArrDubByt_Result[LByt_Row,LByt_Col] := LByt_Value;
           inc(LByt_Col);
         until pos(',',LStr_Line) = 0;
           PArrDubByt_Result[LByt_Row,LByt_Col] := strtoint(LStr_Line)+PByt_AddNumber;

           inc(LByt_Row);
     end; // of while //

     closefile(LTexFil_FileName);
     deletefile (LStr_PathAndFilename);
  end; // P_ReadCSVFileWithArray //

end.

