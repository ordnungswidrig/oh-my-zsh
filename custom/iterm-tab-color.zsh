if [[ "$TERM_PROGRAM" == "iTerm.app" ]] && [[ -z "$INSIDE_EMACS" ]]; then
	
	update_iterm_tab_color() {
		local toplevel=`git rev-parse --show-toplevel 2>/dev/null`
		local sequence=''
		if [ -n "$toplevel" ]; then
			local md5=`echo $toplevel | sed -e 's,.*/,,' | md5`
			local r=`echo "$md5" | cut -b1-2`; r=$(( 0x$r / 4 + 192 ))
			local g=`echo "$md5" | cut -b3-4`; g=$(( 0x$g / 4 + 192 ))
			local b=`echo "$md5" | cut -b5-6`; b=$(( 0x$b / 4 + 192 ))
			sequence="\\033]6;1;bg;red;brightness;$r\\a\
				  \\033]6;1;bg;green;brightness;$g\\a\
				  \\033]6;1;bg;blue;brightness;$b\\a"
		else
			sequence="\\033]6;1;bg;red;brightness;255\\a\
			  	  \\033]6;1;bg;green;brightness;255\\a\
		  		  \\033]6;1;bg;blue;brightness;255\\a"
		fi
		echo -e $sequence
	}


        autoload add-zsh-hook
	add-zsh-hook chpwd update_iterm_tab_color

	update_iterm_tab_color
fi
