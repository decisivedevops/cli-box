# fish config
set -g fish_greeting

# User configuration
cat /home/root/motd

# granted assume
alias assume="source /usr/local/bin/assume.fish"

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
starship init fish | source

# ls
alias ll="ls -ltr"

# tmux
alias tmux="tmux -f /home/root/tmux.conf"
