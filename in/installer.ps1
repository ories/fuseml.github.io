#!/bin/bash
# This file has a bash section followed by a powershell section,
# as well as shared sections.
echo @'
' > /dev/null
#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
# Bash Start -----------------------------------------------------------
echo "Downloading FuseML"
arch='uname -m'
case $(arch) in
    x86_64)
        platform='amd64'
        ;;      
    arm64)
        platform = 'arm64'
        ;;
    *)
        echo 'Current platform not yet supported'
        ;;
esac
regex='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
base=https://github.com/fuseml/fuseml/releases/download && \
string=$base/latest/fuseml-$(uname -s)-$platform
if  $string != $regex 
then
 curl -L $base/latest/fuseml-$(uname -s)-$platform > /tmp/fuseml && chmod +x /tmp/fuseml && sudo mv /tmp/fuseml /usr/local/bin
 exit
else
 echo $base/download/v0.0.0/fuseml-$(uname -s)-$platform
 curl -L $base/v0.0.0/fuseml-$(uname -s)-$platform > /tmp/fuseml && chmod +x /tmp/fuseml && sudo mv /tmp/fuseml /usr/local/bin
 exit
fi

# Bash End -------------------------------------------------------------
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
echo > /dev/null <<"out-null" ###
'@ | out-null
#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
# Powershell Start -----------------------------------------------------

write-host "Downloading FuseML"
$repo="fuseml"
$file="fuseml-windows-amd64"
$releases = "https://api.github.com/repos/$repo/$repo/releases"
$tag = (Invoke-WebRequest $releases | ConvertFrom-Json)[0].tag_name

$download = "https://github.com/$repo/$repo/releases/download/$tag/$file"
Invoke-WebRequest $download -Out "fuseml.exe"
 Powershell End -------------------------------------------------------
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
out-null

echo "FuseML is ready to be use, enjoy!"