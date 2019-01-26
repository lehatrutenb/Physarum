program hello;
uses GraphABc;
var Good: array [0..1000] of array [0..1000] of real;
var Ph: array [0..10000] of array [0..10000] of integer;
var GrofPhX: array [0..1000000] of integer;
var GrofPhY: array [0..1000000] of integer;
var PhX: array [0..1000000] of integer;
var PhY: array [0..1000000] of integer;

var SIZEX, SIZEY: integer;
var kolgr: integer;
var kolg, kolb, prc: integer;
var kolall: integer;
var trm: boolean;

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
        Good[y][x] := 1;
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
                if(Ph[iy][ix] <> 1)then
                begin
                    SetPixel(ix, iy, RGB(p, p2, 0));
                end;
            end;
        end;
        trm := False;
    end;
end;

procedure DrawPh(x, y, pergr: integer);     //рисование Ph
begin
    var sumofhod: integer; //проверка на доп ходы
    if((y + 1 < SIZEY) and (Ph[y + 1][x] <> 1))then
    begin
        sumofhod += 1;
    end;
    if((y - 1 > 0) and (Ph[y - 1][x] <> 1))then
    begin
        sumofhod += 1;
    end;
    if((x + 1 < SIZEX) and (Ph[y][x + 1] <> 1))then
    begin
        sumofhod += 1;
    end;
    if((x - 1 > 0) and (Ph[y][x - 1] <> 1))then
    begin
        sumofhod += 1;
    end;
    if(sumofhod = 0)then
    begin
        if(pergr <> kolgr)then
        begin
            var i2: integer;
            for i2:= pergr to kolgr - 1 do
            begin
                GrofPhY[i2] := GrofPhY[i2 + 1];
                GrofPhX[i2] := GrofPhX[i2 + 1];
            end;
        end;
        kolgr -= 1;
    end;
    if((y + 1 < SIZEY) and (y - 1 > 0) and (x + 1 < SIZEX) and (x - 1 > 0) and (Ph[y + 1][x] <> 1) and (Good[y + 1][x] < Good[y - 1][x]) and (Good[y + 1][x] < Good[y][x + 1]) and (Good[y + 1][x] < Good[y][x - 1]))then
    begin
        SetPixel(x, y + 1, clYellow);
        PhY[kolall + 1] := y + 1;
        PhX[kolall + 1] := x;
        kolall += 1;
        if(sumofhod >= 2)then
        begin
            GrofPhY[kolgr + 1] := y + 1;
            GrofPhX[kolgr + 1] := x;
            kolgr += 1;
        end
        else
        begin
            GrofPhY[pergr] := y + 1;
        end;
        Ph[y + 1][x] := 1;
    end
    else if((y + 1 < SIZEY) and (y - 1 > 0) and (x + 1 < SIZEX) and (x - 1 > 0) and (Ph[y - 1][x] <> 1) and (Good[y - 1][x] < Good[y + 1][x]) and (Good[y - 1][x] < Good[y][x + 1]) and (Good[y - 1][x] < Good[y][x - 1]))then
    begin
        SetPixel(x, y - 1, clYellow);
        PhY[kolall + 1] := y - 1;
        PhX[kolall + 1] := x;
        kolall += 1;
        if(sumofhod >= 2)then
        begin
            GrofPhY[kolgr + 1] := y - 1;
            GrofPhX[kolgr + 1] := x;
            kolgr += 1;
        end
        else
        begin
            GrofPhY[pergr] := y - 1;
        end;
        Ph[y - 1][x] := 1;
    end
    else if((y + 1 < SIZEY) and (y - 1 > 0) and (x + 1 < SIZEX) and (x - 1 > 0) and (Ph[y][x + 1] <> 1) and (Good[y][x + 1] < Good[y - 1][x]) and (Good[y][x + 1] < Good[y][x - 1]) and (Good[y][x + 1] < Good[y + 1][x]))then
    begin
        SetPixel(x + 1, y, clYellow);
        PhY[kolall + 1] := y;
        PhX[kolall + 1] := x + 1;
        kolall += 1;
        if(sumofhod >= 2)then
        begin
            GrofPhY[kolgr + 1] := y;
            GrofPhX[kolgr + 1] := x + 1;
            kolgr += 1;
        end
        else
        begin
            GrofPhX[pergr] := x + 1;
        end;
        Ph[y][x + 1] := 1;
    end
    else if((y + 1 < SIZEY) and (y - 1 > 0) and (x + 1 < SIZEX) and (x - 1 > 0) and (Ph[y][x - 1] <> 1) and (Good[y][x - 1] < Good[y - 1][x]) and (Good[y][x - 1] < Good[y][x + 1]) and (Good[y][x - 1] < Good[y + 1][x]))then
    begin
        SetPixel(x - 1, y, clYellow);
        PhY[kolall + 1] := y;
        PhX[kolall + 1] := x - 1;
        kolall += 1;
        if(sumofhod >= 2)then
        begin
            GrofPhY[kolgr + 1] := y;
            GrofPhX[kolgr + 1] := x - 1;
            kolgr += 1;
        end
        else
        begin
            GrofPhX[pergr] := x - 1;
        end;
        Ph[y][x - 1] := 1;
    end
    else
    begin
        var per, per2: integer;
        per := random(1000);
        if((x + 1 < SIZEX) and (per >= 750) and (Ph[y][x + 1] <> 1))then
        begin
            SetPixel(x + 1, y, clYellow);
            PhY[kolall + 1] := y;
            PhX[kolall + 1] := x + 1;
            kolall += 1;
            if(sumofhod >= 2)then
            begin
                GrofPhY[kolgr + 1] := y;
                GrofPhX[kolgr + 1] := x + 1;
                kolgr += 1;
            end
            else
            begin
                GrofPhX[pergr] := x + 1;
            end;
            Ph[y][x + 1] := 1;
        end
        else if((x - 1 > 0) and (per >= 500) and (Ph[y][x - 1] <> 1))then
        begin
            SetPixel(x - 1, y, clYellow);
            PhY[kolall + 1] := y;
            PhX[kolall + 1] := x - 1;
            kolall += 1;
            if(sumofhod >= 2)then
            begin
                GrofPhY[kolgr + 1] := y;
                GrofPhX[kolgr + 1] := x - 1;
                kolgr += 1;
            end
            else
            begin
                GrofPhX[pergr] := x - 1;
            end;
            Ph[y][x - 1] := 1;
        end
        else if((y + 1 < SIZEY) and (per >= 250) and (Ph[y + 1][x] <> 1))then
        begin
            SetPixel(x, y + 1, clYellow);
            PhY[kolall + 1] := y + 1;
            PhX[kolall + 1] := x;
            kolall += 1;
            if(sumofhod >= 2)then
            begin
                GrofPhY[kolgr + 1] := y + 1;
                GrofPhX[kolgr + 1] := x;
                kolgr += 1;
            end
            else
            begin
                GrofPhY[pergr] := y + 1;
            end;
            Ph[y + 1][x] := 1;
        end
        else if((y - 1 > 0) and (Ph[y - 1][x] <> 1))then
        begin
            SetPixel(x, y - 1, clYellow);
            PhY[kolall + 1] := y - 1;
            PhX[kolall + 1] := x;
            kolall += 1;
            if(sumofhod >= 2)then
            begin
                GrofPhY[kolgr + 1] := y - 1;
                GrofPhX[kolgr + 1] := x;
                kolgr += 1;
            end
            else
            begin
                GrofPhY[pergr] := y - 1;
            end;
            Ph[y - 1][x] := 1;
        end
        else
        begin
            var perr: integer;
            perr := random(3000);
            if((perr >= 2000) and (x - 1 > 0) and (Ph[y][x - 1] <> 1))then
            begin
                SetPixel(x - 1, y, clYellow);
                PhY[kolall + 1] := y;
                PhX[kolall + 1] := x - 1;
                kolall += 1;
                if(sumofhod >= 2)then
                begin
                    GrofPhY[kolgr + 1] := y;
                    GrofPhX[kolgr + 1] := x - 1;
                    kolgr += 1;
                end
                else
                begin
                    GrofPhX[pergr] := x - 1;
                end;
                Ph[y][x - 1] := 1;
            end
            else
            begin
                perr := random(5000);
                if((perr >= 2500) and (y - 1 > 0) and (Ph[y - 1][x] <> 1))then
                begin
                    SetPixel(x, y - 1, clYellow);
                    PhY[kolall + 1] := y - 1;
                    PhX[kolall + 1] := x;
                    kolall += 1;
                    if(sumofhod >= 2)then
                    begin
                        GrofPhY[kolgr + 1] := y - 1;
                        GrofPhX[kolgr + 1] := x;
                        kolgr += 1;
                    end
                    else
                    begin
                        GrofPhY[pergr] := y - 1;
                    end;
                    Ph[y - 1][x] := 1;
                end
                else if((y + 1 < SIZEY) and (Ph[y + 1][x] <> 1))then
                begin
                    SetPixel(x, y + 1, clYellow);
                    PhY[kolall + 1] := y + 1;
                    PhX[kolall + 1] := x;
                    kolall += 1;
                    if(sumofhod >= 2)then
                    begin
                        GrofPhY[kolgr + 1] := y + 1;
                        GrofPhX[kolgr + 1] := x;
                        kolgr += 1;
                    end
                    else
                    begin
                        GrofPhX[pergr] := y + 1;
                    end;
                    Ph[y + 1][x] := 1;
                end;
            end;
        end;
    end;
end;

procedure ProvOfGr();
begin
    var i, j:integer;
    for i:= 1 to SIZEX do
    begin
        for j:= 1 to SIZEY do
        begin
            if(Ph[j][i] = 1)then
            begin
                var sumofhod: integer;
                if(Ph[j + 1][i] <> 1)then
                begin
                    sumofhod += 1;
                end;
                if(Ph[j - 1][i] <> 1)then
                begin
                    sumofhod += 1;
                end;
                if(Ph[j][i + 1] <> 1)then
                begin
                    sumofhod += 1;
                end;
                if(Ph[j][i - 1] <> 1)then
                begin
                    sumofhod += 1;
                end;
                if(sumofhod <> 0)then
                begin
                    kolgr += 1;
                    GrofPhY[kolgr] := j;
                    GrofPhX[kolgr] := i;
                end;
            end;
        end;
    end;
end;

procedure Delete(i, j, perk: integer);
begin
    var sumofhod: integer;
    if(Ph[j + 1][i] = 1)then
    begin
        sumofhod += 1;
    end;
    if(Ph[j - 1][i] = 1)then
    begin
        sumofhod += 1;
    end;
    if(Ph[j][i + 1] = 1)then
    begin
        sumofhod += 1;
    end;
    if(Ph[j][i - 1] = 1)then
    begin
        sumofhod += 1;
    end;
    if(sumofhod <> 2)then
    begin
        SetPixel(i, j, clWhite);
        Ph[j][i] := 0;
        if(perk <> kolall)then
        begin
            var i2: integer;
            for i2:= perk to kolall - 1 do
            begin
                PhY[i2] := PhY[i2 + 1];
                PhX[i2] := PhX[i2 + 1];
            end;
        end;
        kolall -= 1;
    end;
end;

function ProvOfKol(x, y, pergr: integer) :boolean;
begin
    if((x > 1) and (x < SIZEX) and (y > 1) and (y < SIZEY))then
    begin
        var sumgr : integer;
        if(Ph[y + 1][x] = 1)then
        begin
            sumgr += 1;
        end;
        if(Ph[y - 1][x] = 1)then
        begin
            sumgr += 1;
        end;
        if(Ph[y][x + 1] = 1)then
        begin
            sumgr += 1;
        end;
        if(Ph[y][x - 1] = 1)then
        begin
            sumgr += 1;
        end;
        if((sumgr = 1) or (sumgr = 2))then
        begin
            Result := True;
        end
        else
        begin
            if(pergr <> kolgr)then
            begin
                var i2: integer;
                for i2:= pergr to kolgr - 1 do
                begin
                    GrofPhY[i2] := GrofPhY[i2 + 1];
                    GrofPhX[i2] := GrofPhX[i2 + 1];
                end;
            end;
            kolgr -= 1;
            Result := False;
        end;
    end;
end;

begin
    {SIZEX := 640;
    SIZEY := 480;}
    SIZEX := 1000;
    SIZEY := 1000;
    
    kolgr := 2;
    kolall := 2;
    GrofPhX[1] := 300; //точки начала роста Ph
    GrofPhY[1] := 200;
    GrofPhX[1] := 301;
    GrofPhY[1] := 200;
    
    Ph[200][300] := 1;
    Ph[200][301] := 1;
    SetPixel(300, 200, clYellow);
    SetPixel(301, 200, clYellow);
    
    prc := 0;
    read(kolg);
    read(kolb);
    var tr: boolean;
    tr := True;
    trm := True;
    {while(trm)do
    begin
        OnMouseDown := MouseDown;
    end;}
    var z: integer;
    z := 0;
    while(tr = True)do
    begin
        z += 1;
        OnMouseDown := MouseDown;
        var i : integer;
        for i := 1 to kolgr do
        begin
            if((Good[GrofPhY[i]][GrofPhX[i]] < 0.5) and (ProvOfKol(GrofPhX[i], GrofPhY[i], i) = True))then
            begin
                DrawPh(GrofPhX[i], GrofPhY[i], i);
                {if(Good[GrofPhY[i]][GrofPhX[i]] <> 0)then
                begin
                    sleep(1 - -1 * round(Good[GrofPhY[i]][GrofPhX[i]]));
                end;
                DrawPh(GrofPhX[i], GrofPhY[i], i);
            {if(random(1, 1000 + 1 - Good[GrofPhY[i]][GrofPhX[i]]))then
            begin
                DrawPh(GrofPhX[i], GrofPhY[i], i);
            end;}
            end;
        end;
        {if(z mod 500 = 0)then //убирает маленькие дыры внутри Ph
        begin
            ProvOfGr();
        end;}
        {if(z mod 1000 = 0)then   //удаление
        begin
            var z2: integer;
            for z2:= 1 to 500 do
            begin
                var j: integer;
                i := random(1, kolall);
                if(Ph[PhY[i]][PhX[i]] = 1)then
                begin
                    Delete(PhX[i], PhY[i], i);
                end;
            end;
        end;}
    end;
end.