unit u_bitmap;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils , Graphics, Dialogs;

function FBit_LoadImage ( PStr_ImageFilename : string ) : TBitmap;

implementation

function FBit_LoadImage ( PStr_ImageFilename : string ) : TBitmap;
var
  LPic_Image : TPicture;
{var
  LPng_Image : TPortableNetworkGraphic;
  LBit_Image : TBitmap; }
begin
  LPic_Image := TPicture.Create;
  LPic_Image.LoadFromFile( GetCurrentDir + '\Green_Tick.png');
  LPic_Image.SaveToFile  ( GetCurrentDir + '\Green_Tick.bmp');
 { LPng_Image := TPortableNetworkGraphic.Create;
  LBit_Image := TBitmap.Create;
  try
    LPng_Image.LoadFromFile(GetCurrentDir + '\' + 'Green_Tick.png');
    LBit_Image.Assign( LPng_Image );
   // result := LBit_Image;
    LBit_Image.SaveToFile( 'Green_Tick.bmp');
  finally
    LBit_Image.Free;
  end; // try - finally //  }
end; // FBit_LoadImage //



end.

