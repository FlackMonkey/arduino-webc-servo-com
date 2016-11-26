unit ArduinoWebcServoComDelphi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm4 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    Button5: TButton;
    ComboBox1: TComboBox;
    procedure ComboBox1Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;
  CommPort : string;
  hCommFile: THandle;
  MoveAngle: string;

implementation

{$R *.dfm}

procedure memoAddLine(NewLineText : string);
var
  today : TDateTime;
begin
  today := Now;
  Form4.Memo1.Lines.Add(FormatDateTime('dd/mm/yyyy tt', today)+ ' : ' +NewLineText);
end;

procedure TForm4.Button1Click(Sender: TObject);
var
   Command : string;
   NumberWritten: DWORD;
begin
  Command := 'X+'+MoveAngle+'Y+0';
  memoAddLine(Command);
  WriteFile(hCommFile,
            PChar(Command)^,
            Length(Command),
            NumberWritten,
            nil)
end;

procedure COM_PORT_SEND_STR(Command: String);
var
  NumberWritten: DWORD;
begin
   WriteFile(hCommFile,
            PChar(Command)^,
            Length(Command),
            NumberWritten,
            nil)
end;

procedure DO_COMMAND(CommandStr : String);
begin
       memoAddLine(CommandStr);
       COM_PORT_SEND_STR(CommandStr);
end;



procedure TForm4.Button2Click(Sender: TObject);
var
   Command : string;
   NumberWritten: DWORD;
begin
  Command := 'X-'+MoveAngle+'Y+0';
  DO_COMMAND(Command);
end;

procedure TForm4.Button3Click(Sender: TObject);
var
   Command : string;
   NumberWritten: DWORD;
begin
  Command := 'X+0Y-'+MoveAngle;
  DO_COMMAND(Command);
end;

procedure TForm4.Button4Click(Sender: TObject);
var
   Command : string;
   NumberWritten: DWORD;
begin
  Command := 'X+0Y+'+MoveAngle;
  DO_COMMAND(Command);
end;

procedure TForm4.Button5Click(Sender: TObject);
var
   Command : string;
   NumberWritten: DWORD;
begin
  Command := 'X=90Y=90';
  DO_COMMAND(Command);
end;

procedure TForm4.ComboBox1Change(Sender: TObject);
var
  SelectedText:string;
begin
  SelectedText := ComboBox1.Items.Strings[ComboBox1.itemindex];
  MoveAngle := SelectedText;
end;





initialization
  CommPort := 'COM3';
  MoveAngle := '45';
  //memoAddLine('Initing port: '+CommPort);
  hCommFile := CreateFile(PChar(CommPort),
                          GENERIC_WRITE,
                          0,
                          nil,
                          OPEN_EXISTING,
                          FILE_ATTRIBUTE_NORMAL,
                          0);
  //TODO com port - busy resolver
end.

