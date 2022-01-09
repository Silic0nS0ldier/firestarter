# Requires `cargo install pad-path` https://github.com/jrhawley/pad-path/
function adjustNodePath() {
    case $PWD/ in
        /Users/jordan/source/canva-repos/*)
            PATH=$(pad clean)
            PATH=$(pad rm /usr/local/opt/node@17/bin 2>&-)
            PATH=$(pad add -f /usr/local/opt/node@12/bin);;
        *)
            PATH=$(pad clean)
            PATH=$(pad rm /usr/local/opt/node@12/bin 2>&-)
            PATH=$(pad add -f /usr/local/opt/node@17/bin);;
    esac
}
adjustNodePath

setopt interactivecomments
setopt prompt_subst # enable command substition in prompt

_node_path_on_cwd_change() {
    adjustNodePath
}
(( $+functions[add-zsh-hook] )) || autoload -Uz add-zsh-hook
add-zsh-hook chpwd _node_path_on_cwd_change

function prompt_lite_cmd() {
    # Prompt GUI
    oh-my-posh --config ~/.lite.omp.json
}

function prompt_full_cmd() {
    # Prompt GUI
    oh-my-posh --config ~/.full.omp.json
}

PROMPT='$(prompt_lite_cmd)' # single quotes to prevent immediate execution

ASYNC_PROC=0
function precmd() {
    function async() {
        # save to temp file
        printf "%s" "$(prompt_full_cmd)" > "/tmp/zsh_prompt_$$"

        # Wait a little while to avoid race conditions
        sleep 0.1

        # signal parent
        kill -s USR1 $$
    }

    # kill child if necessary
    if [[ "${ASYNC_PROC}" != 0 ]]; then
        kill -s HUP $ASYNC_PROC >/dev/null 2>&1 || :
    fi

    # start background computation
    async &!
    ASYNC_PROC=$!
}

function TRAPUSR1() {
    # read from temp file
    PROMPT="$(cat /tmp/zsh_prompt_$$)"
    # remove the temp file
    rm /tmp/zsh_prompt_$$

    # reset proc number
    ASYNC_PROC=0

    # redisplay
    zle && zle reset-prompt

    # prepare for next
    PROMPT='$(prompt_lite_cmd)'
}

export PNPM_HOME="/Users/jordan/Library/pnpm"
PATH=$(pad add -f $PNPM_HOME)

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Nix
source /Users/jordan/.nix-profile/etc/profile.d/nix.sh
