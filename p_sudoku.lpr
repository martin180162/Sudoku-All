program p_sudoku;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, f_sudoku, u_sudoku_constants, u_components, u_text_file,
  u_randomize_grid,u_colour_grid;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TFor_Sudoku, For_Sudoku);
  Application.Run;
end.

