program p_sudoku;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, f_sudoku, u_sudoku_constants, u_components, u_text_file,
  u_randomize_grid, u_colour_grid, f_dialog, u_registry, f_sudoku_key_and_grid,
  u_bitmap, u_stopwatch;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TFor_Sudoku, For_Sudoku);
  Application.CreateForm(TFor_Dialog, For_Dialog);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

