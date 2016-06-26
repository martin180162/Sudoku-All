unit u_registry;

{$mode objfpc}{$H+}

interface


uses
  Classes, SysUtils, Registry;

type
 TArrSinCha_Reg    = array [1..9] of char;
function FBoo_PathExists          ( PStr_AnyPath       : string )
                                                       : boolean ;

procedure P_CreateRegPath         ( PStr_AnyPath       : string );

function FStr_SendToRegistry      ( PStr_ReadOrWrite   : string  ;
                                    PStr_Path          : string  ;
                                    PStr_Setting       : string  ;
                                    PStr_Value         : string )
                                                  : string  ;

function FStr_SendArrayToRegistry ( PStr_ReadOrWrite   : string  ;
                                    PStr_Path          : string  ;
                                    PStr_AnyName       : string  ;
                                    PArrCha_AnyValue   : TArrSinCha_Reg)
                                                       : string ;




{function FStr_ReadRegArray   ( PStr_AnyPath       : string )
                                                  : string  ; }

//  function FStr_ReadFromWrapAround : string;



implementation

function FBoo_PathExists   ( PStr_AnyPath : string ) : boolean ;
var
   LReg_RegistryEntry     : TRegistry;
begin
  LReg_RegistryEntry := TRegistry.Create;
  LReg_RegistryEntry.RootKey := HKEY_CURRENT_USER;

  if (not LReg_RegistryEntry.KeyExists( PStr_AnyPath) )
    then
      result := false
    else
      result := true;
end; // FBoo_PathExists //

procedure P_CreateRegPath    ( PStr_AnyPath: string );
var
  LReg_RegistryEntry : TRegistry;
begin
  LReg_RegistryEntry := TRegistry.Create;

  LReg_RegistryEntry.RootKey := HKEY_CURRENT_USER;;
  LReg_RegistryEntry.OpenKey(PStr_AnyPath,true);

  LReg_RegistryEntry.CreateKey(PStr_AnyPath);
end; // P_CreateRegistryPath //

function FStr_SendToRegistry ( PStr_ReadOrWrite : string ;
                               PStr_Path        : string ;
                               PStr_Setting     : string ;
                               PStr_Value       : string )
                                                : string ;
var
  LReg_RegistryEntry : TRegistry;
begin
  LReg_RegistryEntry := TRegistry.Create;

  LReg_RegistryEntry.RootKey := HKEY_CURRENT_USER;;
  LReg_RegistryEntry.OpenKey(PStr_Path,true);

  case PStr_ReadOrWrite of
    'Write' : LReg_RegistryEntry.WriteString ( PStr_Setting ,PStr_Value  );

    'Read'  : result := LReg_RegistryEntry.ReadString(PStr_Setting);
  end; // case PStr_ReadOrWrite //

end; // FStr_SendToRegistry //
function FStr_SendArrayToRegistry ( PStr_ReadOrWrite   : string  ;
                                    PStr_Path          : string  ;
                                    PStr_AnyName       : string  ;
                                    PArrCha_AnyValue   : TArrSinCha_Reg)
                                                       : string ;
var
  LArrCha_AnyValue   : TArrSinCha_Reg;
  LReg_RegistryEntry : TRegistry;
  LByt_RegistryLoop  : byte;
  LStr_AnyName       : string;
begin
  LReg_RegistryEntry := TRegistry.Create;

  LReg_RegistryEntry.RootKey := HKEY_CURRENT_USER;;
  LReg_RegistryEntry.OpenKey(PStr_Path,true);

   case PStr_ReadOrWrite of
     'Write' : for LByt_RegistryLoop := 1 to 9 do
                LReg_RegistryEntry.WriteString ( PStr_AnyName
                                               + inttostr( LByt_RegistryLoop )
                                               , PArrCha_AnyValue[ LByt_RegistryLoop]);




    'Read'  : begin
              LStr_AnyName := '';

              for LByt_RegistryLoop := 1 to 9 do
                LStr_AnyName := LStr_AnyName + LReg_RegistryEntry.ReadString(PStr_AnyName+inttostr(LByt_RegistryLoop));

              result := LStr_AnyName;
    end; // 'Read' //

  end; // case PStr_ReadOrWrite //

end; // FStr_SendArrayToRegistry //

{function FStr_ReadRegArray ( PStr_AnyPath : String ) : string;
   var
     LReg_RegistryEntry     : TRegistry;
     LByt_Across : byte;


   begin
     LStr_WrapAround := ' ';

     LReg_RegistryEntry := TRegistry.Create;

     LReg_RegistryEntry.RootKey := HKEY_CURRENT_USER;;
     LReg_RegistryEntry.OpenKey( PStr_AnyPath,true);

     for LByt_Across := 1 to 9 do
       LStr_WrapAround := LStr_WrapAround + LReg_RegistryEntry.ReadString('WrapAround'+inttostr(LByt_Across));

     result  := LStr_WrapAround;
end; // FStr_ReadRegArray // }

{ function TFor_Sudoku.FStr_ReadFromWrapAround : String;
   var
     LReg_RegistryEntry     : TRegistry;
     LByt_Count,LByt_Across : byte;

     LStr_WrapAround : string;
   begin
     LStr_WrapAround := ' ';

     LReg_RegistryEntry := TRegistry.Create;

     LReg_RegistryEntry.RootKey := HKEY_CURRENT_USER;;
     LReg_RegistryEntry.OpenKey( '\Software\Sudoku\Selection\A To I\Wrap Around',true);

     for LByt_Across := 1 to 9 do
       LStr_WrapAround := LStr_WrapAround + LReg_RegistryEntry.ReadString('RegistryArray'+inttostr(LByt_Across));

     result  := LStr_WrapAround;



end; // FStr_ReadFromWrapAround //    }
end.

