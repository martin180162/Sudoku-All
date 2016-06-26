unit u_suduku_registry;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,

  u_registry,
  u_sudoku_constants;

function  FStr_NumOrChar : string;

{function  FStr_Settings  ( PCha_FirstChar ,
                           PCha_LastChar  : char ) : string;  }

procedure P_Selection    ( PStr_Settings  : string;
                           PStr_Selection : string);



implementation


function FStr_NumOrChar : string;
   var
     LStr_NumOrChar : string;
   begin
      LStr_NumOrChar := FStr_ReadRegistrySetting ( GSTR_REGISTRY_PATH
                                                + GSTR_SETTINGS,
                                                 'Number Or Character' );
      case LStr_NumOrChar of
        GSTR_NUMBER    : Result := GSTR_NUMBER;
        GSTR_CHARACTER : Result := GSTR_CHARACTER;
      end; // case LStr_NumOrChar //
   end; // FStr_NumOrChar //

procedure P_Selection ( PStr_Settings  : string;
                        PStr_Selection : string);
var
  LByt_Across           ,
  LByt_FirstChar        : byte;

  LCha_FirstChar        ,
  LCha_LastChar         : char;
begin
   case PStr_Settings of
     GSTR_CHANGE : begin
                   end;

     GSTR_READ   : begin
                   end;

     GSTR_SHOW   : begin
                   end;

     GSTR_HIDE   : begin
                   end;

   end; // case PStr_Settings //
end; // P_Selection //

{function FStr_Settings ( PCha_FirstChar, PCha_LastChar : char ) : string;
begin
   result := '( ' + PCha_FirstChar + ' - ' + PCha_LastChar + ' )';                                   +
end; // FStr_Settings //   }

 end.
