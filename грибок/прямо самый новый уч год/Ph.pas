program hello;
uses GraphABc;
var Good: array [1..1000] of array [1..1000] of real;
var GrofPhX array [1..1000000] of integer;
var GrofPhY: array [1..1000000] of integer;

var SIZEX, SIZEY: integer;
var kolgr: integer;
var kolg, kolb, prc: integer;

procedure MouseDown(x, y, mb: integer);
begin
    prc += 1;
    var ix, iy: integer;
    for ix:= 1 to SIZEX do
    begin
        for iy:= 1 to SIZEY do
        begin
            if(prc >= kolg + kolb)then
            begin
                Good[iy][ix] += 200 / ((ix - x) * (ix - x) + (iy - y) * (iy - y) + 200);
            end
            else
            begin
                Good[iy][ix] += -200 / ((ix - x) * (ix - x)  + (iy - y) * (iy - y) + 200);
            end;
        end;
    end;
    if(kolg < prc)then
    begin
        SetBrushColor(ARGB(200, 250, 250, 0));
        Circle(x, y, 10);
    end
    else
    begin
        SetPixel(x, y, clBlack);
        Good[y][x] := -1;
        SetPixel(x + 1, y, clBlack);
        SetPixel(x, y + 1, clBlack);
        SetPixel(x + 1, y + 1, clBlack);
    end;
    if(prc >= kolb + kolg) then
    begin
        for ix:= 1 to SIZEX do
        begin
            for iy:= 1 to SIZEY do
            begin
                var p, p2: integer;
                p := 127 + round(Good[iy][ix] * 127);
                p2 := 128 - round(Good[iy][ix] * 127);
                if(127 + Good[iy][ix] * 127 < 0)then
                begin
                    p := 0;
                end;
                if(127 + Good[iy][ix] * 127 > 255)then
                begin
                    p := 255;
                end;
                if(128 - Good[iy][ix] * 127 > 255)then
                begin
                    p2 := 255;
                end;
                if(128 - Good[iy][ix] * 127 < 0)then
                begin
                    p2 := 0;
                end;
                //if((SecondArr[iy][ix] <> -1)and(getpixel(ix, iy) <> ARGB(255, 255, 255, 0)))then
                //begin
                SetPixel(ix, iy, RGB(p, p2, 0));
                //end;
            end;
        end;
    end;
end;

procedure DrawPh(x, y, pergr: integer);
begin
    if((Good[y + 1][x] > Good[y - 1][x]) and (Good[y + 1][x] > Good[y][x + 1]) and (Good[y + 1][x] > Good[y][x - 1]))then
    begin
        SetPixel(x, y + 1, clYellow);
        if(
    end
    else if((Good[y - 1][x] > Good[y + 1][x]) and (Good[y - 1][x] > Good[y][x + 1]) and (Good[y - 1][x] > Good[y][x - 1]))then
    begin
        SetPixel(x, y - 1, clYellow);
    end
    else if((Good[y][x + 1] > Good[y - 1][x]) and (Good[y][x + 1] > Good[y][x - 1]) and (Good[y][x + 1] > Good[y + 1][x]))then
    begin
        SetPixel(x + 1, y, clYellow);
    end
    else if((Good[y][x - 1] > Good[y - 1][x]) and (Good[y][x - 1] > Good[y][x + 1]) and (Good[y][x - 1] > Good[y + 1][x]))then
    begin
        SetPixel(x - 1, y, clYellow);
    end
    else
    begin
        var per: integer;
        per := random(1000);
        if(per >= 750)then
        begin
            SetPixel(x + 1, y, clYellow);
        end
        else if(per >= 500)then
        begin
            SetPixel(x - 1, y, clYellow);
        end
        else if(per >= 250)then
        begin
            SetPixel(x, y + 1, clYellow);
        end
        else
        begin
            SetPixel(y, y - 1, clYellow);
        end;
    end;
end;

begin
    SIZEX := 640;
    SIZEY := 480;
    kolgr := 1;
    GrofPhX[1] := 300;
    GrofPhY[1] := 200;
    prc := 0;
    read(kolg);
    read(kolb);
    var tr: boolean;
    tr := True;
    while(tr = True)do
    begin
        OnMouseDown := MouseDown;
        var i : integer;
        for i := 1 to kolgr do
        begin
            DrawPh(GrofPhX[i], GrofPhY[i], i);
        end;
    end;
end.
