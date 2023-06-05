unit CaptchaVerification;

interface

uses Classes, SysUtils, Windows, Graphics;

type
  TCaptchaVerification = class(TComponent)
  Type
    TCharCase = (Lower, Upper, Number);
    TCharCases = set of TCharCase;

  const
    CharCaseAll = [Lower, Upper, Number];
    CharCaseLetter = [Lower, Upper];
  private
    FCaptchaString: string;
    FCaptchaBitmap: TBitmap;
    FCharCase: TCharCases;
    function GenerateCaptchaString: string;
    procedure DrawLetter(ch: Char; angle, nextPos: Integer);
    procedure DrawLines(aLineCount: Integer = 15);
  public
    constructor Create(aOwner: TComponent; aCharCase: TCharCases = [Upper, Number]); reintroduce;
    destructor Destroy; override;
    procedure RefreshBitmap;
    function Validate(const aValue: string; aCaseSensetive: boolean = True): boolean;
    property Image: TBitmap read FCaptchaBitmap;
  end;

implementation

{ TCaptchaVerification }

constructor TCaptchaVerification.Create(aOwner: TComponent; aCharCase: TCharCases = [Upper, Number]);

begin
  inherited Create(aOwner);
  FCharCase:= aCharCase;
  Randomize;
  RefreshBitmap;
end;

destructor TCaptchaVerification.Destroy;
begin
  FCaptchaBitmap.FreeImage;
  inherited
end;

procedure TCaptchaVerification.DrawLetter(ch: Char; angle, nextPos: Integer);
var
  logfont: TLogFont;
  font: THandle;
begin
  Try
    logfont.lfheight := 40;
    logfont.lfwidth := 20;
    logfont.lfweight := 900;

    logfont.lfEscapement := angle;
    logfont.lfcharset := 1;
    logfont.lfoutprecision := OUT_TT_ONLY_PRECIS;
    logfont.lfquality := DEFAULT_QUALITY;
    logfont.lfpitchandfamily := FF_MODERN;
    logfont.lfUnderline := 0;
    logfont.lfStrikeOut := 0;

    font:= CreateFontIndirect(logfont);
    SelectObject(FCaptchaBitmap.Canvas.Handle, font);

    SetTextColor(FCaptchaBitmap.Canvas.Handle, rgb(0, 180, 0));
    SetBKmode(FCaptchaBitmap.Canvas.Handle, transparent);

    SetTextColor(FCaptchaBitmap.Canvas.Handle, Random(MAXWORD));
    FCaptchaBitmap.Canvas.TextOut(nextPos, FCaptchaBitmap.Height div 3, ch);
  Finally
    DeleteObject(font);
  End;
end;

procedure TCaptchaVerification.DrawLines(aLineCount: Integer);
var
  i : Integer;
begin
  for i := 0 to aLineCount do
  begin
    FCaptchaBitmap.Canvas.Pen.Color := Random(MAXWORD);
    FCaptchaBitmap.Canvas.MoveTo(Random(FCaptchaBitmap.Width), Random(FCaptchaBitmap.Height));
    FCaptchaBitmap.Canvas.LineTo(Random(FCaptchaBitmap.Width), Random(FCaptchaBitmap.Height));
  end;
end;

function TCaptchaVerification.GenerateCaptchaString: string;
var
  validChar : string;
  i : Integer;
const
  NoOfChars = 10;
begin
  validChar:= '';
  if TCharCase.Number in FCharCase then
    validChar := validChar + '123456789';

  if TCharCase.Lower in FCharCase then
    validChar := validChar + 'abcdefghijklmnopqrstuvwxyz';

  if TCharCase.Upper in FCharCase then
    validChar := validChar + 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  SetLength(Result, NoOfChars);

  for i := 1 to NoOfChars do
    Result[i] := validChar[Random(Length(validChar)) + 1];
end;

procedure TCaptchaVerification.RefreshBitmap;
var
  i: Integer;
begin
  FreeAndNil(FCaptchaBitmap);
  FCaptchaString:= GenerateCaptchaString;
  FCaptchaBitmap:= TBitmap.Create();
  FCaptchaBitmap.Height:= 75;
  FCaptchaBitmap.Width:= 300;
  FCaptchaBitmap.Canvas.Brush.Color := clWhite;
  FCaptchaBitmap.PixelFormat := pf24bit;
  for i := 1 to Length(FCaptchaString) do
    DrawLetter(FCaptchaString[i], Random(600) + 1, 25 * i - 15);
  DrawLines;
end;

function TCaptchaVerification.Validate(const aValue: string; aCaseSensetive: boolean = True): boolean;
begin
  if aCaseSensetive then
    Result := aValue = FCaptchaString
  else
    Result := SameText(aValue, FCaptchaString);
end;

end.
