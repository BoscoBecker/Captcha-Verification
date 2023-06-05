unit MainU;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ExtCtrls, CaptchaVerification,
  StdCtrls, Mask, pngimage;

type
  TForm1 = class(TForm)
    Image1: TImage;
    LabeledEdit1: TLabeledEdit;
    Button1: TButton;
    Image2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    CaptchaVerification: TCaptchaVerification;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  case CaptchaVerification.Validate(LabeledEdit1.Text, False) of
    True:
    begin
      if FileExists('..\..\done.png') then
      begin
        Image2.Picture.LoadFromFile('..\..\done.png');
        Image2.repaint;
        Sleep(2000);
      end;
    end;
    False:
    begin
      if FileExists('..\..\error.png') then
        Image2.Picture.LoadFromFile('..\..\error.png');
      Image2.repaint;
      Sleep(2000);
      CaptchaVerification.RefreshBitmap;
      Image1.Picture.Assign(CaptchaVerification.Image);
    end;
  end;
  Image2.Picture:= nil;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  CaptchaVerification := TCaptchaVerification.Create(Self);
  Image1.Picture.Assign(CaptchaVerification.Image);
end;

end.
