unit f_sudoku_developer;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, ColorBox, ExtCtrls, Menus, Grids, Buttons, Registry,LCLIntf,

  u_registry,
  u_components;

  type
    TSinArrCha_RegArray = array [1..9] of char;

  { TFor_SudokuDeveloper }

  TFor_SudokuDeveloper = class(TForm)
    BitBtn_Save: TBitBtn;
    But_CharactersAlterGridCancel: TButton;
    But_CharactersAlterGridSave: TButton;
    But_Grid: TButton;
    CheBox_ShowSolution: TCheckBox;
    CheBox_Grid: TCheckBox;
    ComBox_AToI: TComboBox;
    ComBox_Characters: TComboBox;
    ComBox_Colours: TComboBox;
    ComBox_Images: TComboBox;
    Edi_CharactersAltergrid: TEdit;
    GroBox_CharactersAlterGrid: TGroupBox;
    GroBox_Selection: TGroupBox;
    GroBox_Settings: TGroupBox;
    GroBox_SettingsSelection: TGroupBox;
    GroBox_CharactersColoursImages: TGroupBox;
    GroupBox1: TGroupBox;
    GroBox_Tutorial: TGroupBox;
    Lab_ActivateTutorial: TLabel;
    Lab_DeactivateTutorial: TLabel;
    Lab_MoveMouse: TLabel;
    Lab_Selection: TLabel;
    Lab_Selection1: TLabel;
    Lab_SelectionAToI: TLabel;
    Lab_SelectionCharacters: TLabel;
    Lab_SelectionColours: TLabel;
    Lab_SelectionImages: TLabel;
    Lab_ActivateDeactivate: TLabel;
    Lab_SudokuMessage: TLabel;
    Lab_SudokuMessage1: TLabel;
    Lab_Solution: TLabel;
    Lab_Solution1: TLabel;
    Lab_ShowGrid: TLabel;
    MaiMen_Developer: TMainMenu;
    MenIte_Developer_Tutorial: TMenuItem;
    MenIte_Developer_ChooseSelection: TMenuItem;
    PagCon_Selection: TPageControl;
    RadBut_Off: TRadioButton;
    RadBut_On: TRadioButton;
    Sha_TutorLine: TShape;
    Sha_SelectionLine: TShape;
    Sha_TutorLine1: TShape;
    StriGri_CharactersAlterGrid: TStringGrid;
    StrGri_Tutor: TStringGrid;
    StringGrid1: TStringGrid;
    TabShe_Characters: TTabSheet;
    TabShe_Colours: TTabSheet;
    TabShe_Images: TTabSheet;
    TabShe_AToI: TTabSheet;

    procedure But_CharactersAlterGridCancelClick(Sender: TObject);
    procedure But_CharactersAlterGridSaveClick(Sender: TObject);

    procedure Edi_CharactersAltergridClick(Sender: TObject);

    procedure Edi_CharactersAltergridKeyPress(Sender: TObject; var Key: char);
    procedure CheBox_SettingsChange(Sender: TObject);
    procedure ComBox_SelectionChange(Sender: TObject);
    procedure Edi_CharactersAltergridChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);


    procedure MenIte_Developer_ChooseSelectionClick(Sender: TObject);
    procedure MenIte_Developer_TutorialClick(Sender: TObject);

    procedure RadBut_Off_Or_OnClick(Sender: TObject);

    procedure StrGri_TutorDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);

  private
    { private declarations }
      function FBoo_WrapAround  ( PCha_Wraparound : char ) : boolean;

      procedure P_DisplaySettings;
      procedure P_DisplayGrid;

      procedure P_WriteFirstCharToRegistry ( PCha_WriteToRegistry : char );
      procedure P_DisplayNumbersInHeader    ( PStrGri_Display      : TStringGrid);

  public
    { public declarations }
  end;

    const

{ ************************************************************************** }
  GSTR_SETTINGS             = '\Software\Sudoku\Settings';
  GSTR_SELECTION             = '\Software\Sudoku\Selection';
{ -------------------------------------------------------------------------- }
                      GSTR_NO = 'No'; GSTR_YES = 'Yes';
{ -------------------------------------------------------------------------- }
{ ************************************************************************** }
  GSTR_NUM_OR_CHAR = 'Num Or Char'; GSTR_NUM = 'Num'; GSTR_CHAR = 'Char';
  GSTR_SHOW_GRID   = 'Show Grid'  ; GSTR_SHOW_SOLUTION = 'Show Solution';
{ -------------------------------------------------------------------------- }
{ ************************************************************************** }
  GSTR_SELECTION_A_TO_I     = '\Software\Sudoku\Selection\A To I\'           ;
{ -------------------------------------------------------------------------- }
                        GSTR_SHOWN = 'Shown';
                    GSTR_FIRST_CHAR = 'First Char';
              GSTR_ENTERED_FIRST_CHAR = 'Entered First Char';

{ -------------------------------------------------------------------------- }
    GSTR_SELECTION_A_TO_I_WRAP_AROUND =
    '\Software\Sudoku\Selection\A To I\Wrap Around';
{ ************************************************************************** }
  GSTR_SELECTION_CHARACTERS = '\Software\Sudoku\Selection\Characters'        ;
  GSTR_SELECTION_COLOURS    = '\Software\Sudoku\Selection\Colours'           ;
  GSTR_SELECTION_IMAGES     = '\Software\Sudoku\Selection\Images'            ;
{ ************************************************************************** }
var
  For_SudokuDeveloper: TFor_SudokuDeveloper;

  GBoo_CellColour : boolean;

  GByt_SelectedRow : byte;
  GByt_SelectedCol : array [1..4] of byte;



implementation

{$R *.lfm}

{ TFor_SudokuDeveloper }

procedure TFor_SudokuDeveloper.FormCreate(Sender: TObject);
var
  LStr_Shown : string;
begin
  For_SudokuDeveloper.Height := 190;
  For_SudokuDeveloper.Width  := 530;

{ with TRegistry.Create do
try
RootKey := HKEY_CURRENT_USER;
if OpenKey ('\Software\Sudoku', true)
  then
    begin
    DeleteKey('\Software\Sudoku');
    end;


    //showmessage('Software\Sudoku :- exists');

//WriteString('MyApp', #34+Application.Exename+#34);
//DeleteValue('MyApp'); {This will delete your registry value}
finally
end;


  FStr_SendToRegistry ( 'Write'        ,
                         GSTR_SETTINGS ,
                        'Tutor'        ,
                        'No')          ;

  P_DisplayNumbersInHeader (StrGri_Tutor);

  GBoo_CellColour := false;     }

  GroBox_CharactersColoursImages.Height := 208;
  PagCon_Selection              .Height := 175;

  FStr_SendToRegistry ( 'Write'                   ,
                         GSTR_SELECTION_A_TO_I    ,
                        'Entered First Character' ,
                        'No');

  LStr_Shown := FStr_SendToRegistry ( 'Read'                 ,
                                       GSTR_SELECTION_A_TO_I ,
                                      'Shown'                ,
                                      '')                    ;

  if LStr_Shown = 'Yes'
    then
      ComBox_AToI.Text := 'Shown'
    else
      ComBox_AToI.Text := 'Not Shown';

  But_CharactersAlterGridCancel.ShowHint:=true;
  But_CharactersAlterGridSave  .ShowHint:=true;

  P_DisplaySettings;

  P_DisplayNumbersInHeader (StriGri_CharactersAlterGrid);
  P_DisplayGrid;

  GroBox_SettingsSelection      .Visible := true;
  GroBox_CharactersColoursImages.Visible := false;



end; // FormCreate //

procedure TFor_SudokuDeveloper.But_CharactersAlterGridSaveClick(Sender: TObject
  );
var
  LByt_Across : byte;
begin
  Lab_SudokuMessage1.Caption := 'Move Mouse cursor over Sudoku Grid';

  if Edi_CharactersAltergrid.Text = ' '
    then
      begin
        Lab_SudokuMessage .Caption  := 'Enter a Character between ( B and Z )';
        Lab_SudokuMessage .Visible  :=  true;
        Lab_SudokuMessage1.Visible := false;
      end // Edi_CharactersAltergrid.Text = ' '
    else
      begin
        Lab_SudokuMessage .Visible :=  false;
        Lab_SudokuMessage1.Visible :=  true;
      end; // Edi_CharactersAltergrid.Text <> ' '

end; // But_CharactersAlterGridSaveClick //



procedure TFor_SudokuDeveloper.Edi_CharactersAltergridClick(Sender: TObject);
begin
  Edi_CharactersAltergrid.SelStart:=0;
end;

procedure TFor_SudokuDeveloper.But_CharactersAlterGridCancelClick(
  Sender: TObject);
begin
   FStr_SendToRegistry ( 'Write'                   ,
                         GSTR_SELECTION_A_TO_I    ,
                        'Entered First Character' ,
                        'Yes');

  Lab_SudokuMessage .Visible :=  true;
  Lab_SudokuMessage .Caption  := 'Reverting back to Default Grid';

  Lab_SudokuMessage1 .Visible :=  true;
  Lab_SudokuMessage1.Caption := 'Move Mouse cursor over Sudoku Grid';

  TabShe_AToI            .Caption := 'A To I';
  Edi_CharactersAltergrid.Text    := 'A';

  P_WriteFirstCharToRegistry ( 'A' );
  P_DisplayGrid;
end; // But_CharactersAlterGridCancelClick //

procedure TFor_SudokuDeveloper.Edi_CharactersAltergridKeyPress(Sender: TObject;
  var Key: char);
begin


  FStr_SendToRegistry ( 'Write'                   ,
                         GSTR_SELECTION_A_TO_I    ,
                        'Entered First Character' ,
                        'Yes');

  if Key in ['b'..'z']
    then
      begin
        Key := upcase(Key);

        Lab_SudokuMessage.Visible := True;
        Lab_SudokuMessage.Caption := 'Click either Save or Cancel';
        Lab_SudokuMessage1.Visible := false;
      end
    else
      Key := #0;

    PagCon_Selection.Height:=224;
    GroBox_CharactersColoursImages.Height:=260;
    For_SudokuDeveloper.Height := 305;
end; // Edi_CharactersAltergridKeyPress //

procedure TFor_SudokuDeveloper.ComBox_SelectionChange(Sender: TObject);
begin
   if Sender = ComBox_AToI
    then
      case ComBox_AToI.Items[ComBox_AToI.ItemIndex] of
        'Shown'     : FStr_SendToRegistry ( 'Write'                ,
                                             GSTR_SELECTION_A_TO_I ,
                                            'Shown'                ,
                                            'Yes');

        'Not Shown' : FStr_SendToRegistry ( 'Write'                ,
                                             GSTR_SELECTION_A_TO_I ,
                                            'Shown'                ,
                                            'No');




      end; // ComBox_AToI //

  if Sender = ComBox_Characters
    then
      case ComBox_Characters.Items[ComBox_Characters.ItemIndex] of
         'Shown'     : FStr_SendToRegistry ( 'Write'                   ,
                                             GSTR_SELECTION_CHARACTERS ,
                                            'Shown'                    ,
                                            'Yes');

        'Not Shown' : FStr_SendToRegistry ( 'Write'                    ,
                                             GSTR_SELECTION_CHARACTERS ,
                                            'Shown'                    ,
                                            'No');


      end; // ComBox_Characters //

      if Sender = ComBox_Colours
        then
          case ComBox_Colours.Items[ComBox_Colours.ItemIndex] of
            'Shown'     : FStr_SendToRegistry ( 'Write'                 ,
                                                 GSTR_SELECTION_COLOURS ,
                                                'Shown'                 ,
                                                'Yes');

            'Not Shown' : FStr_SendToRegistry ( 'Write'                 ,
                                                 GSTR_SELECTION_COLOURS ,
                                                'Shown'                 ,
                                                'No');


          end; // ComBox_Colours //

     if Sender = ComBox_Images
       then
         case ComBox_Images.Items[ComBox_Images.ItemIndex] of
             'Shown'     : FStr_SendToRegistry ( 'Write'               ,
                                                  GSTR_SELECTION_IMAGES ,
                                                 'Shown'                ,
                                                 'Yes');

            'Not Shown' : FStr_SendToRegistry ( 'Write'                ,
                                                 GSTR_SELECTION_IMAGES ,
                                                'Shown'                ,
                                                'No');




     end; // ComBox_Colours //
end; // ComBox_SelectionChange //

procedure TFor_SudokuDeveloper.Edi_CharactersAltergridChange(Sender: TObject);
begin
  P_WriteFirstCharToRegistry ( Edi_CharactersAltergrid.Text [1]);

  P_DisplaySettings;
  P_DisplayGrid;
end; // Edi_CharactersAltergridChange //

procedure TFor_SudokuDeveloper.CheBox_SettingsChange(Sender: TObject);
begin
  if Sender = CheBox_ShowSolution
    then
      case CheBox_ShowSolution.Checked of
           true  : begin
                     FStr_SendToRegistry ( 'Write'         ,
                                            GSTR_SETTINGS  ,
                                           'Show Solution' ,
                                           'Yes');

                     Lab_Solution.Caption      := 'Move mouse cursor over Sudoku Grid '
                                         + 'to reveal Solution';
                     Lab_Solution1.Visible     := true;
                   end; // true //

           false : begin
                     FStr_SendToRegistry ( 'Write'         ,
                                            GSTR_SETTINGS  ,
                                           'Show Solution' ,
                                           'No');
                     Lab_Solution.Caption      := 'Move mouse cursor over Sudoku Grid '
                                         + 'to hide Solution';
                     Lab_Solution1.Visible     := false;;

                   end; // false //
      end; // CheBox_ShowSolution.Checked //


  if Sender = CheBox_Grid
    then
      case CheBox_Grid.Checked of
           true  : begin
                     FStr_SendToRegistry ( 'Write'        ,
                                            GSTR_SETTINGS ,
                                           'Show Grid'    ,
                                           'Yes');

                     But_Grid    .Enabled := true;
                     Lab_ShowGrid.Visible := true;
                   end; // true //

           false : begin
                     FStr_SendToRegistry ( 'Write'        ,
                                            GSTR_SETTINGS ,
                                           'Show Grid'    ,
                                           'No');

                      But_Grid    .Enabled := false;
                      Lab_ShowGrid.Visible := false;
                   end; // false //
      end; // CheBox_Grid.Checked //
end; // CheBox_SettingsChange //

procedure TFor_SudokuDeveloper.MenIte_Developer_ChooseSelectionClick(
  Sender: TObject);
begin
  For_SudokuDeveloper.Height := 190;
  For_SudokuDeveloper.Width  := 530;

  GroBox_Selection   .Visible := true;
  GroBox_Tutorial    .Visible := false;
 { PagCon_Selection.ActivePage := TabShe_AToI;

  GroBox_CharactersColoursImages.Visible := true;
  GroBox_SettingsSelection      .Visible := false;  }

end; // MenIte_Developer_EnterSelectionClick //

procedure TFor_SudokuDeveloper.MenIte_Developer_TutorialClick(
  Sender: TObject);
begin
  For_SudokuDeveloper.Height := 230;
  For_SudokuDeveloper.Width  := 378;

  GroBox_Tutorial .Visible := true;
  GroBox_Selection.Visible := false;
end; // MenIte_Developer_SettingsSelectionClick //

procedure TFor_SudokuDeveloper.RadBut_Off_Or_OnClick(Sender: TObject);
begin

  if Sender = RadBut_Off
    then
      begin
        GBoo_CellColour  := false;
        StrGri_Tutor.Repaint;

        FStr_SendToRegistry ( 'Write'        ,
                               GSTR_SETTINGS ,
                              'Tutor'        ,
                              'No')         ;
      end;

  if Sender = RadBut_On
    then
      begin
        GByt_SelectedCol[1] := 2;
        GByt_SelectedCol[2] := 4;
        GByt_SelectedCol[3] := 5;
        GByt_SelectedCol[4] := 8;

        GBoo_CellColour  := true;
        StrGri_Tutor.Repaint;

        FStr_SendToRegistry ( 'Write'        ,
                               GSTR_SETTINGS ,
                              'Tutor'        ,
                              'Yes')         ;
      end;
end;

procedure TFor_SudokuDeveloper.StrGri_TutorDrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
var
 LByt_Loop : byte;
begin
   if GBoo_CellColour
     then
        begin

          for  LByt_Loop := 1 to 4 do
          if ((ACol=GByt_SelectedCol[LByt_Loop]) and (ARow=1))
            then
            begin
              StrGri_Tutor.Canvas.Brush.Color:=clLime;
              StrGri_Tutor.Canvas.FillRect(aRect);

              //draw the original text
              StrGri_Tutor.Canvas.TextRect(aRect, aRect.Left, aRect.Top, StrGri_Tutor.Cells[ACol, ARow]);

              //draw focused rectangle if the current cell is selected by user
              if gdFocused in aState
                then
                  StrGri_Tutor.Canvas.DrawFocusRect(aRect);




        end;

end;

end;

function TFor_SudokuDeveloper.FBoo_WrapAround  ( PCha_Wraparound : char ) : boolean;
begin
  if PCha_Wraparound >= 'S'
    then
      begin
        FStr_SendToRegistry ( 'Write'                ,
                               GSTR_SELECTION_A_TO_I ,
                              'Wrap Around'          ,
                              'Yes');
        result := true;
      end
    else
      begin
        FStr_SendToRegistry ( 'Write'                ,
                               GSTR_SELECTION_A_TO_I ,
                              'Wrap Around'          ,
                              'No');
        result := false;
      end;
end; // FBoo_WrapAround //
procedure  TFor_SudokuDeveloper.P_DisplaySettings;
var
  LByt_AsciiFirstChar : byte;

  LCha_FirstChar  ,
  LCha_LastChar   : char;

  LStr_WrapAround : string;
begin
  LStr_WrapAround := FStr_SendToRegistry ( 'Read'                 ,
                                             GSTR_SELECTION_A_TO_I ,
                                            'Wrap Around'          ,
                                            ''  );

   case LStr_WrapAround of
     'No'   : begin

                LCha_FirstChar := FStr_SendToRegistry ( 'Read'                 ,
                                                         GSTR_SELECTION_A_TO_I ,
                                                        'New First Character'      ,
                                                        ''  )[1];

                 FStr_SendToRegistry ( 'Write'                            ,
                                        GSTR_SELECTION_A_TO_I_WRAP_AROUND ,
                                       'New First Character'              ,
                                       ''                                );


                Edi_CharactersAltergrid.Text    := LCha_FirstChar;
                Edi_CharactersAltergrid.Caption := LCha_FirstChar;

                LByt_AsciiFirstChar := ord (LCha_FirstChar)-1;
                LCha_LastChar := chr(LByt_AsciiFirstChar+9);

                Lab_SelectionAToI.Caption := LCha_FirstChar + ' to ' + LCha_LastChar;
                TabShe_AToI      .Caption := LCha_FirstChar + ' to ' + LCha_LastChar;

              end; // 'No' //

     'Yes' : begin
               LCha_FirstChar := FStr_SendToRegistry ( 'Read'                 ,
                                                        GSTR_SELECTION_A_TO_I_WRAP_AROUND ,
                                                       'New First Character'      ,
                                                       ''  )[1];

               FStr_SendToRegistry ( 'Write'                ,
                                      GSTR_SELECTION_A_TO_I ,
                                     'New First Character'  ,
                                      LCha_FirstChar       );

               Edi_CharactersAltergrid.Text    := LCha_FirstChar;;
               Edi_CharactersAltergrid.Caption := LCha_FirstChar;

               LByt_AsciiFirstChar := ord (LCha_FirstChar)-1;
               LCha_LastChar := chr((LByt_AsciiFirstChar+9)-26);

               Lab_SelectionAToI.Caption := LCha_FirstChar + ' to ' + LCha_LastChar;
               TabShe_AToI      .Caption := LCha_FirstChar + ' to ' + LCha_LastChar;

             end; // 'Yes' //

   end; // case LStr_WrapAround //
end; // P_DisplaySettings //

procedure  TFor_SudokuDeveloper.P_DisplayGrid;

var
  LByt_Across         ,
  LByt_Across_WA      ,
  LByt_AsciiFirstChar : byte;

  LCha_FirstChar      : char;

  LStr_WrapAround     : string;
begin
  LStr_WrapAround := FStr_SendToRegistry ( 'Read'                 ,
                                            GSTR_SELECTION_A_TO_I ,
                                           'Wrap Around'          ,
                                           ''  );

  LCha_FirstChar  := FStr_SendToRegistry ( 'Read'                 ,
                                            GSTR_SELECTION_A_TO_I ,
                                           'New First Character'  ,
                                           ''  )[1]               ;

  LByt_AsciiFirstChar := ord (LCha_FirstChar)-1;

  for LByt_Across := 1 to 9 do
    StriGri_CharactersAlterGrid.Cells[LByt_Across,1] :=
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
        StriGri_CharactersAlterGrid.Cells[LByt_Across,1] :=
          chr( (LByt_AsciiFirstChar + LByt_Across ) -26);
    end; // LStr_WrapAround = 'Yes' //

end; // P_DisplayGrid //

procedure TFor_SudokuDeveloper.P_WriteFirstCharToRegistry ( PCha_WriteToRegistry : char );
begin

  if not FBoo_WrapAround  ( PCha_WriteToRegistry)
    then
      FStr_SendToRegistry ( 'Write',
                             GSTR_SELECTION_A_TO_I,
                            'New First Character',
                             PCha_WriteToRegistry)
    else
      FStr_SendToRegistry ( 'Write',
                             GSTR_SELECTION_A_TO_I_WRAP_AROUND,
                            'New First Character',
                             PCha_WriteToRegistry );

 end; // P_WriteFirstCharToRegistry //

procedure  TFor_SudokuDeveloper.P_DisplayNumbersInHeader (PStrGri_Display : TStringGrid);
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
end; // P_DisplayNumbersInHeader // }


end.



