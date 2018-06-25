#!/bin/bash

the_fonts_dir=$(pwd)/fonts
echo "the fonts dir: $the_fonts_dir"

find_command="find \"$the_fonts_dir\" \( -name '*.[o,t]tf' -or -name '*.pcf.gz' \) -type f -print0"

kernel=$(uname)
case "$kernel" in
    'Darwin') # macOS  
		font_dir="$HOME/Library/Fonts"
		;;
	'Linux')
		font_dir="$HOME/.local/share/fonts"
		mkdir -p $font_dir
		;;
    *)
        echo "Unknown OS: $kernel"
        ;;
esac

# Copy all fonts to user fonts directory
echo "Copying fonts..."
# printing
eval $find_command | xargs -0 -I %

eval $find_command | xargs -0 -I % cp "%" "$font_dir/"

# Reset font cache on Linux
if command -v fc-cache @>/dev/null ; then
    echo -e "\nResetting font cache, this may take a moment..."
    fc-cache -f $font_dir
fi

echo -e "\nAll fonts have been installed to $font_dir"