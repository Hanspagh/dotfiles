# Adopted from http://stackoverflow.com/questions/28573145/how-can-i-move-the-cursor-after-a-zsh-abbreviation

setopt extendedglob

typeset -A abbrevs

# General aliases
abbrevs=(
  "ll"   "ls -al"
  "mdc"  "mkdir -p __CURSOR__ && cd \$_"
  "pag" 'ps auxww | grep'
  "fdg" "find . | grep"
  "pgr" "| grep"
  "awkp" "| awk '{print \$__CURSOR__}'"
  "tstamp" "| while read line; do ; echo \$(date | cut -f4 -d ' ') \$line; done"
  "wt"     "while; do __CURSOR__; clear; sleep 5; done"
  "epoch" "date +%s"
  "epochms" 'echo $(($(gdate +%s%N)/1000000))'
  )

# Tmux
abbrevs+=(
  "ta"    "tmux attach"
  "tan"   "tmux attach || tmux new -n editor"
  "tnws"  "tmux new-window -n server bin/webpack-dev-server \; split-window -v rails s"
)

# Git aliases
abbrevs+=(
  "gs"    "git status -sb"
  "gsl"   "git status"
  "gg"    "git lg"
  "ggm"   "git lg origin/master.."
  "ggh"   "git lg --color | head"
  "ggg"   "git ll"

  "ga"   "git add"
  "gad"  "git add ."
  "gaud"  "git add -u ."
  "gap"  "git add -p"

  "gc"    "git commit -v"
  "gca"   "git commit --amend -v"
  "gcane" "git commit --amend --no-edit"
  "gcm"   "git commit -m"
  "gcmw"   "git commit -m wip"

  "gco"     "git checkout"
  "gcom"    "git checkout master"
  "gcoh"    "git checkout HEAD"
  "gcohd"   "git checkout HEAD --"
  "gcohgl"  "git checkout HEAD -- Gemfile.lock"
  "gcohglb" "git checkout HEAD -- Gemfile.lock; bundle"
  "gcl"     "git clone"
  "gclc"    "git clone __CURSOR__ && cd \$(basename \$_)"
  "gb"      "git branch"
  "gbm"     "git branch -M"
  "gbv"     "git branch -vv"
  "gba"     "git branch -a"
  "gbav"    "git branch -a -vv"
  "gbsmd"   "git fetch -p && for branch in \$(git branch -vv | grep ': gone]' | awk '{print \$1}'); do git branch -D \$branch; done"

  "gbmd"   'git branch --merged | grep  -v "\*\|master" | xargs -n1 git branch -d'
  "gbrmd"  'git branch -r --merged | grep origin | grep -v "\->\|master" | cut -d"/" -f2- | xargs git push origin --delete'

  "gd"    "git diff"
  "gdm"   "git diff origin/master.."
  "gdms"  "git diff origin/master:./"
  "gdc"   "git diff --cached"
  "gdt"   "git difftool"
  "gdh"   "git diff HEAD~1"

  "gfo"   "git fetch origin"

  "gp"    "git push"
  "gpu"   "git push -u"
  "gpf"   "git push --force-with-lease"
  "gpo"   "git push origin"
  "gpod"  "git push origin --delete"

  "gl"    "git pull"
  "glr"   "git pull --rebase"
  "glor"  "git pull origin --rebase"
  "glomr" "git pull origin master --rebase"

  "gpr"   "hub pull-request"
  "gprne" "EDITOR='vim -c \":wq\"' hub pull-request"

  "grb"   "git rebase"
  "grbi"  "git rebase -i"
  "grba"  "git rebase --abort"
  "grbc"  "git rebase --continue"
  "grbm"  "git rebase master"
  "grbom" "git rebase origin/master"
  "grbim" "git rebase -i master"

  "grh"   "git reset --hard"
  "grhu"  "git reset --hard @{u}"
  "grsm"  "git reset --soft master"

  "gchp"  "git cherry-pick"
  "gchpc" "git cherry-pick --continue"
  "gchpa" "git cherry-pick --abort"

  "gsh"  "git show"
  "gshh" "git show HEAD"

  "gsu"  "git submodule update --init --recursive"
  "gsgl" "git submodule -q foreach git pull -q origin master"

  "gst"  "git stash"
  "gstl" "git stash list"
  "gstp" "git stash pop"

  "gcb"   "git checkout -b"

  "vgu"  'vim $(git ls-files --unmerged | cut -f2 | sort -u)'
)

# Kubenetes
abbrevs+=(
"k" "kubectl"


  "kca" 'f(){ kubectl "$@" --all-namespaces;  unset -f f; }; f'


  "kaf" 'kubectl apply -f'


  "keti" 'kubectl exec -ti'


  "kcuc" 'kubectl config use-context'
  "kcsc" 'kubectl config set-context'
  "kcdc" 'kubectl config delete-context'
  "kccc" 'kubectl config current-context'


  "kcgc" 'kubectl config get-contexts'


  "kdel" 'kubectl delete'
  "kdelf" 'kubectl delete -f'


  "kgp" 'kubectl get pods'
  "kgpw" 'kgp --watch'
  "kgpwide" 'kgp -o wide'
  "kep" 'kubectl edit pods'
  "kdp" 'kubectl describe pods'
  "kdelp" 'kubectl delete pods'


  "kgpl" 'kgp -l'


  "kgs" 'kubectl get svc'
  "kgsw" 'kgs --watch'
  "kgswide" 'kgs -o wide'
  "kes" 'kubectl edit svc'
  "kds" 'kubectl describe svc'
  "kdels" 'kubectl delete svc'


  "kgi" 'kubectl get ingress'
  "kei" 'kubectl edit ingress'
  "kdi" 'kubectl describe ingress'
  "kdeli" 'kubectl delete ingress'


  "kgns" 'kubectl get namespaces'
  "kens" 'kubectl edit namespace'
  "kdns" 'kubectl describe namespace'
  "kdelns" 'kubectl delete namespace'
  "kcn" 'kubectl config set-context $(kubectl config current-context) --namespace'


  "kgcm" 'kubectl get configmaps'
  "kecm" 'kubectl edit configmap'
  "kdcm" 'kubectl describe configmap'
  "kdelcm" 'kubectl delete configmap'


  "kgsec" 'kubectl get secret'
  "kdsec" 'kubectl describe secret'
  "kdelsec" 'kubectl delete secret'


  "kgd" 'kubectl get deployment'
  "kgdw" 'kgd --watch'
  "kgdwide" 'kgd -o wide'
  "ked" 'kubectl edit deployment'
  "kdd" 'kubectl describe deployment'
  "kdeld" 'kubectl delete deployment'
  "ksd" 'kubectl scale deployment'
  "krsd" 'kubectl rollout status deployment'


  "kgrs" 'kubectl get rs'
  "krh" 'kubectl rollout history'
  "kru" 'kubectl rollout undo'


  "kgss" 'kubectl get statefulset'
  "kgssw" 'kgss --watch'
  "kgsswide" 'kgss -o wide'
  "kess" 'kubectl edit statefulset'
  "kdss" 'kubectl describe statefulset'
  "kdelss" 'kubectl delete statefulset'
  "ksss" 'kubectl scale statefulset'
  "krsss" 'kubectl rollout status statefulset'


  "kpf" "kubectl port-forward"


  "kga" 'kubectl get all'
  "kgaa" 'kubectl get all --all-namespaces'


  "kl" 'kubectl logs'
  "klf" 'kubectl logs -f'


  "kcp" 'kubectl cp'


  "kgno" 'kubectl get nodes'
  "keno" 'kubectl edit node'
  "kdno" 'kubectl describe node'
  "kdelno" 'kubectl delete node'


  "kgpvc" 'kubectl get pvc'
  "kgpvcw" 'kgpvc --watch'
  "kepvc" 'kubectl edit pvc'
  "kdpvc" 'kubectl describe pvc'
  "kdelpvc" 'kubectl delete pvc'

)

# Add alias and autocompleteion for hub
type compdef >/dev/null 2>&1 && compdef hub=git
type hub >/dev/null 2>&1 && alias git='hub'

for abbr in ${(k)abbrevs}; do
  alias $abbr="${abbrevs[$abbr]}"
done

magic-abbrev-expand() {
  local MATCH
  LBUFFER=${LBUFFER%%(#m)[_a-zA-Z0-9]#}
  command=${abbrevs[$MATCH]}
  LBUFFER+=${command:-$MATCH}

  if [[ "${command}" =~ "__CURSOR__" ]]; then
    RBUFFER=${LBUFFER[(ws:__CURSOR__:)2]}
    LBUFFER=${LBUFFER[(ws:__CURSOR__:)1]}
  else
    zle self-insert
  fi
}

magic-abbrev-expand-and-execute() {
  magic-abbrev-expand
  zle backward-delete-char
  zle accept-line
}

no-magic-abbrev-expand() {
  LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N magic-abbrev-expand-and-execute
zle -N no-magic-abbrev-expand

bindkey " " magic-abbrev-expand
bindkey "^M" magic-abbrev-expand-and-execute
bindkey "^x " no-magic-abbrev-expand
bindkey -M isearch " " self-insert
