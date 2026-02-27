# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ubun/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/ubun/.fzf/bin"
fi

source <(fzf --zsh)
