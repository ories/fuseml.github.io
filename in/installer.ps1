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
base=https://github.com/fuseml/fuseml/releases/download
LATEST=$base/latest/fuseml-$(uname -s)-$platform
TMPDIR=$(mktemp -d)
textreset=$(tput sgr0) # reset the foreground colour
red=$(tput setaf 1)
yellow=$(tput setaf 2) 
# check if there is latest release
if wget -q --method HEAD "$LATEST"; then
  echo "Downloading latest release..."
  curl -L "$LATEST" -o "$TMPDIR/fuseml"
else
  echo "No release marked as latest, downloading last pre-release version..."
  curl -L "$base/v0.0.2/fuseml-installer-$(uname -s)-$platform.tar.gz" -O \
  && tar -xvzf "fuseml-installer-$(uname -s)-$platform.tar.gz" \
  && chmod +x fuseml-installer \
  && sudo mv fuseml-installer /usr/local/bin/ \
  && rm "fuseml-installer-$(uname -s)-$platform.tar.gz"
fi

# chmod +x "$TMPDIR/fuseml"
# sudo mv "$TMPDIR/fuseml" /usr/local/bin
# rm -rf "$TMPDIR"

# Bash End -------------------------------------------------------------
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
echo > /dev/null <<"out-null" ###
'@ | out-null
#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
# Powershell Start -----------------------------------------------------

write-host "Downloading FuseML"
$repo="fuseml"
$file="fuseml-installer-windows-amd64.tar.gz"
$releases = "https://api.github.com/repos/$repo/$repo/releases"
$tag = (Invoke-WebRequest $releases | ConvertFrom-Json)[0].tag_name

$download = "https://github.com/$repo/$repo/releases/download/$tag/$file"
Invoke-WebRequest $download -Out "fuseml.exe"
 Powershell End -------------------------------------------------------
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
out-null
echo
echo "********* SUCCESS **********"
echo "${yellow}FuseML Installer${textreset} is ready!
To start using it just run ${yellow}fuseml-installer --help${textreset} and enjoy!"
echo "****************************"
echo
# echo "Output a ${yellow} coloured ${textreset} ${red} word ${textreset}."
