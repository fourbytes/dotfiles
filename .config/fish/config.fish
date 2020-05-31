# set -gx fish_user_paths "$HOME/bin" $fish_user_paths  
direnv hook fish | source

# test (tty) = '/dev/tty1'; and start_sway;

# bind \t accept-autosuggestion

fish_default_key_bindings

set DIR ~/.git-template
git config --global init.templateDir {$DIR}
pre-commit init-templatedir -t pre-commit {$DIR}
