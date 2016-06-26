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

{function FChaDynArr_Reg ( PStr_AnyPath,PStr_ReadWrite ,
                          PStr_AnyName                : string;
                          PByt_AnyNumber              : byte;
                          PSinDynArrCha_AnyArray      : TSinDynArrCha_RegArray )
                                                      : TSinDynArrCha_RegArray;


function FStr_ChangeRegistrySetting ( PStr_RegistryPath    : string  ;
                                      PStr_RegistrySetting : string  ;
                                      PStr_RegistryValue   : string ): string;

function FStr_ReadRegistrySetting ( PStr_RegistryPath    : string  ;
                                    PStr_RegistrySetting : string  ) : string;

procedure P_CreateRegistryPath    ( PStr_RegistryPath    : string );   }



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
end.
    {implementation

function FChaDynArr_Reg ( PStr_AnyPath,PStr_ReadWrite ,
                          PStr_AnyName                : string;
                          PByt_AnyNumber              : byte;
                          PSinDynArrCha_AnyArray      : TSinDynArrCha_RegArray )
                                                      : TSinDynArrCha_RegArray;
var
  LSinDynArrCha_AnyArray  : TSinDynArrCha_RegArray;
  LReg_RegistryEntry      : TRegistry;

  LByt_Across            : byte;
begin
  setlength (LSinDynArrCha_AnyArray,PByt_AnyNumber);

  for  LByt_Across := 1 to PByt_AnyNumber do
    LSinDynArrCha_AnyArray[LByt_Across] := ' ';

  LReg_RegistryEntry := TRegistry.Create;

  LReg_RegistryEntry.RootKey := HKEY_CURRENT_USER;;
  LReg_RegistryEntry.OpenKey(PStr_AnyPath,true);

  case PStr_ReadWrite of
    'Read'  : for LByt_Across := 1 to PByt_AnyNumber do
                begin
                  LReg_RegistryEntry.ReadString(LSinDynArrCha_AnyArray[LByt_Across]);
                  result[LByt_Across] :=  LSinDynArrCha_AnyArray[LByt_Across];
                end; // for LByt_Across //

    'Write' : for LByt_Across := 1 to PByt_AnyNumber do
                begin
                  LReg_RegistryEntry.WriteString(PStr_AnyName+inttostr(LByt_Across), PSinDynArrCha_AnyArray[LByt_Across]);
                  result[LByt_Across] := LSinDynArrCha_AnyArray[LByt_Across];
                end;
  end;
end; // FCha_RegArray //

procedure P_CreateRegistryPath ( PStr_RegistryPath : string );
var
  LReg_RegistryEntry : TRegistry;
begin
  LReg_RegistryEntry := TRegistry.Create;

  LReg_RegistryEntry.RootKey := HKEY_CURRENT_USER;;
  LReg_RegistryEntry.OpenKey(PStr_RegistryPath,true);

  if not LReg_RegistryEntry.KeyExists(PStr_RegistryPath)
    then
      LReg_RegistryEntry.CreateKey(PStr_RegistryPath);
end; // P_CreateRegistryPath //
function FStr_ChangeRegistrySetting ( PStr_RegistryPath    : string  ;
                                      PStr_RegistrySetting : string  ;
                                      PStr_RegistryValue   : string ): string;
var
  LReg_RegistryEntry : TRegistry;
begin
  LReg_RegistryEntry := TRegistry.Create;

  LReg_RegistryEntry.RootKey := HKEY_CURRENT_USER;;
  LReg_RegistryEntry.OpenKey(PStr_RegistryPath,true);

  LReg_RegistryEntry.WriteString(PStr_RegistrySetting,PStr_RegistryValue);
  result := PStr_RegistryValue;
end; // P_ChangeRegistrySetting //

function FStr_ReadRegistrySetting ( PStr_RegistryPath    : string  ;
                                    PStr_RegistrySetting : string  ) : string;
var
  LReg_RegistryEntry : TRegistry;
begin
  LReg_RegistryEntry := TRegistry.Create;

  LReg_RegistryEntry.RootKey := HKEY_CURRENT_USER;;
  LReg_RegistryEntry.OpenKey(PStr_RegistryPath,true);

  result := LReg_RegistryEntry.ReadString(PStr_RegistrySetting);

end; // FStr_ReadRegistrySetting // }




