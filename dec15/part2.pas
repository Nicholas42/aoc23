program HelloWorld(output);

uses Sysutils, Classes;

type TLens = record
    marker: string;
    focalLength: integer;
end;

type TFile = file of char;
type THashMap = array[0..255] of array of TLens;

function ReadNumber(var inFile: TFile): integer;
var
    digit: integer;
    c: char;
begin
    digit := 0;
    ReadNumber := 0;
    while((digit >= 0) AND (digit <= 9)) do begin
        ReadNumber := ReadNumber * 10 + digit;
        read(inFile, c);
        digit := ord(c) - ord('0');
    end;
end;

function Hash(toHash: string): integer;
var
    c: char;
begin
    Hash := 0;
    for c in toHash do begin
        Hash := ((Hash + ord(c)) * 17) mod 256;
    end;
end;

function ReadMarker(var inFile: TFile): string;
var
    letter: char;
begin
    ReadMarker := '';
    read(inFile, letter);
    while((letter >= 'a') AND (letter <= 'z')) do begin
        ReadMarker += letter;
        read(inFile, letter);
    end;
    seek(inFile, filepos(inFile) - 1);
end;

function FindLens(map: THashMap; hashed: integer; marker: string): integer;
var
    lens: TLens;
begin
    FindLens := 0;
    for lens in map[hashed] do begin
        if(lens.marker = marker) then break;
        FindLens += 1
    end
end;

var
    inFile: TFile;
    sum: int64;
    curLens: TLens;
    hashMap: THashMap;
    marker: string;

    op: char;
    hashed, index, focalLength, i, j: integer;
begin
    for i := low(hashMap) to high(hashMap) do begin
        SetLength(hashMap[i], 0);
    end;
    curLens.marker := '';
    curLens.focalLength := 0;
    sum := 0;
    Assign(inFile, 'input.txt');
    reset(inFile);

    while(not eof(inFile)) do begin
        marker := ReadMarker(inFile);
        Read(inFile, op);
        hashed := Hash(marker);
        index := FindLens(hashMap, hashed, marker);
        if (op = '=') then begin
            focalLength := ReadNumber(inFile);
            if(index > high(hashMap[hashed])) then begin
                curLens.marker := marker;
                curLens.focalLength := focalLength;
                Insert(curLens, hashMap[hashed], index);
            end else begin
                hashMap[hashed][index].marker := marker;
                hashMap[hashed][index].focalLength := focalLength;
            end
        end else begin
            Read(inFile, op); { Gobble , }
            if(index <= high(hashMap[hashed])) then
                Delete(hashMap[hashed], index, 1)
        end;
    end;

    sum := 0;
    for i := low(hashMap) to high(hashMap) do begin
        for j := low(hashMap[i]) to high(hashMap[i]) do begin
            sum += (i+1) * (j+1) * hashMap[i][j].focalLength;
        end
    end;

    WriteLn(sum)
end.
