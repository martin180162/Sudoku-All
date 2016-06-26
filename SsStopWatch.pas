{------------------------------------------------------------------------------}
{ Copyright © 2000-2001, Simon Armstrong.  All Rights Reserved.                }
{                                                                              }
{ Copyright:                                                                   }
{ All SadMan Software source code is copyrighted by Simon Armstrong (hereafter }
{ "author"), and shall remain the exclusive property of the author. This       }
{ software and any accompanying documentation are protected by United Kingdom  }
{ copyright law and also by International Treaty provisions. Any use of this   }
{ software in violation of copyright law or the terms of this agreement will   }
{ be prosecuted to the best of the author's ability.                           }
{                                                                              }
{ Under no conditions may you remove the copyright notices made part of the    }
{ software or documentation.                                                   }
{                                                                              }
{ Distribution Rights:                                                         }
{ You are granted a non-exlusive, royalty-free right to produce and distribute }
{ compiled binary files (executables, DLLs, etc.) that are built with any of   }
{ the source code unless specifically stated otherwise.                        }
{ You are further granted permission to redistribute any of the source code in }
{ source code form, provided that the original archive as found on the         }
{ SadMan Software web site (www.sadmansoftware.com) is distributed unmodified. }
{                                                                              }
{ Restrictions:                                                                }
{ Without the express written consent of the author, you may not:              }
{   * Distribute modified versions of any SadMan Software source code by       }
{     itself. You must include the original archive as you found it at the web }
{     site.                                                                    }
{   * Sell or lease any portion of SadMan Software source code. You are, of    }
{     course, free to sell any of your own original code that works with,      }
{     enhances, etc. SadMan Software source code.                              }
{   * Distribute SadMan Software source code for profit.                       }
{                                                                              }
{ Warranty:                                                                    }
{ There is absolutely no warranty of any kind whatsoever with any of this      }
{ source code (hereafter "software"). The software is provided to you "AS-IS", }
{ and all risks and losses associated with it's use are assumed by you. In no  }
{ event shall the author of the softare, Simon Armstrong, be held accountable  }
{ for any damages or losses that may occur from use or misuse of the software. }
{                                                                              }
{ Support:                                                                     }
{ Support is provided via email to Support@sadmansoftware.com. However, I can  }
{ not guarantee any support whatsoever. While I do try to answer all questions }
{ that I receive and address all problems that are reported to me, I can not   }
{ guarantee that this will always be so.                                       }
{------------------------------------------------------------------------------}
unit SsStopWatch;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF VER80}
  WinProcs,
{$ELSE}
{$ENDIF}
{$IFnDEF FPC}
  Windows,
{$ELSE}
  LCLIntf, LCLType, LMessages,
{$ENDIF}
  SysUtils, Classes;

type
  TssStopWatch = class(TComponent)
  private
    FRunning: boolean;
    FRunningTotal: TDateTime;
    FStartTime: TDateTime;
    FElapsedTime: TDateTime;
    function GetElapsedTime: TDateTime;
    procedure Update;
  public
    procedure Reset;
    procedure Start;
    procedure Stop;
    property ElapsedTime: TDateTime read GetElapsedTime;
  published
  end;

procedure Register;

implementation

{$IFDEF WIN32}
{$R *.r32}
{$ELSE}
{$R *.r16}
{$ENDIF}

procedure Register;
begin
  RegisterComponents('SadMan', [TssStopWatch]);
end;

{ TssStopWatch }

function TssStopWatch.GetElapsedTime: TDateTime;
begin
  if FRunning then
    Update;
  result := FElapsedTime;
end;

procedure TssStopWatch.Update;
begin
  FElapsedTime := Now - FStartTime + FRunningTotal;
end;

procedure TssStopWatch.Reset;
begin
  FRunningTotal := 0.0;
  FElapsedTime := 0.0;
  FStartTime := Now;
end;

procedure TssStopWatch.Start;
begin
  if not FRunning then begin
    FRunning := true;
    FStartTime := Now;
  end;
end;

procedure TssStopWatch.Stop;
begin
  if FRunning then begin
    Update;
    FRunningTotal := FElapsedTime;
    FRunning := false;
  end;
end;

end.
