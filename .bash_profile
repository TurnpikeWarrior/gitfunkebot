#GitHub
alias gad="git add -A"
alias gpull="git pull upstream master"
alias gmaster="git pull origin master"
alias gpush="git push origin master"
alias gignore="touch .gitignore"
alias status="git status"

#Heroku
alias hpush="git push heroku master"

#Bash Profile Format
alias reload="source ~/.bash_profile"
# export PS1="\n[\u @ \w ]\n[\t]\\$ "

#GEM INSTALL PG Fix
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

#GIT Custom Bash Prompt
parse_git_branch ()
{
    local GITDIR=`git rev-parse --show-toplevel 2>&1` # Get root directory of git repo
    if [[ "$GITDIR" != '/Users/shreyas' ]] # Don't show status of home directory repo
    then
        # Figure out the current branch, wrap in brackets and return it
        local BRANCH=`git branch 2>/dev/null | sed -n '/^\*/s/^\* //p'`
        if [ -n "$BRANCH" ]; then
            echo -e "[$BRANCH]"
        fi
    else
        echo ""
    fi
}

function git_color ()
{
    # Get the status of the repo and chose a color accordingly
    local STATUS=`git status 2>&1`
    if [[ "$STATUS" == *'Not a git repository'* ]]
    then
        echo ""
    else
        if [[ "$STATUS" != *'working directory clean'* ]]
        then
            # red if need to commit
            echo -e '\033[0;31m'
        else
            if [[ "$STATUS" == *'Your branch is ahead'* ]]
            then
                # yellow if need to push
                echo -e '\033[0;33m'
            else
                # else cyan
                echo -e '\033[0;36m'
            fi
        fi
    fi
}

# Call the above functions inside the PS1 declaration
export PS1='\n[\[$(tput bold)\]\[$(tput setaf 1)\]\u\[$(tput sgr0)\] @ \[$(tput bold)\]\[$(tput setaf 3)\]\w\[$(tput sgr0)\]]\n\[$(tput bold)\]\[$(tput setaf 2)\]$(parse_git_branch)\[$(tput sgr0)\] \$ '

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
