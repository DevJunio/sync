begin
	set all {insert, default, visual}
	set ni {default, insert}
	set n default
	set i insert
end

bind --erase  \ch
bindm $n \ch _change_directory_home

bindm $n j 'down-or-search'
bindm $n k 'up-or-search'
bindm $i  \cp 'up-line'
bindm $i  \cn 'down-line'
bindm $i  \cc _kill-line
bindm $ni \cd _change_directory_dev
bindm $i  \ec 'capitalize-word'
bindm $i  \el 'downcase-word'
bindm $i  \cb 'backward-char'
bindm $i  \eb 'backward-bigword'
bindm $i  \cf 'forward-char'
bindm $i  \ca 'beginning-of-buffer'
bindm $i  \ce 'end-of-line'
bindm $i  \ed 'kill-bigword'
bindm $ni \ct 'transpose-chars'
bindm $ni \et 'transpose-words'
bindm $ni \cf _editor
bindm $ni \ce _explorer
bindm $ni \cj 'down-or-search'
bindm $ni \ck 'up-or-search'
bindm $i  \cl accept-autosuggestion
bindm $ni \co _recent_directory
bindm $ni \cu _kill-line

bindm $n \er _edit_fish_shell
bindm $ni \ef _edit_config_file # M-f :: edit fish config file
bindm $ni \en _get_back_one_level # M-h: Get back one folder
bindm $ni \er _reload_fish # M-r: Get back one folder
bindm $ni \eb _get_back_back # M-- :: Get back back










function _edit_fish_shell;source $__fish_config_dir/config.fish && commandline -f repaint; end
function _reload_fish;fish && commandline -f repaint; end
function _change_directory_dev;cd $DEV && commandline -f repaint; end
function _change_directory_home;cd $HOME && commandline -f repaint; end
function _kill-line;commandline -f kill-whole-line repaint; end
function _editor;$EDITOR; end
function _explorer; broot; end
function _edit_config_file; $EDITOR $__fish_config_dir; end

function _get_back_one_level; cd .. && commandline -f repaint; end
function _recent_directory; zi && commandline -f repaint; end
