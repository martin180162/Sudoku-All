unit u_text_file;

{$mode objfpc}{$H+}

interface
uses

  Classes, SysUtils, Dialogs,  Grids;
const
  G_PATH_TO_DATA           = '\data\';


function  FCha_CheckFile         ( PStr_FileName        : string ) : char;
function  FBoo_DirectoryExists   ( PStr_DirName         : string ) : boolean;



implementation

function FCha_CheckFile ( PStr_FileName : string ) : char;
  var
    LStr_FileName : string;
    LCha_Line     : char;
    LTexFil_FileName         : TextFile;
  begin
    LStr_FileName := GetCurrentDir + G_PATH_TO_DATA + PStr_FileName;

    AssignFile(LTexFil_FileName,LStr_FileName);
    Reset(LTexFil_FileName);

    Read(LTexFil_FileName,LCha_Line);

    closefile(LTexFil_FileName);

    result := LCha_Line;

  end; // FCha_CheckFile //

function  FBoo_DirectoryExists   ( PStr_DirName         : string ) : boolean;
var
   LStr_DirName : string;

begin
   LStr_DirName := GetCurrentDir + '\' + PStr_DirName;

   if DirectoryExists (LStr_DirName)
     then
         FBoo_DirectoryExists := True
     else
         FBoo_DirectoryExists := False;

end; // FBoo_DirectoryExists //




end.

