unit f_sudoku;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, Menus, ExtCtrls, Buttons, Registry,


  f_dialog,
  u_sudoku_constants,
  u_text_file,
  u_components,
  u_randomize_grid,
  //u_colour_grid,
  u_registry,

  SsStopwatch;



type

   TArrSinStr_Result = array [ 1..9 ]        of string;
   TArrDouStr_Result = array [ 1..9 , 1..9 ] of string;

   TArrSinCha_Reg    = array [1..9] of char;



  type

  { TFor_Sudoku }


  TFor_Sudoku = class(TForm)
    But_StartStopWatch: TButton;
    But_EndStopWatch: TButton;
    But_SudokuNewPuzzle: TButton;
    CheBox_ShowSolution: TCheckBox;
    ComBox_Ratings: TComboBox;

  { -------------------------------------------------------------------------- }
  { ------------------------------- Components-------------------------------- }
  { --------------------------------- Start ---------------------------------- }
  { -------------------------------------------------------------------------- }
    GroBox_PuzzleGrid         : TGroupBox;
    GroBox_Selection: TGroupBox;

    GroBox_OldNewGrid  : TGroupBox;
      Lab_Line1          : TLabel;
      Lab_OldGrid        : TLabel;
      Lab_NewGrid        : TLabel;
      Lab_Line2          : TLabel;
      Lab_NewGridHelp    : TLabel;
      Lab_NewGridHelp1   : TLabel;


    GroBox_Stopwatch   : TGroupBox;
      Tim_StopWatch      : TTimer;
      Lab_ShowStopWatch  : TLabel;





      Lab_Puzzle              : TLabel;
      Lab_StopWatch: TLabel;
      MenIte_Sudoku_File_Seperater2: TMenuItem;
      StrGri_DragToPuzzle: TStringGrid;
      StrGri_SudokuPuzzle     : TStringGrid;
  { -------------------------------------------------------------------------- }
    GroBox_SolutionGrid       : TGroupBox;
      Lab_Solution            : TLabel;
      StrGri_SudokuSolution   : TStringGrid;
      ColDia_CellAndText      : TColorDialog;
  { -------------------------------------------------------------------------- }
    GroBox_ColourGrid         : TGroupBox;
      Lab_ColourGrid          : TLabel;
      StrGri_SudokuColourGrid : TStringGrid;
  { -------------------------------------------------------------------------- }
  { ------------------------------- Components ------------------------------- }
  { ---------------------------------- End ----------------------------------- }

  { -------------------------------------------------------------------------- }
  { ---------------------------- Menu Items ---------------------------------- }
  { --------------------------     Start     --------------------------------- }
  { -------------------------------------------------------------------------- }
    MaiMen_Sudoku                         : TMainMenu;
      MenIte_Sudoku_Settings              : TMenuItem;
        MenIte_Sudoku_Select              : TMenuItem;
          MenIte_Sudoku_Select_1To9       : TMenuItem;
          MenIte_Sudoku_Select_AToI       : TMenuItem;
          MenIte_Sudoku_Select_Seperater1 : TMenuItem;
          MenIte_Sudoku_Select_Characters : TMenuItem;
          MenIte_Sudoku_Select_Colours    : TMenuItem;
          MenIte_Sudoku_Select_Images     : TMenuItem;
        MenIte_Sudoku_File                : TMenuItem;
          MenIte_Sudoku_File_Save         : TMenuItem;
          MenIte_Sudoku_File_Load         : TMenuItem;
          MenIte_Sudoku_File_Seperater1   : TMenuItem;
          MenIte_Sudoku_File_Close        : TMenuItem;

    ssStopWatch1 : TssStopWatch;
  { -------------------------------------------------------------------------- }
  { --------------------------- Menu Items ----------------------------------- }
  { --------------------------     End     - --------------------------------- }
  { -------------------------------------------------------------------------- }
    procedure But_EndStopWatchClick(Sender: TObject);
    procedure But_StartStopWatchClick(Sender: TObject);
    procedure ComBox_RatingsChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseEnter(Sender: TObject);
  { -------------------------------------------------------------------------- }
  { -------------------- Select Menu ( 1 - 9 ) | ( A - I ) ------------------- }
  { ---------------- ( Characters ) | ( Colours ) | ( Images ) --------------- }
  { -------------------------------------------------------------------------- }
    procedure MenIte_Sudoku_SelectClick(Sender: TObject);
  { -------------------------------------------------------------------------- }
  { -------------------- File Menu ( Save | Load | Close ) ------------------- }
  { -------------------------------------------------------------------------- }
    procedure MenIte_Sudoku_FileClick(Sender: TObject);
  { -------------------------------------------------------------------------- }
  { --------------------------- Menu Events ---------------------------------- }
  { ------------------------- End  ( Sender ) -------------------------------- }
  { -------------------------------------------------------------------------- }

  { -------------------------------------------------------------------------- }
  { ----- ( SudokuPuzzle StringGrid :- DragDrop | DragOver and MouseDown )---- }
  { -------------------------------------------------------------------------- }

    procedure StrGri_SudokuPuzzleDragDrop(Sender, Source: TObject;
              X,Y: Integer );

    procedure StrGri_SudokuPuzzleDragOver(Sender, Source: TObject;
              X,Y: Integer; State: TDragState; var Accept: Boolean);

    procedure StrGri_SudokuPuzzleMouseDown(Sender: TObject;
              Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  { -------------------------------------------------------------------------- }
  { -------------- ( SudokuPuzzle and SudokuSolution StringGrids ) ----------- }
  { ------------------------------( DrawCell )-------------------------------- }
  { -------------------------------------------------------------------------- }

    procedure StrGri_DrawCell(Sender: TObject; aCol,
              aRow: Integer; aRect: TRect; aState: TGridDrawState);

  { -------------------------------------------------------------------------- }
  { ------------------------- ( Rating ComboBox ) ---------------------------- }
  { -------------------------------------------------------------------------- }

    procedure ComBox_RatingsClick(Sender: TObject);

  { -------------------------------------------------------------------------- }
  { ------------------------- ( New Puzzle Button ) -------------------------- }
  { -------------------------------------------------------------------------- }

    procedure But_SudokuNewPuzzleClick(Sender: TObject);

  { -------------------------------------------------------------------------- }
  { ----------- ( DragToPuzzle StringGrid :- DragOver and MouseDown ) -------- }
  { -------------------------------------------------------------------------- }

     procedure StrGri_DragToPuzzleDragOver(Sender, Source: TObject;
               X,Y: Integer; State: TDragState; var Accept: Boolean);

     procedure StrGri_DragToPuzzleMouseDown(Sender: TObject;
               Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  { -------------------------------------------------------------------------- }
  { ------------------------- ( Show Solution Checkbox ) --------------------- }
  { -------------------------------------------------------------------------- }

    procedure CheBox_ShowSolutionClick(Sender: TObject);
    procedure Tim_StopWatchTimer(Sender: TObject);

  { -------------------------------------------------------------------------- }

  private
    { private declarations }
      function FByt_CountSelect           : byte;
      function FStr_NumOrChar             : string;
      function FBoo_SameOldNewChar        : boolean;
    { ------------------------------------------------------------------------ }

      function FStr_RatingsPath           ( PByt_FindRatingsIndex : byte )
                                                                  : string;

      function FStr_RatingSaveGrids       ( PStr_NumOrChar        : string )
                                                                  : string;

      function FStr_CheckCellContents     ( PStrGri_CellContents  : TStringGrid )
                                                                  : string;

      function FStr_FirstAndLastCharacter ( PStr_Selection        : string )
                                                                  : string;


    { ------------------------------------------------------------------------ }
      //procedure P_SaveAnArrayToRegistry;


      procedure P_NewPuzzle;
      procedure P_MakeVisibleOrNot;
      procedure P_DisplayGrid;
      procedure P_SaveRatings;
      procedure P_SaveSudokuSolution;
      procedure P_WriteToRegistry;
      procedure P_ShownCellsInPuzzleGrid;
      procedure P_CreatePathsForRegistry;
      procedure P_CreateSaveGridsDirectory;
      procedure P_CheckForNumbersOrCharacters;
    { ------------------------------------------------------------------------ }
      procedure P_DisplayOldAndNewGrid ( PStr_Selection           : string );
      procedure P_FillSmallGridWith    ( PStr_Selection           : string );
      procedure P_ShowSolution        ( PStr_ShowSolution        : string = '');
      procedure P_NewFirstCharacter     ( PStr_NumOrChar           : string );
      procedure P_RandomizeSolutionGrid   ( PStr_Selection         : string );
    { ------------------------------------------------------------------------ }
      procedure P_PuzzleGrid              ( PCha_Files         : char     ;
                                            PByt_RatingsIndex  : byte )   ;
                                                                 overload ;

      procedure P_CheckPuzzleGrid         ( PInt_DestCol       ,
                                            PInt_DestRow       : integer);

      procedure P_FillGridWithColour      ( PStrGri_CellColour : TStringGrid;
                                            PCol_CellColour    : TColor    );

      procedure P_ColourCellsInSameCell   ( PStrGri_CorrectGrid : TStringGrid;
                                            PStrGri_CheckGrid   : TStringGrid );



    { ------------------------------------------------------------------------ }
      procedure P_DrawCell             ( PCha_DrawCell          : char         ;
                                         PStrGri_CellTextOrGrid : TStringGrid  ;
                                     var PInt_ACol, PInt_ARow   : integer      ;
                                     var PRec_ARect             : TRect       );
    { ------------------------------------------------------------------------ }

      procedure P_PuzzleGrid           ( PCha_Files        : char          ;
                                         PByt_RatingsIndex : byte          ;
                                         PStrGri_Grid1     : TStringgrid   ;
                                         PStrGri_Grid2     : TStringgrid   ;
                                         PStrGri_Grid3     : TStringgrid ) ;                                                                overload;
                                                                  overload ;


    { ------------------------------------------------------------------------ }

  public
    { public declarations }

 end; // TFor_Sudoku = class(TForm) //

var
  For_Sudoku : TFor_Sudoku;
  GInt_SourceCol      ,
  GInt_SourceRow      ,
  GInt_PreviousRating : integer;


implementation
  uses u_colour_grid;

{$R *.lfm}

{ TFor_Sudoku }

  { -------------------------------------------------------------------------- }
  { -------------------------- Menu ( Events ) ------------------------------- }
  { --------------------------     Start     --------------------------------- }
  { -------------------------------------------------------------------------- }
    procedure TFor_Sudoku.ComBox_RatingsChange(Sender: TObject);
    var
      LByt_ButtonSelected : byte;
      LInt_LeftRight      ,
      LInt_UpDown         : integer;
    begin
      LInt_LeftRight := For_Sudoku.Left + 47;
      LInt_UpDown    := For_Sudoku.Top  + 150;
      LByt_ButtonSelected := MessageDlgPos('Choose a Different Rating',
                            mtInformation,mbYesNo,0,LInt_LeftRight,LInt_UpDown);

      if LByt_ButtonSelected = mrYes
        then
          P_ShownCellsInPuzzleGrid
        else
          ComBox_Ratings.Text := ComBox_Ratings.Items.Strings[GInt_PreviousRating];
    end; // ComBox_RatingsChange //

procedure TFor_Sudoku.But_StartStopWatchClick(Sender: TObject);
begin
 ssStopWatch1.Start;
end;

procedure TFor_Sudoku.But_EndStopWatchClick(Sender: TObject);
begin
//  ssStopWatch1.Stop;
end;

    procedure TFor_Sudoku.FormMouseEnter(Sender: TObject);
    var
      LByt_Across              ,
      LByt_Number              ,
      LByt_Down                ,
      LByt_FirstChar           ,
      LByt_SolutionCell        ,
      LByt_RatingsIndex        ,
      LByt_ButtonSelected      : byte;

      LInt_LeftRight      ,
      LInt_UpDown         : integer;

      LCha_FirstChar           ,
      LCha_LastChar            : char;

      LStr_ShowSolution        ,
      LStr_WrapAround          ,
      LStr_EnteredFirstChar    ,
      LStr_NumOrChar           ,
      LStr_ChangeTo            : string;

    begin
      P_ShowSolution        ( LStr_ShowSolution        );

      if FByt_CountSelect = GBYT_NUMBERS_ONLY
        then
          begin
            MenIte_Sudoku_Select_Seperater1.Visible := false;

            if FStr_SendToRegistry ( 'Read'                ,
                                      GSTR_SETTINGS        ,
                                     'Number Or Character' ,
                                     ''      ) = 'Char'
              then
                begin
                  FStr_SendToRegistry ( 'Write'               ,
                                         GSTR_SETTINGS        ,
                                        'Number Or Character' ,
                                        'Num'         );
                  P_DisplayGrid

                end;

            MenIte_Sudoku_Settings.Caption := 'Settings :- '
                                           +  FStr_FirstAndLastCharacter
                                           ( 'Num' );

            P_FillSmallGridWith ( 'Num' );

            MenIte_Sudoku_Select.Visible := false;


          end // GBYT_NUMBERS_ONLY //
        else
          begin
            MenIte_Sudoku_Select_Seperater1.Visible := true;
            MenIte_Sudoku_Select.Visible := true;

            LStr_EnteredFirstChar := FStr_SendToRegistry
                                  ( 'Read'                    ,
                                     GSTR_SELECTION_A_TO_I    ,
                                    'Entered First Character' ,
                                    '' )                      ;

           P_DisplayOldAndNewGrid ( LStr_EnteredFirstChar );
         end; // Characters //
   end; // FormMouseEnter //
  { -------------------------------------------------------------------------- }
  { -------------------- Select Menu ( 1 - 9 ) | ( A - I ) ------------------- }
  { -------------------------------------------------------------------------- }

    procedure TFor_Sudoku.MenIte_Sudoku_SelectClick(Sender: TObject);
    var
      LByt_ButtonSelected : byte;

      LCha_NewFirstChar   ,
      LCha_OldFirstChar   : char;

      LInt_LeftRight      ,
      LInt_UpDown         : integer;

      LStr_ChangeTo         ,
      LStr_EnteredFirstChar ,
      LStr_NumOrChar        : string;
    begin
       LStr_EnteredFirstChar := FStr_SendToRegistry
                             ( 'Read'                    ,
                                GSTR_SELECTION_A_TO_I    ,
                               'Entered First Character' ,
                               '' )                      ;

       LStr_NumOrChar        := FStr_SendToRegistry
                             ( 'Read'                ,
                                GSTR_SETTINGS        ,
                               'Number Or Character' ,
                               ''                  ) ;

       case LStr_EnteredFirstChar of
         'No' : if LStr_NumOrChar = 'Num'
                  then
                    begin // LStr_NumOrChar = 'Num' //
                      MenIte_Sudoku_Select_1To9.Enabled := false;
                      MenIte_Sudoku_Select_AToI.Enabled := true;
                    end // LStr_NumOrChar = 'Num' //
                  else
                    begin // LStr_NumOrChar = 'Char' //
                      MenIte_Sudoku_Select_AToI.Enabled := false;
                      MenIte_Sudoku_Select_1To9.Enabled := true;
                    end; // LStr_NumOrChar = 'Char' //

         'Yes' : For_Sudoku.caption := 'Sudoku :- Yes';

                {  if LStr_NumOrChar = 'Num'
                  then
                    MenIte_Sudoku_Select_1To9.Enabled := false;
                  else
                    begin // LStr_NumOrChar = 'Char' //
                      MenIte_Sudoku_Select_AToI.Enabled := true;
                      MenIte_Sudoku_Select_1To9.Enabled := true;
                    end; // LStr_NumOrChar = 'Char' //   }
       end; //  case LStr_EnteredFirstChar //

      LInt_LeftRight := For_Sudoku.Left + 49;
      LInt_UpDown    := For_Sudoku.Top  + 150;

      P_MakeVisibleOrNot;

      if Sender = MenIte_Sudoku_Select_1To9
        then
          begin


            LByt_ButtonSelected := MessageDlgPos('Change to  '
                              + FStr_FirstAndLastCharacter ( 'Num' ),
                                   mtInformation,mbYesNo,0,LInt_LeftRight,LInt_UpDown);

            if LByt_ButtonSelected = mrYes
              then
                begin
                  P_EmptyGrid  ( StrGri_SudokuPuzzle );

                  MenIte_Sudoku_Settings.Caption := 'Settings :- '
                                                  +  FStr_FirstAndLastCharacter ( 'Num' );

                  FStr_SendToRegistry ( 'Write'               ,
                                         GSTR_SETTINGS        ,
                                        'Number Or Character' ,
                                        'Num'        )        ;

                  P_DisplayGrid;
                end; // LByt_ButtonSelected = mrYes  //

          end; // Sender = MenIte_Sudoku_Select_1To9 //

      if Sender = MenIte_Sudoku_Select_AToI
        then
          begin
            GroBox_Selection         .Top       := 272;

            FStr_SendToRegistry ( 'Write'         ,
                                  GSTR_SELECTION ,
                                 'Numbers Only'  ,
                                 'No'          ) ;

            LStr_EnteredFirstChar := FStr_SendToRegistry
                                  ( 'Read'                    ,
                                     GSTR_SELECTION_A_TO_I    ,
                                    'Entered First Character' ,
                                    '' )                      ;

            LCha_NewFirstChar := FStr_FirstAndLastCharacter ( 'New' )[4];
            LCha_OldFirstChar := FStr_FirstAndLastCharacter ( 'Old' )[4];

            if LStr_EnteredFirstChar = 'Yes'
              then
                LByt_ButtonSelected := MessageDlgPos('Change to '
                                    + 'New :- '
                                    + FStr_FirstAndLastCharacter ( 'New' ),
                            mtInformation,mbYesNo,0,LInt_LeftRight,LInt_UpDown)
              else
                 LByt_ButtonSelected := MessageDlgPos('Change to '
                                      + FStr_FirstAndLastCharacter ( 'Old' ),
                            mtInformation,mbYesNo,0,LInt_LeftRight,LInt_UpDown);

            if LByt_ButtonSelected = mrYes
             then
               begin
                 if LStr_EnteredFirstChar = 'Yes'
                   then
                     begin
                       LByt_ButtonSelected := MessageDlgPos('Changing to the New'
                                      + chr(13)
                                      + '       '
                                      + FStr_FirstAndLastCharacter ( 'New' )
                                      + ' Grid',
                            mtInformation,[mbOK],0,LInt_LeftRight,LInt_UpDown);


                       MenIte_Sudoku_Settings.Caption := 'Settings :- '
                                           +  FStr_FirstAndLastCharacter
                                           (  'New'  );



                       FStr_SendToRegistry ( 'Write'                   ,
                                              GSTR_SELECTION_A_TO_I    ,
                                             'Entered First Character' ,
                                             'No' )                    ;

                       FStr_SendToRegistry ( 'Write'                  ,
                                              GSTR_SELECTION_A_TO_I    ,
                                             'Old First Character'     ,
                                              LCha_NewFirstChar )      ;
                     end; // LStr_EnteredFirstChar = 'Yes' //

                 P_EmptyGrid  ( StrGri_SudokuPuzzle );

                 MenIte_Sudoku_Settings.Caption := 'Settings :- '
                                                +  FStr_FirstAndLastCharacter ( 'Old' );

                 FStr_SendToRegistry ( 'Write'               ,
                                        GSTR_SETTINGS        ,
                                       'Number Or Character' ,
                                       'Char'        )       ;

                 P_DisplayGrid;
               end // LByt_ButtonSelected = mrYes //
             else
               begin
                 if LByt_ButtonSelected = mrYes
                   then
                     if LStr_EnteredFirstChar = 'Yes'
                       then
                         begin
                         LByt_ButtonSelected := MessageDlgPos('Reverting back to the Old'
                                              + chr(13)
                                              + '       '
                                              + FStr_FirstAndLastCharacter ( 'Old' )
                                              + ' Grid',
                                                 mtInformation,[mbOK],0,LInt_LeftRight,LInt_UpDown);

                         MenIte_Sudoku_Settings.Caption := 'Settings :- '
                                                         +  FStr_FirstAndLastCharacter
                                                           (  'Old'  );


                         FStr_SendToRegistry ( 'Write'                   ,
                                        GSTR_SELECTION_A_TO_I    ,
                                       'Entered First Character' ,
                                       'No' )                    ;

                         FStr_SendToRegistry ( 'Write'                   ,
                                        GSTR_SELECTION_A_TO_I    ,
                                       'New First Character'     ,
                                        LCha_OldFirstChar )      ;

                         end;

                 MenIte_Sudoku_Settings.Caption := 'Settings :- '
                                                +  FStr_FirstAndLastCharacter ( 'Num' );


               end; // LByt_ButtonSelected = mrNo //
          end; // Sender = MenIte_Sudoku_Select_AToI //
    end; // MenIte_Sudoku_SelectClick //

  { -------------------------------------------------------------------------- }
  { -------------------- File Menu ( Save | Load | Close ) ------------------- }
  { -------------------------------------------------------------------------- }

    procedure TFor_Sudoku.MenIte_Sudoku_FileClick(Sender: TObject);
    var
      LByt_RatingsIndex ,
      LByt_Across       ,
      LByt_Down         : byte;
    begin
      LByt_RatingsIndex := ComBox_Ratings.ItemIndex + 1;

      if Sender = MenIte_Sudoku_File_Save
        then
          P_PuzzleGrid ( GCHA_SAVE_FILES         ,
                         LByt_RatingsIndex       ,
                         StrGri_SudokuPuzzle     ,
                         StrGri_SudokuColourGrid ,
                         StrGri_SudokuSolution  );

      if Sender = MenIte_Sudoku_File_Load
        then
          begin
            P_PuzzleGrid ( GCHA_LOAD_FILES         ,
                           LByt_RatingsIndex       ,
                           StrGri_SudokuPuzzle     ,
                           StrGri_SudokuColourGrid ,
                           StrGri_SudokuSolution  );

            P_FillGridWithColour ( StrGri_SudokuPuzzle
                                   ,u_colour_grid.G_EMPTY_COLOUR );

            P_ColourCellsInSameCell ( StrGri_SudokuPuzzle ,
                                       StrGri_SudokuSolution );

            for LByt_Across := 1 to 9 do
              for LByt_Down   := 1 to 9 do
                if StrGri_SudokuColourGrid.Cells[LByt_Down,LByt_Across] =
                  u_colour_grid.G_DIFFERENT_CELL
                    then
                      u_colour_grid.GArrDubCol_ShowCellColours[LByt_Across,LByt_Down] :=
                      u_colour_grid.FCol_ShowCellColour[u_colour_grid.G_DIFFERENT_COLOUR];
          end;


      if Sender = MenIte_Sudoku_File_Close
        then
          For_Sudoku.Close;

    end; // MenIte_Sudoku_FileClick //


  { -------------------------------------------------------------------------- }
  { -------------------------- Menu ( Events ) ------------------------------- }
  { ---------------------------     End     ---------------------------------- }
  { -------------------------------------------------------------------------- }

  { ========================================================================== }

  { -------------------------------------------------------------------------- }
  { ----------------------- Components ( Events ) ---------------------------- }
  { ----------------------------- Form Create ---------------------------------}
  { -------------------------------------------------------------------------- }

    procedure TFor_Sudoku.FormCreate(Sender: TObject);
    var
      LStr_EnteredFirstChar ,
      LStr_NumOrChar        : string;
    begin
     // Lab_ShowStopWatch.Caption  := TimeToStr(ssStopWatch.ssStopWatch1.ElapsedTime);
      if not FBoo_PathExists ( GSTR_SETTINGS )
        then
          begin
            P_CreatePathsForRegistry;
            P_WriteToRegistry;
          end;

      if FByt_CountSelect = GBYT_NUMBERS_ONLY
        then
          begin // NUMBERS ONLY //
            MenIte_Sudoku_Select_Seperater1.Visible := false;
            MenIte_Sudoku_Select           .Visible := false;
          end   // NUMBERS ONLY //
        else
          begin // NUMBERS & CHARACTERS //
            LStr_EnteredFirstChar := FStr_SendToRegistry
                                  ( 'Read'                    ,
                                     GSTR_SELECTION_A_TO_I    ,
                                    'Entered First Character' ,
                                    '' )                      ;

            LStr_NumOrChar        := FStr_SendToRegistry
                                  ( 'Read'                ,
                                     GSTR_SETTINGS        ,
                                    'Number Or Character' ,
                                    ''                  ) ;

            P_DisplayOldAndNewGrid ( LStr_EnteredFirstChar );

            MenIte_Sudoku_Select_Seperater1.Visible := true;
            MenIte_Sudoku_Select           .Visible := true;
          end;  // NUMBERS & CHARACTERS //



        P_NewPuzzle;

   end; // FormCreate //

  { -------------------------------------------------------------------------- }
  { ----- ( SudokuPuzzle StringGrid :- DragDrop | DragOver and MouseDown )---- }
  { -------------------------------------------------------------------------- }

   procedure TFor_Sudoku.StrGri_SudokuPuzzleDragDrop(Sender, Source: TObject;
             X,Y: Integer);
   var
     LInt_DestCol, LInt_DestRow : integer;

   begin
     LInt_DestCol := 0; LInt_DestRow := 0;

     StrGri_SudokuPuzzle.MouseToCell(X,Y,LInt_DestCol,LInt_DestRow);


     if StrGri_DragToPuzzle.Cells[ GInt_SourceCol , GInt_SourceRow ] =
        StrGri_SudokuSolution .Cells[ LInt_DestCol,LInt_DestRow ]
        then
          begin
            StrGri_SudokuColourGrid.Cells[ LInt_DestCol,LInt_DestRow ] :=
            ' ';

            u_colour_grid.GArrDubCol_ShowCellColours[LInt_DestRow,LInt_DestCol] :=
            u_colour_grid.FCol_ShowCellColour[u_colour_grid.G_SAME_COLOUR];
          end
        else
          begin
            StrGri_SudokuColourGrid.Cells[ LInt_DestCol,LInt_DestRow ] :=
            u_colour_grid.G_DIFFERENT_CELL;

            u_colour_grid.GArrDubCol_ShowCellColours[LInt_DestRow,LInt_DestCol] :=
            u_colour_grid.FCol_ShowCellColour[u_colour_grid.G_DIFFERENT_COLOUR];
          end;

   { ----------------------------------------------------------------- }
   { ---------------------- Ignore Headers --------------------------- }
   { ----------------------------------------------------------------- }
     if ( LInt_DestRow <> 0 ) and (LInt_DestCol <> 0 )
       then
         P_CheckPuzzleGrid ( LInt_DestCol , LInt_DestRow );
   end; // StrGri_SudokuPuzzleDragDrop //

    procedure TFor_Sudoku.StrGri_SudokuPuzzleDragOver(Sender, Source: TObject;
            X, Y: Integer; State: TDragState; var Accept: Boolean);
    begin
      Accept := (Source is TStringGrid);
    end; // StrGri_SudokuPuzzleDragOver //

  procedure TFor_Sudoku.StrGri_SudokuPuzzleMouseDown(Sender: TObject;
            Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  const
    L_SPACE = ' ';
  var
    LInt_DestCol,LInt_DestRow : integer;

    LStr_PuzzleCellContents          ,
    LStr_SolutionCellContents        : string;

  begin
    LInt_DestCol := 0; LInt_DestRow := 0;
    StrGri_SudokuPuzzle.MouseToCell(X,Y,LInt_DestCol,LInt_DestRow);

    LStr_PuzzleCellContents          := StrGri_SudokuPuzzle.Cells
                                     [ LInt_DestCol,LInt_DestRow ];

    LStr_SolutionCellContents        := StrGri_SudokuSolution.Cells
                                     [ LInt_DestCol,LInt_DestRow ];


    if (Button = mbRight)
      then
        begin
          if ( LStr_PuzzleCellContents <> LStr_SolutionCellContents )
            then
              begin
                StrGri_SudokuPuzzle.Cells[ LInt_DestCol,LInt_DestRow ] := L_SPACE;
                StrGri_SudokuColourGrid.Cells[ LInt_DestCol,LInt_DestRow ] := L_SPACE;

                u_colour_grid.GArrDubCol_ShowCellColours[LInt_DestRow,LInt_DestCol] :=
                u_colour_grid.FCol_ShowCellColour[u_colour_grid.G_EMPTY_COLOUR];


              end
            else
              showmessage ('Cannot Delete' + chr(13) // Return //
                                           + 'It is in the right position');
        end; // (Button = mbRight) //
  end; // StrGri_SudokuPuzzleMouseDown //

  { -------------------------------------------------------------------------- }
  { ----------------------- Components ( Events ) ---------------------------- }
  { ----------- SudokuPuzzle and SudokuSolution StringGrids -------------------}
  { -------------------------------------------------------------------------- }
  { ----------------------------- DrawCell ----------------------------------- }
  { -------------------------------------------------------------------------- }

    procedure TFor_Sudoku.StrGri_DrawCell(Sender: TObject; aCol,
              aRow: Integer; aRect: TRect; aState: TGridDrawState);
    var
      LByt_Across ,
      LByt_Down   : byte;
    begin


      if Sender = StrGri_SudokuPuzzle
        then
          begin
            P_DrawCell  ( GCHA_CELLCOLOUR,StrGri_SudokuPuzzle,aCol,aRow,aRect);

            P_DrawCell  ( GCHA_GRIDLINES,StrGri_SudokuPuzzle,aCol,aRow,aRect );
       //   P_DrawCell ( GCHA_TEXTCOLOUR,StrGri_SudokuPuzzle,aCol,aRow,aRect);
          end;

      if Sender = StrGri_SudokuColourGrid
        then
          P_DrawCell ( GCHA_GRIDLINES,StrGri_SudokuColourGrid ,aCol,aRow,aRect);

      if Sender = StrGri_SudokuSolution
        then
          P_DrawCell ( GCHA_GRIDLINES,StrGri_SudokuSolution ,aCol,aRow,aRect);

    end; // StrGri_DrawCell //

  { ========================================================================== }

  { -------------------------------------------------------------------------- }
  { ----------------------- Components ( Events ) ---------------------------- }
  { -------------------------- Rating ComboBox ------------------------------- }
  { ----------------------------- Contains ----------------------------------- }
  { ---------------- ( Easy | Moderate and Challenging ) --------------------- }
  { ------------------------------ Ratings ----------------------------------- }
  { -------------------------------------------------------------------------- }

    procedure TFor_Sudoku.ComBox_RatingsClick(Sender: TObject);
    begin
      GInt_PreviousRating := ComBox_Ratings.ItemIndex;
    end;

  { -------------------------------------------------------------------------- }
  { ----------------------- Components ( Events ) ---------------------------- }
  { ------------------------ New Puzzle Button ------------------------------- }
  { -------------------------------------------------------------------------- }

    procedure TFor_Sudoku.But_SudokuNewPuzzleClick(Sender: TObject);
    var
      LByt_ButtonSelected : byte;
      LInt_LeftRight      ,
      LInt_UpDown         : integer;
    begin
      LInt_LeftRight := For_Sudoku.Left + 49;
      LInt_UpDown    := For_Sudoku.Top  + 150;
      LByt_ButtonSelected := MessageDlgPos('Generate a New Puzzle   ',
                        mtInformation,mbYesNo,0,LInt_LeftRight,LInt_UpDown);



      if LByt_ButtonSelected = mrYes
        then
          P_NewPuzzle;
    end; // But_SudokuNewPuzzleClick //

  { -------------------------------------------------------------------------- }
  { ----------------------- Components ( Events ) ---------------------------- }
  { ---------  DragToPuzzle StringGrid ( DragOver and MouseDown ) -------------}
  { -------------------------------------------------------------------------- }

    procedure TFor_Sudoku.StrGri_DragToPuzzleDragOver(Sender, Source: TObject;
              X,Y: Integer; State: TDragState; var Accept: Boolean);
    begin
      Accept := (Source is TStringGrid);
    end;

    procedure TFor_Sudoku.StrGri_DragToPuzzleMouseDown(Sender: TObject;
              Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    begin
      StrGri_DragToPuzzle.MouseToCell(X,Y,GInt_SourceCol,GInt_SourceRow);

      if (Button = mbLeft)
        then
          { ------------------------------------------------------------------ }
          { ---------------------- Ignore Headers ---------------------------- }
          { ------------------------------------------------------------------ }
            if ( GInt_SourceCol = 0 ) or ( GInt_SourceRow = 0 )
              then
            else
              StrGri_DragToPuzzle.BeginDrag(False,5)
    end; // StrGri_DragToPuzzleMouseDown //

  { ========================================================================== }

  { -------------------------------------------------------------------------- }
  { ----------------------- Components ( Events ) ---------------------------- }
  { ---------------------- Show Solution Checkbox ---------------------------- }
  { -------------------------------------------------------------------------- }
  { ----------------------( Checked :- Show Solution )------------------------ }
  { --------------------( Not Checked :- Hide Solution )---------------------- }
  { -------------------------------------------------------------------------- }

    procedure TFor_Sudoku.CheBox_ShowSolutionClick(Sender: TObject);
    begin
      if CheBox_ShowSolution.Checked
        then
          begin { Show Solution }
            For_Sudoku         .Width   := 522;
            GroBox_SolutionGrid.Visible := true;
          end   { Show Solution }
        else
           begin { Hide Solution }
             For_Sudoku.Width := 285;
             GroBox_SolutionGrid.Visible := false;
           end;  { Hide Solution }
    end; // CheBox_ShowSolutionClick //

procedure TFor_Sudoku.Tim_StopWatchTimer(Sender: TObject);
begin
 // Lab_ShowStopWatch.Caption := TimeToStr(ssStopwatch.ssStopWatch1.ElapsedTime);
end;

  { -------------------------------------------------------------------------- }

  { ************************************* }
  {                  Start                }
  { User Defined Procedures and Functions }
  { ************************************* }

    function TFor_Sudoku.FStr_NumOrChar : string;
    var
      LStr_NumOrChar : string;
    begin
       LStr_NumOrChar :=  FStr_SendToRegistry ( 'Write'               ,
                                                 GSTR_SETTINGS        ,
                                                'Number Or Character' ,
                                                 'Num'        ) ;
       case LStr_NumOrChar of
         'Num'    : Result := 'Num';
         'Char' : Result := 'Char';
       end; // case LStr_NumOrChar //
    end; // FStr_NumOrChar //

    function TFor_Sudoku.FStr_RatingsPath    ( PByt_FindRatingsIndex : byte ) : string;
    const
      L_COMBOX_EASY = 1; L_COMBOX_MODERATE = 2; L_COMBOX_CHALLENGING = 3;
    var
      LStr_RatingsDirectoryPath : string;
      LStr_NumOrChar           : string;

      begin
        LStr_NumOrChar :=  FStr_SendToRegistry ( 'Read'               ,
                                                  GSTR_SETTINGS        ,
                                                 'Number Or Character' ,
                                                  ''        ) ;

        case PByt_FindRatingsIndex of
          L_COMBOX_EASY        : LStr_RatingsDirectoryPath := 'Easy\';
          L_COMBOX_MODERATE    : LStr_RatingsDirectoryPath := 'Moderate\';
          L_COMBOX_CHALLENGING : LStr_RatingsDirectoryPath := 'Challenging\';
        end; // case PByt_FindRatingsIndex //




        case LStr_NumOrChar of
          'Num'    : result := '\save_grids'
                                   +  '\number_grids\'
                                   +  LStr_RatingsDirectoryPath;

          'Char' : result := '\save_grids'
                                   +  '\character_grids\'
                                   +  LStr_RatingsDirectoryPath;

        end; // case FCha_CheckFile ( G_NUMBERS_CHARACTERS_TXT ) //
      end; // FStr_RatingsPath //
    function TFor_Sudoku.FStr_RatingSaveGrids   ( PStr_NumOrChar : string ) : string;
    begin
      showmessage( PStr_NumOrChar);
    end;

    function TFor_Sudoku.FStr_CheckCellContents ( PStrGri_CellContents : TStringGrid ) : string;
    var
      LSet_Numbers   : set of '1'..'9';
      LStr_CopyFromGrid : string[1];
      LStr_NumOrChar           : string;
    begin
      LStr_NumOrChar :=  FStr_SendToRegistry ( 'Read'                ,
                                                GSTR_SETTINGS        ,
                                               'Number Or Character' ,
                                               ''                  ) ;
      LSet_Numbers   := [ '1'..'9' ];

      with PStrGri_CellContents do
        begin
          LStr_CopyFromGrid := cells[1,1];

          if LStr_CopyFromGrid = ''
            then
           //   showmessage('Empty Cell')
            else

          if LStr_CopyFromGrid[1] in LSet_Numbers
            then
              case LStr_NumOrChar of
                'Num'    : Result := 'Num';
                'Char' : Result := 'Char';
              end; // case LStr_NumOrChar //
        end; // with PStrGri_CellContents //
    end; // FCha_CheckCellContents //

    procedure TFor_Sudoku.P_NewPuzzle;
    begin

      if FBoo_DirectoryExists ('\save_grids')
        then
          { Ignore }
        else
          P_CreateSaveGridsDirectory;


      P_SaveSudokuSolution;
      P_SaveRatings;

      P_CreateANewRandomGrid;
      P_CheckForNumbersOrCharacters;

      P_EmptyGrid  ( StrGri_SudokuPuzzle );
      P_FillGridWithColour ( StrGri_SudokuPuzzle,
                             u_colour_grid.G_EMPTY_COLOUR );


      P_DisplayGrid;
    end; // P_NewPuzzle //
    procedure TFor_Sudoku.P_MakeVisibleOrNot;
    var
      LStr_A_To_I_YesOrNo      : string;
      LStr_Characters_YesOrNo  : string;
      LStr_Colours_YesOrNo     : string;
      LStr_Images_YesOrNo      : string;

    begin
       { }
       LStr_A_To_I_YesOrNo := FStr_SendToRegistry ( 'Read'                 ,
                                                     GSTR_SELECTION_A_TO_I ,
                                                    'Shown'                ,
                                                    ''                   ) ;
      case LStr_A_To_I_YesOrNo of
        'Yes' :  MenIte_Sudoku_Select_AToI.Visible := true;


        'No'  :  MenIte_Sudoku_Select_AToI.Visible := false;




      end; // LStr_Characters_YesOrNo //


      LStr_Characters_YesOrNo := FStr_SendToRegistry ( 'Read'                     ,
                                                        GSTR_SELECTION_CHARACTERS ,
                                                       'Shown'                    ,
                                                       ''                       ) ;
      case LStr_Characters_YesOrNo of
        'Yes' : MenIte_Sudoku_Select_Characters.Visible := true;


        'No'  : MenIte_Sudoku_Select_Characters.Visible := false;



      end; // LStr_Characters_YesOrNo //

      LStr_Colours_YesOrNo :=  FStr_SendToRegistry ( 'Read'                  ,
                                                      GSTR_SELECTION_COLOURS ,
                                                     'Shown'                 ,
                                                     ''                    ) ;
      case LStr_Colours_YesOrNo of
        'Yes' : MenIte_Sudoku_Select_Colours   .Visible := true;

        'No'  : MenIte_Sudoku_Select_Colours   .Visible := false;


      end; // LStr_Colours_YesOrNo //

      LStr_Images_YesOrNo :=  FStr_SendToRegistry ( 'Read'                 ,
                                                     GSTR_SELECTION_IMAGES ,
                                                    'Shown'                ,
                                                    ''                   ) ;
      case LStr_Images_YesOrNo of
        'Yes' : MenIte_Sudoku_Select_Images    .Visible := true;

        'No'  : MenIte_Sudoku_Select_Images    .Visible := false;

      end; // LStr_Images_YesOrNo //

    end; // P_MakeVisibleOrNot //

    procedure TFor_Sudoku.P_DisplayGrid;
    var
      LByt_Across               ,
      LByt_Down                 ,
      LByt_SolutionCell         ,
      LByt_AsciiCharacters      : byte;

      LStr_NumOrChar            : string;
      LStr_FirstCharacter       : string;
    begin
      LStr_NumOrChar :=  FStr_SendToRegistry ( 'Read'                ,
                                                GSTR_SETTINGS        ,
                                               'Number Or Character' ,
                                               ''                  ) ;

      LStr_FirstCharacter :=  FStr_SendToRegistry ( 'Read'                 ,
                                                     GSTR_SELECTION_A_TO_I ,
                                                    'Old First Character'  ,
                                                    ''                   ) ;

      P_DisplayNumbersInHeader ( StrGri_SudokuPuzzle     );
      P_DisplayNumbersInHeader ( StrGri_SudokuColourGrid );
      P_DisplayNumbersInHeader ( StrGri_SudokuSolution   );

      P_DisplayNumbersInHeader ( StrGri_DragToPuzzle     );

      case LStr_NumOrChar of
        'Num' :
          begin
            for LByt_Across := 1 to 9 do
              StrGri_DragToPuzzle.Cells[LByt_Across,1] := inttostr(LByt_Across);
          end; // G_NUMBER //

        'Char' :
          begin
            LByt_AsciiCharacters := ord(LStr_FirstCharacter[1])-1;

            for LByt_Across := 1 to 9 do
              StrGri_DragToPuzzle.Cells[LByt_Across,1] :=
              chr(LByt_AsciiCharacters+LByt_Across);
          end; // G_CHARACTERS //
      end; // case LStr_NumoOrChar //

      for LByt_Across := 1 to 9 do
        for LByt_Down   := 1 to 9 do
          begin
            LByt_SolutionCell := GArrDubByt_Solution[LByt_Down,LByt_Across];

            StrGri_SudokuSolution.Cells[LByt_Across,LByt_Down] :=
            inttostr(LByt_SolutionCell);

            StrGri_SudokuSolution.Cells[LByt_Across,LByt_Down] :=
            StrGri_DragToPuzzle.Cells[LByt_SolutionCell,1];
          end; // for LByt_Down //

      P_ShownCellsInPuzzleGrid;
    end; // P_DisplayGrid //
    procedure TFor_Sudoku.P_SaveRatings;
    begin
      with TMemo.Create(Self) do
        begin
       { Easy        } Lines.Add('3,5,5,3,4,3,3,4,6');
       { Medium      } Lines.Add('4,4,3,3,4,4,4,3,3');
       { Challenging } Lines.Add('4,3,2,3,2,3,2,3,4');

                       Lines.SaveToFile('ratings.csv');
        end; // TMemo.Create(Self) //
    end; // P_SaveRatings //

    procedure TFor_Sudoku.P_SaveSudokuSolution;
    begin
      with TMemo.Create(Self) do
         begin
           Lines.Add('6,4,9,8,5,3,7,1,2');
           Lines.Add('3,2,1,6,7,4,9,8,5');
           Lines.Add('8,7,5,2,1,9,6,4,3');
           Lines.Add('4,9,8,1,3,2,5,7,6');
           Lines.Add('1,6,2,5,8,7,3,9,4');
           Lines.Add('7,5,3,9,4,6,1,2,8');
           Lines.Add('5,8,6,7,2,1,4,3,9');
           Lines.Add('2,3,7,4,9,5,8,6,1');
           Lines.Add('9,1,4,3,6,8,2,5,7');

           Lines.SaveToFile('sudoku_solution.csv');
         end;
    end; // P_SaveSudokuSolution //


    procedure  TFor_Sudoku.P_WriteToRegistry;
    begin
      FStr_SendToRegistry ( 'Write'               ,
                             GSTR_SETTINGS        ,
                            'Number Or Character' ,
                            'Num'            )    ;

      FStr_SendToRegistry ( 'Write'               ,
                             GSTR_SETTINGS        ,
                            'Colours Or Images'   ,
                            ' '            )      ;

      FStr_SendToRegistry ( 'Write'         ,
                             GSTR_SETTINGS  ,
                            'Show Solution' ,
                            'No'          ) ;

      FStr_SendToRegistry ( 'Write'         ,
                             GSTR_SETTINGS  ,
                            'Show Grid'     ,
                            'No'          ) ;


      FStr_SendToRegistry ( 'Write'         ,
                             GSTR_SETTINGS  ,
                            'Tutor'         ,
                            'No'          ) ;
    { ----------------------------------------------------------}

      FStr_SendToRegistry ( 'Write'                    ,
                             GSTR_SELECTION_A_TO_I     ,
                            'Entered First Character'  ,
                            'No'                    )  ;

      FStr_SendToRegistry ( 'Write'                    ,
                             GSTR_SELECTION_A_TO_I     ,
                            'New First Character'      ,
                            'A'                     )  ;

      FStr_SendToRegistry ( 'Write'                    ,
                             GSTR_SELECTION_A_TO_I     ,
                            'Old First Character'      ,
                            'A'                     )  ;

      FStr_SendToRegistry ( 'Write'                    ,
                             GSTR_SELECTION_A_TO_I     ,
                            'Wrap Around'              ,
                            'No'                    )  ;

      FStr_SendToRegistry ( 'Write'                    ,
                             GSTR_SELECTION_A_TO_I     ,
                            'Shown'                    ,
                            'No'                    )  ;

    { ----------------------------------------------------------}

      FStr_SendToRegistry ( 'Write'                             ,
                             GSTR_SELECTION_A_TO_I_WRAP_AROUND  ,
                            'New First Character'               ,
                            ''                     )            ;
    { ----------------------------------------------------------}

      FStr_SendToRegistry ( 'Write'                    ,
                             GSTR_SELECTION_CHARACTERS ,
                            'Shown'                    ,
                            'No'                     ) ;

      FStr_SendToRegistry ( 'Write'                    ,
                             GSTR_SELECTION_COLOURS    ,
                            'Shown'                    ,
                            'No'                     ) ;

      FStr_SendToRegistry ( 'Write'                    ,
                             GSTR_SELECTION_IMAGES     ,
                            'Shown'                    ,
                            'No'                     ) ;

      end; // P_WriteToRegistry; //

    procedure TFor_Sudoku.P_ShownCellsInPuzzleGrid;
    type
       TArrSinByt_Result = array [ 1..9 ] of byte;
       TArrDouByt_Result = array [ 1..9,1..9 ] of byte;

    var
      LArrSinByt_ShownCellsInRows1To9          ,
      LArrSinByt_RandomizeShownCellsInRows1To9 : TArrSinByt_Result;

      LArrDubByt_Ratings : TArrDouByt_Result;

      LByt_Number                ,
      LByt_RowNumber             ,
      LByt_AcrossLoop            ,
      LByt_RatingNumber          ,
      LByt_AsciiCharacters       ,
      LByt_RandomShownCell       ,
      LByt_RandomShownCellLoop   ,
      LByt_RandomShownCellAcross : byte;

      LCha_AsciiCharacters       : char;

      LStr_NumOrChar      : string;
      LStr_FirstCharacter : string;
      LByt_FirstCharacter : byte;

      function FArrSinByt_RandomizeShownCellsInRows1To9
                     ( PArrSinByt_ShownCellsInRows1To9  :
                                TArrSinByt_Result ) :
                                TArrSinByt_Result   ;
      var
        LByt_AcrossLoop       ,
        LByt_RandomArrayIndex ,
        LByt_Temp: byte;
      begin
        LStr_NumOrChar  := FStr_SendToRegistry
                        ( 'Read'                ,
                           GSTR_SETTINGS        ,
                          'Number Or Character' ,
                          ''                  ) ;

        LStr_FirstCharacter := FStr_SendToRegistry
                            ( 'Read'                 ,
                               GSTR_SELECTION_A_TO_I ,
                              'Old First Character'  ,
                              ''                   ) ;

        LByt_FirstCharacter := ord (LStr_FirstCharacter[1] );

        for LByt_AcrossLoop := 1 to 9 do
          begin
          { Pick a random array index }
       	    LByt_RandomArrayIndex := random(8) + 1;

          { Now exchange the elements }
            LByt_Temp := PArrSinByt_ShownCellsInRows1To9[LByt_RandomArrayIndex];

            PArrSinByt_ShownCellsInRows1To9[LByt_RandomArrayIndex] :=
            PArrSinByt_ShownCellsInRows1To9[LByt_AcrossLoop];

            PArrSinByt_ShownCellsInRows1To9[LByt_AcrossLoop] := LByt_Temp;
          end; // for LByt_Across //

        result := PArrSinByt_ShownCellsInRows1To9;

      end; // FArrSinByt_RandomizeShownCells //

    begin
      P_SaveRatings;

      P_ReadCSVFileWithArray ( GSTR_RATINGS_CSV,LArrDubByt_Ratings);

       with ComBox_Ratings do
         LByt_RatingNumber := Itemindex + 1;

       for LByt_AcrossLoop := 1 to 9 do
          LArrSinByt_ShownCellsInRows1To9 [LByt_AcrossLoop] :=
          LArrDubByt_Ratings   [LByt_RatingNumber,LByt_AcrossLoop];

       LArrSinByt_RandomizeShownCellsInRows1To9 :=
       FArrSinByt_RandomizeShownCellsInRows1To9 ( LArrSinByt_ShownCellsInRows1To9 );

       P_EmptyGrid (StrGri_SudokuPuzzle);

       case LStr_NumOrChar of
         'Num' :
           for LByt_RowNumber := 1 to 9 do
             begin
               LByt_RandomShownCell := LArrSinByt_RandomizeShownCellsInRows1To9
                                    [ LByt_RowNumber ];

               for LByt_RandomShownCellLoop := 1 to LByt_RandomShownCell do
                 begin
                   LByt_RandomShownCellAcross := strtoint(StrGri_SudokuSolution.Cells
                   [LByt_RandomShownCellLoop,LByt_RowNumber]);

                   StrGri_SudokuPuzzle.Cells[LByt_RandomShownCellAcross,LByt_RowNumber] :=
                   StrGri_SudokuSolution.Cells[LByt_RandomShownCellAcross,LByt_RowNumber];

                 end; // LByt_RandomShownCellLoop //
             end; // LByt_RowNumber //

         'Char' :
           begin
             for LByt_RowNumber := 1 to 9 do
               begin
                 LByt_RandomShownCell := LArrSinByt_RandomizeShownCellsInRows1To9
                                [ LByt_RowNumber ];

                 for LByt_RandomShownCellLoop := 1 to LByt_RandomShownCell do
                   begin
                     LByt_AsciiCharacters := ord(StrGri_SudokuSolution.Cells[LByt_RandomShownCellLoop,LByt_RowNumber][1])-(15+LByt_FirstCharacter-64);



                     if LByt_AsciiCharacters > 57
                       then
                     else
                       begin
                         LCha_AsciiCharacters := chr(LByt_AsciiCharacters);
                         LByt_Number := strtoint(LCha_AsciiCharacters);

                         StrGri_SudokuPuzzle.Cells[LByt_Number,LByt_RowNumber] :=
                         StrGri_SudokuSolution.Cells[LByt_Number,LByt_RowNumber];
                       end; // else LByt_AsciiCharacters > 57 //
                   end; // LByt_RandomShownCellLoop //
               end; // LByt_RowNumber //
           end; // G_CHARACTERS //
       end; // case FCha_CheckFile //

    P_FillGridWithColour ( StrGri_SudokuPuzzle ,
                           u_colour_grid.G_EMPTY_COLOUR);

    P_ColourCellsInSameCell ( StrGri_SudokuPuzzle ,
                              StrGri_Sudokusolution       );
    end; // P_ShownCellsInPuzzleGrid //
    procedure TFor_Sudoku.P_CreatePathsForRegistry;
    begin
      P_CreateRegPath     ( GSTR_SETTINGS            );
      P_CreateRegPath     ( GSTR_SELECTION           );


      P_CreateRegPath    ( GSTR_SELECTION_A_TO_I     );
        P_CreateRegPath    ( GSTR_SELECTION_A_TO_I_WRAP_AROUND );

      P_CreateRegPath    ( GSTR_SELECTION_CHARACTERS );
      P_CreateRegPath    ( GSTR_SELECTION_COLOURS    );
      P_CreateRegPath    ( GSTR_SELECTION_IMAGES     );
    end; // P_CreatePathsForRegistry //

    procedure TFor_Sudoku.P_CreateSaveGridsDirectory;
    var
      LStr_Path : string;
    begin
    { If the Directory is not there }
    { Create it at the Current Dir  }
      LStr_Path :=  GetCurrentDir + '\save_grids';

      CreateDir(LStr_Path);
      CreateDir(LStr_Path+'\character_grids');
      CreateDir(LStr_Path+'\character_grids\easy');
      CreateDir(LStr_Path+'\character_grids\moderate');
      CreateDir(LStr_Path+'\character_grids\challenging');

      CreateDir(LStr_Path+'\number_grids');
      CreateDir(LStr_Path+'\number_grids\easy');
      CreateDir(LStr_Path+'\number_grids\moderate');
      CreateDir(LStr_Path+'\number_grids\challenging');
    end;

    procedure TFor_Sudoku.P_CheckForNumbersOrCharacters;
    var
      LCha_FirstChar ,
      LCha_LastChar  : char;
      LStr_NumOrChar : string;
    begin
      LStr_NumOrChar := FStr_SendToRegistry
                     ( 'Read'                ,
                        GSTR_SETTINGS        ,
                       'Number Or Character' ,
                       ''                  ) ;

      case LStr_NumOrChar of
        'Num' :
          begin
            MenIte_Sudoku_Settings.Caption := 'Settings :- '
                                            +  FStr_FirstAndLastCharacter ( 'Num' );
            MenIte_Sudoku_Select_1To9  .RadioItem := True;
          end; // G_NUMBER //

        'Char' :
          begin
            MenIte_Sudoku_Settings.Caption    := 'Settings :- '
                                              + FStr_FirstAndLastCharacter ( 'Old' );
            MenIte_Sudoku_Select_AToI  .RadioItem := True;
          end; // G_CHARACTERS //
      end; // case LStr_NumOrChar //



    end; // P_CheckGridForNumbersOrCharacters //
    function TFor_Sudoku.FByt_CountSelect : byte;
    var
      LByt_CountSelect : byte;

      LStr_A_To_I_YesOrNo     ,
      LStr_Characters_YesOrNo ,
      LStr_Colours_YesOrNo    ,
      LStr_Images_YesOrNo     : string;
    begin
      LByt_CountSelect := 0;

    { ------------------------------------------------------------------------}


      LStr_A_To_I_YesOrNo :=  FStr_SendToRegistry ( 'Read'                 ,
                                                     GSTR_SELECTION_A_TO_I ,
                                                    'Shown'                ,
                                                    ''                   ) ;

      if ( LStr_A_To_I_YesOrNo = 'Yes'  )
         then
           LByt_CountSelect := LByt_CountSelect + 1;

    { ------------------------------------------------------------------------}

      LStr_Characters_YesOrNo := FStr_SendToRegistry ( 'Read'                     ,
                                                        GSTR_SELECTION_CHARACTERS ,
                                                       'Shown'                    ,
                                                       ''                       ) ;

      if ( LStr_Characters_YesOrNo =  'Yes'  )
         then
           LByt_CountSelect := LByt_CountSelect + 1;

    { ------------------------------------------------------------------------}

      LStr_Colours_YesOrNo    := FStr_SendToRegistry ( 'Read'                  ,
                                                        GSTR_SELECTION_COLOURS ,
                                                       'Shown'                 ,
                                                       ''                    ) ;

      if ( LStr_Colours_YesOrNo =  'Yes'  )
        then
          LByt_CountSelect := LByt_CountSelect + 1;

    { ------------------------------------------------------------------------}

      LStr_Images_YesOrNo     := FStr_SendToRegistry ( 'Read'                  ,
                                                        GSTR_SELECTION_IMAGES  ,
                                                       'Shown'                 ,
                                                       ''                    ) ;

      if ( LStr_Images_YesOrNo =  'Yes'  )
        then
          LByt_CountSelect := LByt_CountSelect + 1;

    { ------------------------------------------------------------------------}

      result := LByt_CountSelect;

    end; //  FByt_CountSelect //

    function  TFor_Sudoku.FStr_FirstAndLastCharacter ( PStr_Selection : string )
                                                                      : string;
    var
      LByt_FirstChar        : byte;

      LCha_FirstChar ,
      LCha_LastChar         : char;

      LStr_EnteredFirstChar ,
      LStr_ChangeTo         ,
      LStr_WrapAround       ,
      LStr_Selection        : string;
    begin
      LStr_Selection := '';

      LStr_WrapAround := FStr_SendToRegistry
                      ( 'Read'                 ,
                         GSTR_SELECTION_A_TO_I ,
                        'Wrap Around'          ,
                        ''                   ) ;

      case PStr_Selection of
        'Num' : LCha_FirstChar := '1';




        'Old' : LCha_FirstChar := FStr_SendToRegistry
                               ( 'Read'                 ,
                                  GSTR_SELECTION_A_TO_I ,
                                 'Old First Character'  ,
                                 ''                )[1] ;

        'New' : LCha_FirstChar := FStr_SendToRegistry
                               ( 'Read'                 ,
                                  GSTR_SELECTION_A_TO_I ,
                                 'New First Character'  ,
                                 ''                )[1] ;
      end; //  case PStr_Selection //

      LByt_FirstChar := ord ( LCha_FirstChar ) - 1;
      LCha_LastChar  := chr ( LByt_FirstChar + 9 );

      if LStr_WrapAround = 'Yes'
        then
          LCha_LastChar  := chr( ( LByt_FirstChar + 9 ) - 26 );

      result := ' ( ' + LCha_FirstChar + ' - ' + LCha_LastChar + ' ) ';

    end; // FStr_FirstAndLastCharacter //

    function TFor_Sudoku.FBoo_SameOldNewChar : boolean;
    var
      LCha_OldFirstChar ,
      LCha_NewFirstChar : char;

    begin
      LCha_OldFirstChar := FStr_SendToRegistry
                        ( 'Read'                 ,
                           GSTR_SELECTION_A_TO_I ,
                          'Old First Character'  ,
                          ''                )[1] ;

      LCha_NewFirstChar := FStr_SendToRegistry
                        ( 'Read'                 ,
                           GSTR_SELECTION_A_TO_I ,
                          'New First Character'  ,
                          ''                )[1] ;

      if ( LCha_OldFirstChar = LCha_NewFirstChar )
        then
          result := true
        else // LCha_OldFirstChar does not equal LCha_NewFirstChar //
          result := false;


    end; // FStr_SameOldNewChar //
    procedure  TFor_Sudoku.P_DisplayOldAndNewGrid ( PStr_Selection   : string );
    begin
      if ( FBoo_SameOldNewChar ) and ( PStr_Selection = 'No' )
        then
          begin
            MenIte_Sudoku_Select_AToI.Caption := FStr_FirstAndLastCharacter ( 'Old' );


            For_Sudoku       .Height  := 430;
            For_Sudoku       .Width   := 285;

            GroBox_PuzzleGrid.Height  := 384;
            GroBox_PuzzleGrid.Left    := 16;

            GroBox_Selection .Top     := 272;
            GroBox_Selection .Height  := 120;
          end { ( FBoo_SameOldNewChar )
                        and ( LStr_EnteredFirstChar = 'No'  ) }
        else  { ( not FBoo_SameOldNewChar )
                        and ( LStr_EnteredFirstChar = 'Yes' ) }
          begin
            Lab_OldGrid.Caption := 'Old Grid :- '
                                + FStr_FirstAndLastCharacter ( 'Old' );

            Lab_NewGrid.Caption := 'New Grid :- '
                                + FStr_FirstAndLastCharacter ( 'New' );

            MenIte_Sudoku_Select_AToI.Caption := 'New :- ' +FStr_FirstAndLastCharacter ( 'New' );

            For_Sudoku               .Height  := 500;
            For_Sudoku               .Width   := 285;

            GroBox_PuzzleGrid        .Height  := 450;
            GroBox_PuzzleGrid        .Left    := 16;

            GroBox_Selection         .Top     := 368;
            GroBox_Selection         .Height  := 120;
          end; { ( not FBoo_SameOldNewChar )
                   and ( LStr_EnteredFirstChar = 'Yes' ) }

    end; // P_DisplayOldAndNewGrid //

    procedure  TFor_Sudoku.P_FillSmallGridWith    ( PStr_Selection   : string );
    var
      LByt_Across         ,
      LByt_Across_WA      ,
      LByt_AsciiFirstChar : byte;

      LCha_FirstChar      : char;

      LStr_WrapAround     : string;
    {var
      LByt_Across     ,
      LByt_FirstChar  : byte;

      LCha_FirstChar  ,
      LCha_LastChar   : char;

      LStr_WrapAround : string; }

    begin
      case PStr_Selection of
        'Num'    : for LByt_Across := 1 to 9 do
                     StrGri_DragToPuzzle.Cells[LByt_Across,1] :=
                                         inttostr(LByt_Across);

        'Char' : begin
                   LStr_WrapAround := FStr_SendToRegistry ( 'Read'                 ,
                                                             GSTR_SELECTION_A_TO_I ,
                                                            'Wrap Around'          ,
                                                            ''                    );

                   LCha_FirstChar  := FStr_SendToRegistry ( 'Read'                 ,
                                                             GSTR_SELECTION_A_TO_I ,
                                                            'New First Character'  ,
                                                            ''  )[1]               ;

                   LByt_AsciiFirstChar := ord (LCha_FirstChar)-1;

                   for LByt_Across := 1 to 9 do
                     StrGri_DragToPuzzle.Cells[LByt_Across,1] :=
                       chr(LByt_AsciiFirstChar + LByt_Across);

                   if LStr_WrapAround = 'No'
                     then
                       // Do Nothing //
                     else
                       begin // LStr_WrapAround = 'Yes' //
                         for LByt_Across := 1 to 9 do
                           if chr(LByt_AsciiFirstChar + LByt_Across) = 'Z'
                             then
                               LByt_Across_WA := LByt_Across + 1;

                         for LByt_Across := LByt_Across_WA to 9 do
                           StrGri_DragToPuzzle.Cells[LByt_Across,1] :=
                             chr( (LByt_AsciiFirstChar + LByt_Across ) -26);
                       end; // LStr_WrapAround = 'Yes' //




                  {   LByt_FirstChar := ord(LCha_FirstChar)-1;

                     for LByt_Across := 1 to 9 do
                       StrGri_DragToPuzzle.Cells[LByt_Across,1] :=
                                 chr(LByt_FirstChar+LByt_Across); }

                   end; // 'Char' //

        'Colour' : begin
                   end; // 'Colour' //

        'Image'  : begin
                   end; // 'Image' //
      end; // case PStr_Selection //

    end; // P_FillSmallGridWith //
    procedure  TFor_Sudoku.P_ShowSolution ( PStr_ShowSolution : string = '');
    var
      LStr_Solution_YesOrNo ,
      LStr_EnteredFirstChar : string;
    begin
      LStr_Solution_YesOrNo := FStr_SendToRegistry
                            ( 'Read'          ,
                               GSTR_SETTINGS  ,
                              'Show Solution' ,
                              ''             );

      LStr_EnteredFirstChar := FStr_SendToRegistry
                            ( 'Read'                    ,
                               GSTR_SELECTION_A_TO_I    ,
                              'Entered First Character' ,
                              ''                       );


      case LStr_Solution_YesOrNo of
        'Yes' :  begin
                   if CheBox_ShowSolution.Checked = true
                         then
                           For_Sudoku.Width  := 922;

                    { ------------------------------------- }

                      For_Sudoku               .Height  := 980;

                      GroBox_PuzzleGrid        .Height  := 430;
                      GroBox_PuzzleGrid        .Left    := 16;

                      GroBox_Selection         .Height  := 160;

                    end; // GSTR_YES //

          'No'  : begin
                    For_Sudoku               .Height  := 430;
                    For_Sudoku               .Width   := 285;

                    GroBox_PuzzleGrid        .Height  := 384;
                    GroBox_PuzzleGrid        .Left    := 16;

                    GroBox_Selection         .Height  := 120;
                  end; // GSTR_NO //
          end; // case LStr_Solution_YesOrNo //
      end; // P_ShowSolution //

      procedure TFor_Sudoku.P_NewFirstCharacter ( PStr_NumOrChar : string );
        var
          LByt_Across    ,
          LByt_FirstChar : byte;

          LCha_FirstChar ,
          LCha_LastChar  : char;
        begin
          case PStr_NumOrChar of
            'Num'  : begin
                       MenIte_Sudoku_Settings.Caption :=
                        FStr_FirstAndLastCharacter ( 'Num' );

                       P_FillSmallGridWith ( 'Num' );
                     end; // 'Num' //

            'Char' : begin
                       MenIte_Sudoku_Settings.Caption :=
                       FStr_FirstAndLastCharacter ( 'Old' );

                       MenIte_Sudoku_Select_AToI.Caption :=
                          FStr_FirstAndLastCharacter ( 'Old' );

                       P_FillSmallGridWith ( 'Char' );
                     end; //  'Char' //
          end; // case PStr_NumOrChar //
      end; // P_NewFirstCharacter // }

  procedure TFor_Sudoku.P_RandomizeSolutionGrid ( PStr_Selection : string );
     var
       LByt_Down         ,
       LByt_Across       ,
       LByt_SolutionCell : byte;

     begin
      P_SaveSudokuSolution;
      P_SaveRatings;

      P_CreateANewRandomGrid;

      case PStr_Selection of
         'Num' : for LByt_Across := 1 to 9 do
                   for LByt_Down   := 1 to 9 do
                     begin
                       LByt_SolutionCell := GArrDubByt_Solution[LByt_Down,LByt_Across];

                       StrGri_SudokuSolution.Cells[LByt_Across,LByt_Down] :=
                       inttostr(LByt_SolutionCell);

                       StrGri_SudokuSolution.Cells[LByt_Across,LByt_Down] :=
                       StrGri_DragToPuzzle.Cells[LByt_SolutionCell,1];
                     end; // for LByt_Down //

       end; // case PStr_Selection //
     end; // P_RandomizeSolutionGrid //

   procedure TFor_Sudoku.P_PuzzleGrid   ( PCha_Files         : char  ;
                                           PByt_RatingsIndex      : byte );
                                                                  overload;
    const
      L_COPY_FILES = 'C'; L_DELETE_FILES = 'D';
    begin
      with For_Dialog do
        case PCha_Files of
          L_COPY_FILES :
            begin
              GStr_Dialog      := G_COPY_DIALOG;
              GStr_Title       := 'Copy Sudoku Puzzles';
              GStr_Path        := FStr_RatingsPath ( PByt_RatingsIndex );
              GStr_PathToFiles := GetCurrentDir + GStr_Path;

              if FBoo_Execute
                then
                else // Clicked Cancel //
            end; // L_COPY_FILES //

          L_DELETE_FILES :
            begin
              GStr_Dialog      := G_DELETE_DIALOG;
              GStr_Title       := 'Delete Sudoku Puzzles';
              GStr_Path        := FStr_RatingsPath ( PByt_RatingsIndex );
              GStr_PathToFiles := GetCurrentDir + GStr_Path;

              if FBoo_Execute
                then
                else // Clicked Cancel //
            end; // L_DELETE_FILES //
        end; // PCha_Files //
    end; // P_PuzzleGrid //

    procedure TFor_Sudoku.P_CheckPuzzleGrid ( PInt_DestCol ,
                                              PInt_DestRow : integer);
    const
      L_EMPTY_CELL = '';
    var
      LStr_PuzzleCellContents   ,
      LStr_SolutionCellContents : string;

    begin
      LStr_PuzzleCellContents   := StrGri_SudokuPuzzle.Cells
                                [ PInt_DestCol,PInt_DestRow ];

      LStr_SolutionCellContents := StrGri_SudokuSolution.Cells
                                [ PInt_DestCol,PInt_DestRow ];


  { ------------------------------------------------------------------------ }
    if LStr_PuzzleCellContents = L_EMPTY_CELL
      then
        StrGri_SudokuPuzzle.Cells[PInt_DestCol,PInt_DestRow]:=
        StrGri_DragToPuzzle.Cells[GInt_SourceCol,GInt_SourceRow]
      else // The Cell is not empty //

        if ( LStr_PuzzleCellContents = LStr_SolutionCellContents )
          then
            showmessage ('Cannot Delete') // Do nothing //
          else
        StrGri_SudokuPuzzle.Cells[PInt_DestCol,PInt_DestRow]:=
        StrGri_DragToPuzzle.Cells[GInt_SourceCol,GInt_SourceRow];
    end; // P_CheckPuzzleGrid //

    procedure TFor_Sudoku.P_FillGridWithColour
                                             ( PStrGri_CellColour : TStringGrid;
                                               PCol_CellColour    : TColor );
    var
      LByt_Across ,
      LByt_Down   ,

      LByt_MaxRow ,
      LByt_MaxCol : byte;

    begin
      with PStrGri_CellColour do
        begin
          LByt_MaxRow := VisibleRowCount;
          LByt_MaxCol := VisibleColCount;

          for LByt_Across := 1 to LByt_MaxRow do
            for LByt_Down   := 1 to LByt_MaxCol do
              u_colour_grid.GArrDubCol_ShowCellColours[LByt_Across,LByt_Down] :=
              u_colour_grid.FCol_ShowCellColour[PCol_CellColour];

        end; // with PStrGri_CellColour //
    end; // P_FillGridWithColour //
    procedure  TFor_Sudoku.P_ColourCellsInSameCell ( PStrGri_CorrectGrid :
                                                                   TStringGrid ;
                                                     PStrGri_CheckGrid   :
                                                                   TStringGrid);

    var
    LByt_Across ,
    LByt_Down   : byte;


      function FStr_CheckGridForSameCells : u_colour_grid.TArrDubStr_Result;
      var
        LByt_Across ,
        LByt_Down   ,

        LByt_MaxRow ,
        LByt_MaxCol : byte;

      begin
        with PStrGri_CorrectGrid do
          begin
            LByt_MaxRow := VisibleRowCount;
            LByt_MaxCol := VisibleColCount;

            for LByt_Across := 1 to LByt_MaxRow do
              for LByt_Down   := 1 to LByt_MaxCol do
                if Cells[LByt_Down,LByt_Across] =
                StrGri_Sudokusolution.Cells[LByt_Down,LByt_Across]
                  then
                    FStr_CheckGridForSameCells [LByt_Across,LByt_Down] :=
                      G_SAME_CELL;

          end; //  with PStrGri_CorrectGrid //
      end; // FStr_CheckGridForSameOrDifferentCells //

      begin
        for LByt_Across := 1 to 9 do
          for LByt_Down   := 1 to 9 do
            if (FStr_CheckGridForSameCells[LByt_Across,LByt_Down] =
                u_colour_grid.G_SAME_CELL)
              then
                u_colour_grid.GArrDubCol_ShowCellColours
                [LByt_Across,LByt_Down] := u_colour_grid.FCol_ShowCellColour
                [u_colour_grid.G_SAME_COLOUR]


      end; // P_ColourCellsInCorrectPosition //

    { ------------------------------------------------------------------------ }
    { ----------------------- Components ( Events ) -------------------------- }
    { ----------- SudokuPuzzle and SudokuSolution StringGrids ---------------- }
    { -------------- ( Used in StrGri_Sudoku_DrawCell ) ---------------------- }
    { ------------------------------------------------------------------------ }

    procedure TFor_Sudoku.P_DrawCell ( PCha_DrawCell          : char;
                                       PStrGri_CellTextOrGrid :  TStringGrid;
                                   var PInt_ACol, PInt_ARow   : integer;
                                   var PRec_ARect             : TRect );

   // type
    { -------------------------------------------- }
    { - Used in the function FCol_ShowCellColour - }
    { -------------------------------------------- }
    //  TArrSinCol_Result = array [ 1..3 ] of TColor;

   { const
      G_EMPTY_CELL_COLOUR     =  1;
      G_SAME_CELL_COLOUR      =  2;
      G_DIFFERENT_CELL_COLOUR =  3;   }

    var
     // LArrDubCol_ShowCellColours : TArrDubCol_Result;

      LByt_Across ,
      LByt_Down   : byte;

    { ------------------------------------------------------------------------ }

      procedure P_DrawGridLines;
      var
        LByt_Virt_Lines  ,
        LByt_Horiz_Lines : byte;
      begin
        with PStrGri_CellTextOrGrid do
          begin
            for LByt_Virt_Lines  := 0 to 9 do
              begin
                if (PInt_ACol = LByt_Virt_Lines)
                  then
                    begin
                      Canvas.Pen.Color := clSilver;

                      Canvas.MoveTo(PRec_ARect.Right - 1, PRec_ARect.Top);
                      Canvas.LineTo(PRec_ARect.Right - 1, PRec_ARect.Bottom);
                    end;

                if (PInt_ACol = 0) or (PInt_ACol = 3)
                or (PInt_ACol = 6) or (PInt_ACol = 9)
                  then
                    begin
                      Canvas.Pen.Color := clblack;

                      Canvas.MoveTo(PRec_ARect.Right - 1, PRec_ARect.Top);
                      Canvas.LineTo(PRec_ARect.Right - 1, PRec_ARect.Bottom);
                    end; {   (PInt_ACol = 0) or (PInt_ACol = 3)
                          or (PInt_ACol = 6) or (PInt_ACol = 9) }

              end; // LByt_Virt_Lines //

            for LByt_Horiz_Lines := 0 to 9 do
              begin
                if (PInt_ARow = LByt_Horiz_Lines )
                  then
                    begin
                      Canvas.Pen.Color := clSilver;

                      Canvas.MoveTo(PRec_ARect.left    ,PRec_ARect.top);
                       Canvas.LineTo(PRec_ARect.right -1,PRec_ARect.top);
                    end;

                if (PInt_ARow = 0) or (PInt_ARow = 3)
                or (PInt_ARow = 6) or (PInt_ARow = 9)
                  then
                    begin
                      Canvas.Pen.Color := clblack;

                      Canvas.MoveTo(PRec_ARect.left , PRec_ARect.bottom-1);
                      Canvas.LineTo(PRec_ARect.right ,PRec_ARect.bottom-1);
                    end; {   (PInt_ARow = 0) or (PInt_ARow = 3)
                          or (PInt_ARow = 6) or (PInt_ARow = 9) }

                end; // LByt_Horiz_Lines //
          end; // with PStrGri_GridLines //
      end; // P_Draw_GridLines //


    { ------------------------------------------------------------------------ }
      begin
        if PCha_DrawCell = GCHA_GRIDLINES
          then
            P_DrawGridLines;


        for LByt_Across := 1 to 9 do
          for LByt_Down   := 1 to 9 do
            with PStrGri_CellTextOrGrid do

            if (PInt_ACol = LByt_Across) and (PInt_ARow = LByt_Down)
              then
                case PCha_DrawCell of
                  GCHA_CELLCOLOUR :
                     begin


                       Canvas.Brush.Color :=  u_colour_grid.GArrDubCol_ShowCellColours[PInt_ARow,PInt_ACol];

                       Canvas.FillRect(PRec_ARect );
                       Canvas.TextOut(PRec_ARect .Left+2,
                                      PRec_ARect .Top+2 ,
                                      Cells[PInt_ACol  , PInt_ARow]);
                     end;
                end; // PCha_DrawCell //



    end; // P_DrawCell //

     procedure TFor_Sudoku.P_PuzzleGrid ( PCha_Files         : char         ;
                                          PByt_RatingsIndex : byte          ;
                                          PStrGri_Grid1     : TStringgrid   ;
                                          PStrGri_Grid2     : TStringgrid   ;
                                          PStrGri_Grid3     : TStringgrid ) ;

      procedure SaveGrid ( const PStr_Filename : string);
      var
        LStrLis_Grid  :  TStringList;

        LByt_GridLoop : byte;
      begin
        { create a TStringList to save the grid's contents to }
          LStrLis_Grid := TStringList.Create;
          try
              LStrLis_Grid.Add('*******************');
              LStrLis_Grid.Add('*   Puzzle Grid   *');
              LStrLis_Grid.Add('*******************');

              LStrLis_Grid.Add('===================');

            { save each rows content as comma delimited text }
              if PStrGri_Grid1.VisibleRowCount > 0
                then
                  for LByt_GridLoop := 1 to 9 do
                    LStrLis_Grid.Add( PStrGri_Grid1.Rows[LByt_GridLoop].
                                                              CommaText );


              LStrLis_Grid.Add('');

              LStrLis_Grid.Add('*******************');
              LStrLis_Grid.Add('*   Colour Grid   *');
              LStrLis_Grid.Add('*******************');

              LStrLis_Grid.Add('===================');

              { save each rows content as comma delimited text }
              if PStrGri_Grid2.VisibleRowCount > 0
                then
                  for LByt_GridLoop := 1 to 9 do
                    LStrLis_Grid.Add( PStrGri_Grid2.Rows[LByt_GridLoop].
                                                              CommaText );

              LStrLis_Grid.Add('===================');
              LStrLis_Grid.Add('');

              LStrLis_Grid.Add('*******************');
              LStrLis_Grid.Add('*  Solution Grid  *');
              LStrLis_Grid.Add('*******************');

              LStrLis_Grid.Add('===================');

            { save each rows content as comma delimited text }
              if PStrGri_Grid3.VisibleRowCount > 0
                then
                  for LByt_GridLoop := 1 to 9 do
                    LStrLis_Grid.Add( PStrGri_Grid3.Rows[LByt_GridLoop].
                                                              CommaText );

                LStrLis_Grid.Add('===================');

              LStrLis_Grid.SaveToFile(PStr_Filename);

            finally
              LStrLis_Grid.Free;
            end; // Try - Finally //
       end; // SaveGrid //

       procedure LoadGrid ( const PStr_Filename : string);
       const
         L_SUDOKU_PUZZLE = 3; L_SUDOKU_COLOUR_GRID = 17; L_SUDOKU_SOLUTION = 32;
       var
         LStrLis_Grid  :  TStringList;

         LByt_GridLoop : byte;
       begin
       { create a TStringList to save the grid's contents to }
         LStrLis_Grid := TStringList.Create;
            try
              LStrLis_Grid.LoadFromFile ( PStr_Filename );

              for LByt_GridLoop := 1 to 9 do
                PStrGri_Grid1.Rows [ LByt_GridLoop ].CommaText :=
                                     LStrLis_Grid [ LByt_GridLoop +
                                                    L_SUDOKU_PUZZLE ];

              for LByt_GridLoop := 1 to 9 do
                PStrGri_Grid2.Rows [ LByt_GridLoop ].CommaText :=
                                     LStrLis_Grid [ LByt_GridLoop +
                                                    L_SUDOKU_COLOUR_GRID ];

              for LByt_GridLoop := 1 to 9 do
                PStrGri_Grid3.Rows [ LByt_GridLoop ].CommaText :=
                                     LStrLis_Grid [ LByt_GridLoop +
                                                    L_SUDOKU_SOLUTION ];
              finally
                LStrLis_Grid.Free;
            end; // Try - Finally //
       end; // LoadGrid //

    const
      L_SAVE_FILES = 'S'; L_LOAD_FILES = 'L';
    begin

      with For_Dialog do
        case PCha_Files of
          L_SAVE_FILES :
            begin
              GStr_Dialog      := G_SAVE_DIALOG;
              GStr_Title       := 'Save Sudoku Puzzles';
              GStr_Path        := FStr_RatingsPath ( PByt_RatingsIndex );
              GStr_PathToFiles := GetCurrentDir + GStr_Path;
              GStr_Mask        := '*.txt';

              BitBtn_Dialog.Enabled := false;

              repeat
                if FBoo_Execute
                  then
                    SaveGrid ( GStr_FileName )
                  else // Clicked Cancel //
                    break;
              until GStr_FileName <> '';

            end; // L_SAVE_FILES //

          L_LOAD_FILES :
            begin
              GStr_Dialog      := G_LOAD_DIALOG;
              GStr_Title       := 'Load Sudoku Puzzles';
              GStr_Path        := FStr_RatingsPath ( PByt_RatingsIndex );
              GStr_PathToFiles := GetCurrentDir + GStr_Path;
              GStr_Mask        := '*.txt';

              BitBtn_Dialog.Enabled := false;

              repeat
                if FBoo_Execute
                  then
                    LoadGrid ( GStr_FileName )
                  else // Clicked Cancel //
                    break;
               until GStr_FileName <> '';
            end; // L_LOAD_FILES //
        end; // case PCha_SOrL of //
    end; // P_PuzzleGrid //
end.


