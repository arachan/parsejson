::Make RDB
CHCP 65001
SET IDLC="%ProgramFiles%\LibreOffice\sdk\bin\idlc.exe"
SET REGMERGE="%ProgramFiles%\LibreOffice\program\regmerge.exe"
SET IDL="%ProgramFiles%\LibreOffice\sdk\idl"

IF EXIST %IDLC% (GOTO FILE_TRUE) ELSE GOTO FILE_FALSE

:FILE_TRUE
ECHO "File is Found"
:: Windows10 x64 LibreOffice x64
:: Windows10 x86 LibreOffice x86
GOTO BUILDRDB

:FILE_FALSE
ECHO "File is not Found"
:: Windows10 x64 LibreOffice x86
SET IDLC="%ProgramFiles(x86)%\LibreOffice\sdk\bin\idlc.exe"
SET REGMERGE="%ProgramFiles(x86)%\LibreOffice\program\regmerge.exe"
SET IDL="%ProgramFiles(x86)%\LibreOffice\sdk\idl"
GOTO BUILDRDB

:BUILDRDB

:: Make Xjsonparse.urd
%IDLC% -I %IDL% idl\Xjsonparse.idl
:: Make jsonparse.rdb
%REGMERGE% rdb\jsonparse.rdb UCR idl\Xjsonparse.urd

::serch 7zip
:: Scoop 7zip
SET Z=%USERPROFILE%\scoop\shims\7z.exe
IF EXIST %Z% (GOTO SCOOP)
:: Win x64 7zip x64
:: Win x86 7xip x86
SET Z="%ProgramFiles%\7-Zip\7z.exe"
IF EXIST %Z% (GOTO 7Z)
:: Win x64 7zip x86
SET Z="%ProgramFiles(x86)%\7-Zip\7z.exe"
IF EXIST %Z% (GOTO 7Z)

::Compress to zip
:SCOOP
ECHO "scoop installed 7zip."
7z a -tzip jsonparse.zip reg.uno.py
7z u jsonparse.zip META-INF
7z u jsonparse.zip pythonpath
7z u jsonparse.zip rdb
7z u jsonparse.zip description.xml
7z u jsonparse.zip LICENSE
7z u jsonparse.zip mkoxt.sh
7z u jsonparse.zip mkoxt.sh.conf
7z u jsonparse.zip README.md
7z u jsonparse.zip makeoxt.bat
GOTO ZIP_END

:7Z
ECHO "Insteller installed 7zip"
%Z% a -tzip jsonparse.zip reg.uno.py
%Z% u jsonparse.zip META-INF
%Z% u jsonparse.zip pythonpath
%Z% u jsonparse.zip rdb
%Z% u jsonparse.zip description.xml
%Z% u jsonparse.zip LICENSE
%Z% u jsonparse.zip mkoxt.sh
%Z% u jsonparse.zip mkoxt.sh.conf
%Z% u jsonparse.zip README.md
%Z% u jsonparse.zip makeoxt.bat
GOTO ZIP_END

:ZIP_END

::rename to oxt
move jsonparse.zip jsonparse.oxt
