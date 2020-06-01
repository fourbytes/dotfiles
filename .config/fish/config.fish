if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# set -gx fish_user_paths "$HOME/bin" $fish_user_paths  
direnv hook fish | source

# test (tty) = '/dev/tty1'; and start_sway;

# bind \t accept-autosuggestion

fish_default_key_bindings

starship init fish | source
