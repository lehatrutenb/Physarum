uses GraphABC;

procedure MouseDown(mousex, mousey, mb: integer);
begin
end;
  
procedure KeyDown(key: integer);
begin
end;

begin
  OnMouseDown := MouseDown;
  OnKeyDown := KeyDown;
end.