unit f_dialog;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, FileCtrl,
  StdCtrls, ExtCtrls, Buttons, CheckLst, types, LCLType;

type

  { TFor_Dialog }

  TFor_Dialog = class(TForm)
    CheLisBox_Delete: TCheckListBox;
    FilLisBox_Dialog: TFileListBox;
    GroBox_Dialog                  : TGroupBox;
    GroBox_Delete: TGroupBox;
    GroBox_PathAndFileListBox: TGroupBox;
      Lab_NoFilesFound             : TLabel;

      GroBox_FilenameAndMask       : TGroupBox;
        LabEdi_Filename            : TLabeledEdit;
        ComBox_Mask                : TComboBox;

      GroBox_DialogAndCloseButtons : TGroupBox;
        BitBtn_Dialog              : TBitBtn;
        BitBtn_Close               : TBitBtn;
        Lab_Path: TLabel;


    procedure FilLisBox_DialogDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
       procedure FormActivate(Sender: TObject);
    procedure FilLisBox_DialogClick (Sender: TObject);

    procedure LabEdi_FilenameChange(Sender: TObject);

  private
    { private declarations }

  public
    { public declarations }

      GBoo_LoadAndSaveDialog   ,
      GBoo_CopyAndDeleteDialog : boolean;

      GStr_PathAndFileName ,
      GStr_ExtensionOnly   ,
      GStr_FileNameOnly    ,
      GStr_PathToFiles     ,
      GStr_FileName        ,
      GStr_Button          ,
      GStr_Dialog          ,
      GStr_Title           ,
      GStr_Path            ,
      GStr_Mask            : string;

      function FBoo_Execute      : boolean;

      procedure P_Dialog              ( PByt_HowManyFiles : byte );
      procedure P_LoadOrSaveDialog    ( PByt_HowManyFiles : byte );
      procedure P_CopyOrDeleteDialog  ( PByt_HowManyFiles : byte );

      function  FByt_HowManyFiles ( PStr_PAthAndFilename : string ) : byte;
  end;

const
  G_LOAD_DIALOG = 'L'; G_SAVE_DIALOG   = 'S';
  G_COPY_DIALOG = 'C'; G_DELETE_DIALOG = 'D';

  G_NO_FILES_FOUND = 0; G_MAX_FILE_NUMBER = 5;
var
  For_Dialog: TFor_Dialog;

implementation

{$R *.lfm}

{ TFor_Dialog }

procedure TFor_Dialog.FormActivate(Sender: TObject);
var
  LByt_HowManyFiles : byte;
begin
  LByt_HowManyFiles := FByt_HowManyFiles (GStr_PathToFiles );

  For_Dialog      .Caption       := GStr_Title;
  Lab_Path        .Caption       := GStr_Path;

  FilLisBox_Dialog.Directory     := GStr_PathToFiles;

  FilLisBox_Dialog.UpdateFileList;

  LabEdi_Filename .Text := '';
  ComBox_Mask     .Text          := GStr_Mask;

  FilLisBox_Dialog.Mask          := GStr_Mask;


  P_Dialog ( LByt_HowManyFiles );
end; // FormActivate //

procedure TFor_Dialog.FilLisBox_DialogDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
begin
  with (Control as TFileListBox).Canvas do
    begin
      if odSelected in State
        then
          begin
            Brush.Color := clWhite;
            Font.Color  := clBlack;
          end;

      FillRect(ARect);
      TextOut(ARect.Left,ARect.Top,(Control as TFileListBox).Items[Index]);

      if odFocused In State
        then
          begin
            Brush.Color:=FilLisBox_Dialog.Color;
            DrawFocusRect(ARect);
          end;
    end;
end;

procedure TFor_Dialog.LabEdi_FilenameChange(Sender: TObject);
begin
  if (LabEdi_Filename.Text = '')
    then
      BitBtn_Dialog.Enabled := false
    else
      BitBtn_Dialog.Enabled := true;
end;

procedure TFor_Dialog.FilLisBox_DialogClick(Sender: TObject);
begin
  if GStr_Dialog = G_LOAD_DIALOG
    then
      begin
        GStr_PathAndFileName    := FilLisBox_Dialog.FileName;
       // LabEdi_Filename.Enabled := true;
        LabEdi_Filename.Caption := ExtractFileName(GStr_PathAndFileName);
      end;
end; // FilLisBox_OpenDialogClick //

function TFor_Dialog.FBoo_Execute : boolean;
begin

  result := (ShowModal = mrOK);

  case GStr_Dialog of
    G_LOAD_DIALOG :
      GStr_FileName := GStr_PathAndFileName;

    G_SAVE_DIALOG :
      begin
        GStr_FileNameOnly := LabEdi_Filename.Caption;

        if ( GStr_FileNameOnly = '' )
          then
          else
            GStr_FileName := GStr_PathToFiles
                           + GStr_FileNameOnly
                           + '.txt';

       end; // G_SAVE_DIALOG //


  end; // case GStr_Dialog of //
end; // Execute //
procedure TFor_Dialog.P_Dialog ( PByt_HowManyFiles : byte );
begin
  For_Dialog.left    := 441;
  For_Dialog.top     := 186;
  For_Dialog.width   := 295;

  if PByt_HowManyFiles = G_NO_FILES_FOUND
    then
      begin
        For_Dialog.Caption := For_Dialog.Caption + ':- '
                                                 + Lab_NoFilesFound.Caption;

        case GStr_Dialog of
          G_LOAD_DIALOG :
            begin
              For_Dialog                 .Height  := 125;
                GroBox_PathAndFileListBox.Height  := 45;

                GroBox_FilenameAndMask      .Visible := false;

                GroBox_DialogAndCloseButtons.Visible := true;
                GroBox_DialogAndCloseButtons.Top     := 37;
                  BitBtn_Dialog             .Visible := false;
                  BitBtn_Close              .Visible := true;
                  BitBtn_Close              .Enabled := True;
                  BitBtn_Close              .Left    := 90;
            end; // G_LOAD_DIALOG //

          G_SAVE_DIALOG :
            begin
              For_Dialog                 .Height  := 200;
                GroBox_PathAndFileListBox.Height  := 45;

                GroBox_FilenameAndMask   .Visible := true;
                GroBox_FilenameAndMask   .Top     := 38;
                GroBox_FilenameAndMask   .Height  := 68;

                GroBox_DialogAndCloseButtons.Visible := true;
                GroBox_DialogAndCloseButtons.Top  := 110;
                  BitBtn_Dialog             .Visible := true;
                  BitBtn_Dialog             .Caption := '&Save';
                  BitBtn_Dialog             .Enabled := false;
                  BitBtn_Dialog             .Left    := 24;
                  BitBtn_Close              .Visible := true;
                  BitBtn_Close              .Enabled := True;
                  BitBtn_Close              .Left    := 160;
            end; // G_SAVE_DIALOG //
        end; // case GStr_Dialog //
      end // LByt_HowManyFiles = G_NO_FILES_FOUND //
    else  // Files Found //
      begin
        if ( GStr_Dialog = G_SAVE_DIALOG ) or ( GStr_Dialog = G_LOAD_DIALOG )
          then
            P_LoadOrSaveDialog ( PByt_HowManyFiles );

        if ( GStr_Dialog = G_COPY_DIALOG ) or ( GStr_Dialog = G_DELETE_DIALOG )
          then
            P_CopyOrDeleteDialog ( PByt_HowManyFiles );
      end; // Files Found //


end; // P_Dialog //

procedure TFor_Dialog.P_LoadOrSaveDialog ( PByt_HowManyFiles : byte );
begin
  case GStr_Dialog of
    G_SAVE_DIALOG :
      begin
        LabEdi_Filename.Enabled := true;
        BitBtn_Dialog  .Caption := '&Save';
        BitBtn_Close   .Enabled := True;
      end; // G_SAVE_DIALOG //

    G_LOAD_DIALOG :
      begin
        LabEdi_Filename.Enabled := false;
        BitBtn_Dialog  .Caption := '&Load';
        BitBtn_Close   .Enabled := True;
      end; // G_LOAD_DIALOG //
  end; // GStr_Dialog //

  if ( PByt_HowManyFiles >= 1 ) and ( PByt_HowManyFiles <= G_MAX_FILE_NUMBER  )
    then
      begin
        For_Dialog                  .Height  := 236;

        GroBox_PathAndFileListBox   .Top     := 0;
        GroBox_PathAndFileListBox   .visible := true;

        GroBox_FilenameAndMask      .Top     := 72;
        GroBox_FilenameAndMask      .visible := true;

        GroBox_DialogAndCloseButtons.Top     := 200;
        GroBox_DialogAndCloseButtons.visible := true;

        GroBox_Delete               .visible := false;

        For_Dialog                  .Height  := 300 + ( 16 * ( PByt_HowManyFiles - 1 ) );

        GroBox_PathAndFileListBox   .height  := 72  + ( 16 * ( PByt_HowManyFiles - 1 ) );
          FilLisBox_Dialog          .Height  := 18  + ( 16 * ( PByt_HowManyFiles - 1 ) );
          FilLisBox_Dialog          .Visible := True;

        GroBox_FilenameAndMask      .Top     := 72  + ( 16 * ( PByt_HowManyFiles - 1 ) );
        GroBox_DialogAndCloseButtons.Top     := 200 + ( 16 * ( PByt_HowManyFiles - 1 ) );
      end // PByt_HowManyFiles > 1 //
    else
      begin
        For_Dialog                  .Height  := 300 + ( 12 * ( G_MAX_FILE_NUMBER - 1) );

        GroBox_PathAndFileListBox   .height  := 75  + ( 16 * ( G_MAX_FILE_NUMBER - 1) );
          FilLisBox_Dialog          .Height  := 18  + ( 16 * ( G_MAX_FILE_NUMBER - 1) );
          FilLisBox_Dialog          .Visible := True;

        GroBox_FilenameAndMask      .Top     := 70 + ( 16 * ( G_MAX_FILE_NUMBER - 1) );
        GroBox_FilenameAndMask      .visible := true;

        GroBox_DialogAndCloseButtons.Top     := 160 + ( 16 * ( G_MAX_FILE_NUMBER - 1) );          ;
        GroBox_DialogAndCloseButtons.visible := true;

    //  GroBox_DialogAndCloseButtons.Top     := 170 + ( 12 * ( G_MAX_FILE_NUMBER - 1 ) );
      end;

end; // P_LoadOrSaveDialog //

procedure TFor_Dialog.P_CopyOrDeleteDialog ( PByt_HowManyFiles : byte );
begin
  case GStr_Dialog of
    G_COPY_DIALOG   : BitBtn_Dialog.Caption := '&Copy';

    G_DELETE_DIALOG : BitBtn_Dialog.Caption := '&Delete';
  end; // GStr_Dialog //

   if ( PByt_HowManyFiles >= 1 )
    then
      begin
        For_Dialog                  .width   := 160;

        Lab_NoFilesFound            .Visible := false;
        FilLisBox_Dialog            .Visible := false;
        GroBox_FilenameAndMask      .Visible := false;

        GroBox_Delete               .visible := false;

        GroBox_DialogAndCloseButtons.Top     := 90;
        GroBox_DialogAndCloseButtons.Left    := 20;

        GroBox_Delete.Top  := 24;
        GroBox_Delete.Left := 34;

        GroBox_Delete.Visible := true;


      end; // ( PByt_NumberOfFiles >= 1 ) //

end; // P_CopyOrDeleteDialog //  }

function  TFor_Dialog.FByt_HowManyFiles ( PStr_PAthAndFilename : string ) : byte;
var
  LSerRec_SearchResult : TSearchRec;
  LByt_FileCount : byte;
  LStr_FileName  : string;
begin
  LStr_FileName := PStr_PAthAndFilename + '*.*';
  LByt_FileCount := 0;
  if findfirst(LStr_FileName,faAnyfile,LSerRec_SearchResult) = 0
    then
      begin
        while FindNext ( LSerRec_SearchResult ) = 0 do
          inc ( LByt_FileCount );
        findclose(LSerRec_SearchResult);
      end;
  result := LByt_FileCount-1;
end; // FByt_HowManyFiles //
end.

