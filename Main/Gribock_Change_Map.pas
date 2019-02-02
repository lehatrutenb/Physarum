uses GraphABC, Utils;

var size_x: array [1..3] of integer = (601, 767, 837);
var size_y: array [1..3] of integer = (498, 669, 682);
var pictures: array [1..3] of string = ('no.png', 'Big.png', 'Lab.png');
var pic: Picture;

var Map: array [1..721] of array [1..1024] of integer;
var SecondArr: array [1..721] of array [1..1024] of integer;
var StartPoint: array [1..2] of integer;
var y, x, rand, rezim, Cheat, CheatRezim, mx, my, radious, Rb, i, ind: integer;
var Boom: boolean;


{==}procedure Clear();
begin
  var x, y: integer;
  
  for y:=1 to size_y[ind] do
  begin
    for x:=1 to size_x[ind] do
    begin
      Map[y, x]:= 0;
      SecondArr[y, x]:= 0;
    end;
  end;
end;

{==}procedure MouseDown(mousex, mousey, mb: integer);
begin
  if mb <> 1 then
  begin
    mx:= mousex;
    my:= mousey;
  end
  else
  begin
    StartPoint[2]:=mousex; //round(size_x[ind]/2);//X
    StartPoint[1]:=mousey; //round(size_x[ind]/2);//Y
    SecondArr[StartPoint[1], StartPoint[2]]:=1; //Ставим 1 для процеса
      {Если стаит 1 значит эта клетка будет разростаться}
      {Если цифры больше то значит клетка там уже какое-то время}
  end;
end;


procedure Gribock();
begin
  var i, g: integer;
  pic := Picture.Create(pictures[ind]);
  pic.Load(pictures[ind]);
  pic.Draw(0, 0);
  for i := 1 to size_x[ind] do
  begin
    for g := 1 to size_y[ind] do
    begin
      //SetPixel(i, g, clRed);
      if(getpixel(i, g) <> ARGB(255, 0, 0, 0)) then
        SecondArr[g, i] := -1;
    end;
  end;
end;



{==}procedure KeyDown(key: integer);
begin
  if key = VK_Left then
  begin
    if ind = 1 then
    begin
      ind:= 3;
    end
    else
    begin
      ind-= 1;
    end;
    SetWindowWidth(size_x[ind]);
    SetWindowHeight(size_y[ind]);
    CenterWindow;
    Clear();
    Gribock();
  end;
  
  if key = VK_Right then
  begin
    if ind = 3 then
    begin
      ind:= 1;
    end
    else
    begin
      ind+= 1;
    end;
    SetWindowWidth(size_x[ind]);
    SetWindowHeight(size_y[ind]);
    CenterWindow;
    Clear();
    Gribock();
  end;
  
  if key = VK_Escape then
  begin
    CloseWindow;
  end;
  
  if key = VK_Enter then
  begin
    Boom:= True;
  end;

  if key = VK_Up then
  begin
    if Map[my-radious, mx] = 0 then
    begin
      my-=1;
    end;
  end;
  
  if key = VK_Down then
  begin
    if Map[my+radious, mx] = 0 then
    begin
      my+=1;
    end;
  end;
  
  if key = VK_Left then
  begin
    if Map[my, mx-radious] = 0 then
    begin
      mx-=1;
    end;
  end;
  
  if key = VK_Right then
  begin
    if Map[my, mx+radious] = 0 then
    begin
      mx+=1;
    end;
  end;
  
  
  if key = VK_Space then
  begin
    if rezim=0 then
    begin
      rand:=0;
      rezim:=1;
    end
    else
    begin
      rand:=2;
      rezim:=0;
    end;
  end;
end;


procedure Points();
begin
  var x, y: integer;
  for y:=1 to size_y[ind] do
  begin
    for x:=1 to size_x[ind] do
    begin
      if Map[y, x]=1 then//Нашли единицы
      begin
        if random(0, rand) = 0 then
        begin
          {=}SecondArr[y, x]:=2;
          
          if SecondArr[y+1, x]=0 then SecondArr[y+1, x]:=1;
          if SecondArr[y-1, x]=0 then SecondArr[y-1, x]:=1;
          if SecondArr[y, x+1]=0 then SecondArr[y, x+1]:=1;
          if SecondArr[y, x-1]=0 then SecondArr[y, x-1]:=1;
        end;
      end;
    end;
  end;
  for y:=1 to size_y[ind] do
  begin
    for x:=1 to size_x[ind] do
    begin
      Map[y, x]:=SecondArr[y, x];
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////
begin
  ind:= 1;
  
  SetWindowWidth(size_x[ind]);
  SetWindowHeight(size_y[ind]);
  CenterWindow;
  
  rand:= 2;
  Rb:= 8;
  radious:=4;
  mx:= 2;
  my:= 2;
  OnMouseDown := MouseDown;
  OnKeyDown := KeyDown;
  //StartPoint[2]:=7;//round(size_x[ind]/2);//X
  //StartPoint[1]:=490;//round(size_x[ind]/2);//Y
  Gribock();
  
  
  While True do
  begin
    Points();
    if Boom then
    begin
      SetPenColor(clBlack);
      for i:=1 to Rb do
      begin
        SetBrushColor(clBlack);
        FillRect(mx-i, my-i, mx+i, my+i);
        SetBrushColor(clRed);
        Circle(mx, my, radious-1);
        sleep(20);
      end;
      
      for x:=-Rb to Rb do
      begin
        for y:=-Rb to Rb do
        begin
          if (my+y>0) and (my+y<size_y[ind]) and (mx+x>0) and (mx+x<size_x[ind]) then
            SecondArr[my+y, mx+x]:= 0;
          //SetPixel(mx+x, my+y, clRed);
        end;
      end;
      
      Boom:= False;
    end;
    SetBrushColor(clRed);
    Circle(mx, my, radious-1);
    for y:=1 to size_y[ind] do
    begin
      for x:=1 to size_x[ind] do
      begin
        case Map[y, x] of
          1: SetPixel(x, y, clYellow);
          //2: SetPixel(x, y, clRed);
          3: SetPixel(x, y, clOrange);
        end
      end;
    end;
    SetBrushColor(clBlack);
    //Circle(mx, my, 4);
  end;
end.