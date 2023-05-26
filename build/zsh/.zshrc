# zsh configuration
HISTFILE=/root/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# motd
cat /home/root/motd

# kubectl
alias k=kubectl

# terraform alias
alias tf=terraform
alias tfp="terraform plan"
alias tfa="terraform apply"
alias tfi="terraform init"
alias tfv="terraform validate"
alias tfd="terraform destroy"
alias tff="terraform fmt -recursive"

# aws-vault
alias aws-vault='aws-vault --backend=file'

# starship
export STARSHIP_CONFIG=/home/root/starship.toml
eval "$(starship init zsh)"

# ls
alias ll="ls -ltr"

# enhan/cd
source /home/root/enhancd/init.sh

# zsh-autocomplete
source /home/root/zsh-autocomplete-*/zsh-autocomplete.plugin.zsh

# granted
alias assume="source /usr/local/bin/assume"
export GRANTED_ENABLE_AUTO_REASSUME=true

# kubie
alias ku="kubie"

# start tmux with custom conf
alias tmux="tmux -f /home/root/tmux.conf"

# atuin
eval "$(atuin init zsh)"
