function git_remove_branches() {
	git fetch -p && git branch -vv | grep ': gone]' >/tmp/to_be_removed && vi /tmp/to_be_removed && for branch in `cat /tmp/to_be_removed | 
awk '{print $1}'`; do git branch -D $branch ; done 

}
