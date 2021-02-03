export ZDOTDIR="$HOME/.config/zsh"

#SETUP azure 
export KUBECONFIG=/Users/hanspagh/Downloads/aks-batch-prod-cluster.yaml:/Users/hanspagh/Downloads/aks-prod-weu.conf:/Users/hanspagh/Downloads/aks-batch-dev-cluster.yaml:/Users/hanspagh/Downloads/aks-dev-2-weu.conf:$HOME/.kube/config 
export ERL_AFLAGS="-kernel shell_history enabled"
export PYTHONPATH=src/
export PATH="$HOME/.poetry/bin:$PATH"

source $HOME/.poetry/env 