program HelloWorld(output);

uses Sysutils, Classes;

var
    InStream: TFileStream;
    hash, sum: int64;
    buf: string;
begin
    hash := 0;
    sum := 0;
    InStream := TFileStream.Create('input.txt', fmOpenRead);

    while(InStream.Read(buf, 1) > 0) do begin
        if((buf[0] = ',') OR (buf[0]=chr(10))) then begin
            sum += hash;
            hash := 0;
        end
        else begin
            hash := ((hash + ord(buf[0])) * 17) mod 256;
        end
    end;

    WriteLn(sum + hash)
end.
