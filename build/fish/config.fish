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

# pyenv
# export PYENV_ROOT="/home/root/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

# enhan/cd
# source /home/root/enhancd/init.sh

# starship
export STARSHIP_CONFIG=/home/root/starship.toml
starship init fish | source

# ls
alias ll="ls -ltr"
