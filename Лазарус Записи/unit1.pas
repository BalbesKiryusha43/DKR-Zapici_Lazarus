unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  TStudent = record
    FirstName: string;
    LastName: string;
  end;

  PNode = ^TNode;
  TNode = record
    Student: TStudent;
    Next: PNode;
  end;

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    FirstNameEdit: TEdit;
    LastNameEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ListBox: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
   private
    { private declarations }
    List: PNode;
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  NewNode: PNode;
begin

  if (FirstNameEdit.Text = '') or (LastNameEdit.Text = '') then
  begin
    ShowMessage('Пожалуйста, введите как имя, так и фамилию.');
    Exit;
  end;

  New(NewNode);
  NewNode^.Student.FirstName := FirstNameEdit.Text;
  NewNode^.Student.LastName := LastNameEdit.Text;
  NewNode^.Next := List;
  List := NewNode;

  FirstNameEdit.Clear;
  LastNameEdit.Clear;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
Prev: PNode;
Curr: PNode;
index: integer;
begin
index:=0;
if ListBox.ItemIndex <> -1 then
begin
if ListBox.ItemIndex = 0 then // если удаляем первый элемент списка
begin
Curr := List;
List := Curr^.Next;
Dispose(Curr);
end
else
begin
Curr := List^.Next;
Prev := List;
while index <> ListBox.ItemIndex-1 do // находим предыдущий элемент
begin
index:=index+1;
Prev := Curr;
Curr := Curr^.Next;
end;
Prev^.Next := Curr^.Next; // перепривязываем указатель
Dispose(Curr);
end;
ListBox.Items.Delete(ListBox.ItemIndex);
end
else
begin
ShowMessage('Выберите элемент для удаления.');
end;
end;

procedure TForm1.Button3Click(Sender: TObject);
  var
    Curr: PNode;
  begin
    ListBox.Clear;
    Curr := List;
    while Curr <> nil do
    begin
      ListBox.Items.Add(Curr^.Student.FirstName + ' ' + Curr^.Student.LastName);
      Curr := Curr^.Next;
    end;
  end;

end.

