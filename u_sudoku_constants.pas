unit u_sudoku_constants;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;
const
{ *****************************************************************************}
                            GBYT_NUMBERS_ONLY = 0                              ;
{ **************************************************************************** }
{                          -------------------------                           }
{ ---------------------- [ Store in Windows Registry ] ----------------------  }
{                          -------------------------                           }
  GSTR_SETTINGS            = '\Software\Sudoku\Settings'                       ;

  GSTR_SELECTION           = '\Software\Sudoku\Selection'                      ;
    GSTR_SELECTION_A_TO_I  = '\Software\Sudoku\Selection\A To I\'              ;
       GSTR_SELECTION_A_TO_I_WRAP_AROUND
                              = '\Software\Sudoku\Selection\A To I\Wrap Around';

    GSTR_SELECTION_CHARACTERS = '\Software\Sudoku\Selection\Characters'        ;
    GSTR_SELECTION_COLOURS    = '\Software\Sudoku\Selection\Colours'           ;
    GSTR_SELECTION_IMAGES     = '\Software\Sudoku\Selection\Images'            ;
{ ---------------------------------------------------------------------------- }
{ **************************************************************************** }
{                                    -------                                   }
{ -------------------------------- [ Ratings ] ------------------------------- }
{                                    -------                                   }
      GBYT_COMBOX_EASY               = 0                                       ;
      GBYT_COMBOX_MODERATE           = 1                                       ;
      GBYT_COMBOX_CHALLENGING        = 2                                       ;

      GSTR_RATINGS_CSV               = 'ratings.csv'                           ;
{ ---------------------------------------------------------------------------- }
{ *****************************************************************************}
{                              ------------------                              }
{ -------------------------- [    Puzzle  Grid    ] -------------------------- }
{ ---------------------------[ Save or Load Files ] -------------------------- }
{                              ------------------                              }
                  GCHA_SAVE_FILES = 'S'; GCHA_LOAD_FILES   = 'L'               ;
{ ---------------------------------------------------------------------------- }
{ **************************************************************************** }
            //  GCHA_COPY_FILES = 'C'; GCHA_DELETE_FILES = 'D';
{ **************************************************************************** }
{                          -------------------------                           }
{ ---------------------- [ String Grid  ( Draw Cell ) ] ---------------------- }
{                          -------------------------                           }
                              GCHA_GRIDLINES  = 'G'                            ;
                              GCHA_CELLCOLOUR = 'C'                            ;
                              GCHA_TEXTCOLOUR = 'T'                            ;
{ ---------------------------------------------------------------------------- }
{ *****************************************************************************}
{                                -------------                                 }
{ ---------------------------- [ Cell Colours ) ] ---------------------------- }
{                                -------------                                 }
                          GBYT_EMPTY_CELL_COLOUR     = 1                       ;
                          GBYT_SAME_CELL_COLOUR      = 2                       ;
                          GBYT_DIFFERENT_CELL_COLOUR = 3                       ;
{ ---------------------------------------------------------------------------- }


implementation

end.

