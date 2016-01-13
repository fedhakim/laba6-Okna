unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ClipBrd, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ListBox1: TListBox;
    Button5: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);

    procedure Button5Click(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
    if findwindow(nil,'�������')<>0
      then begin
           showmessage('���� ������������');
           setwindowpos(findwindow(nil,'�������'),HWND_BOTTOM,1,1,1000,800,HWND_TOP);//HWND_TOP �������� ���� ������� ������������������ Z
           end
      else showmessage('���� �����������');

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if findwindow(nil,'�������')<>0
    then
      begin
      setwindowtext(findwindow(nil,'�������'),'����');
     if isIconic(findwindow(nil,'����'))
        then OpenIcon(findwindow(nil,'����'))
        else CloseWindow(findwindow(nil,'����'));
      end
      else showmessage('������������� ���� �����������');
end;



function EnumProc (Wd: Hwnd; Param: Longint): Boolean;stdcall;
Var
 Nm:Array[0..255] of Char; //����� ��� �����
 Cs: Array[0..255] of Char; //����� ��� ������
 begin
 getwindowtext(Wd,Nm,255);//��������� ����� ���������
 getclassname(Wd,Cs,255); //��������� �������� ������ ����
 //��������� ���� ���������� �� ������
 if Wd <> Form1.Handle then
 Form1.ListBox1.Items.Add(string(Nm)+'/'+String(cs)); //��������� �������� ���� � ����� � ������
 EnumProc := TRUE; //���������� ������ ����
 end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ListBox1.Items.Clear;// ������� ������ ����� ������� ������
  EnumWindows (@EnumProc,0); //�������� ������� ������
end;

procedure TForm1.Button5Click(Sender: TObject);
 var hnd:thandle;
 canvas:tcanvas;
 dc:hdc;
 a,b:integer;
 WinDc:HDC;
 Arect:Trect;
 result:Tbitmap;
 begin
  hnd:=findwindow(nil,'�������'); //������� ����

  result:=tbitmap.create;
  GetWindowRect(hnd,Arect);//������� ������� ���� ����� ����������
  // ������ ���������
  with result, arect do
    begin
      a :=Arect.Right-Arect.Left;
      b := Arect.Bottom-Arect.Top;
      //If (Width=0) or (Height=0) then
   //begin
   //MessageDlg('������ ������� ����� ����� ����', mtWarning,[mbOk],0);//����� � ���� ��� �������
   // end;
    end;
  canvas:=tcanvas.Create;   //������� �����
  dc:=getdc(hnd);//�������� ���������� ������
  //showmessage(inttostr(dc));    //������ ���
  with canvas do
   begin
    handle:=dc; //������ � ������������ "������" ����� ��������
    rectangle(0,0,a,b); // ������ ������������� �� ������
    font.color:=$0000ff; //������ ������� ���� ������
    //����� ����� 
    textout(400,30,'Hello');
    textout(400,60,'World');

   free;
   end;
result.Free;
end;


end.



