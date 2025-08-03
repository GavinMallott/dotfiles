
PROMPT='%{$fg_bold[blue]%}┌[%{$reset_color%}%F{#5e5c64}%n%{$reset_color%}%{$fg_bold[green]%}@%{$reset_color%}%F{#5e5c64}%m%{$fg_bold[blue]%}]%{$reset_color%} %F{#5e5c64}%B-%b$(git_prompt_info) %{$fg_bold[blue]%}[%{$reset_color%}%F{#f66151}%*%{$reset_color%}%{$fg_bold[blue]%}]
'
PROMPT+='%{$fg_bold[blue]%}└'
PROMPT+="%(?:%{$fg_bold[blue]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+="%{$fg[green]%}%~%{$reset_color%} %F{#a347ba}%Bζ%b%f%{$reset_color%} "

PS2=$' {%fg_bold[blue]%}>%{%reset_color%} '

export PROMPT_COPY=$PROMPT

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$reset_color%}%{$fg_bold[blue]%}[%{$reset_color%}%F{#c061cb}%B\uE0A0 %b%F{blue}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[blue]%}]%{$reset_color%} %F{#5e5c64}%B-%b%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg_bold[blue]%}✓"
