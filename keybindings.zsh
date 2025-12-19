zle     -N            fzf-file-widget
bindkey -M emacs '^F' fzf-file-widget
bindkey -M vicmd '^F' fzf-file-widget
bindkey -M viins '^F' fzf-file-widget

zle     -N             fzf-cd-widget
bindkey -M emacs '\ed' fzf-cd-widget
bindkey -M vicmd '\ed' fzf-cd-widget
bindkey -M viins '\ed' fzf-cd-widget


zle     -N            fzf-history-widget
bindkey -M emacs '^H' fzf-history-widget
bindkey -M vicmd '^H' fzf-history-widget
bindkey -M viins '^H' fzf-history-widget
