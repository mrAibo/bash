# .bashrc

# Don't put duplicate lines in the history. See bash(1) for more options
# and ignore commands that start with a space
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=100000
HISTFILESIZE=2000000
# this ignores single-word commands
# HISTIGNORE=$'*([\t ])+([-%+,./0-9\:@A-Z_a-z])*([\t ])'
HISTIGNORE="&:ls:ll:[bf]g:exit:pwd:clear:[ \t]*"
# If we're disconnected, capture whatever is in history
trap 'history -a' SIGHUP
HISTTIMEFORMAT="%F %T "
PROMPT_COMMAND="history -a; history -c; history -r"

shopt -s histappend
# Combine multiline commands into one in history
shopt -s cmdhist
# ignore case when using cd
bind 'set completion-ignore-case On'

# BASH OPTIONS
shopt -s cdspell                 # Correct cd typos
shopt -s checkwinsize            # Update windows size on command
shopt -s histappend              # Append History instead of overwriting file
shopt -s cmdhist                 # Bash attempts to save all lines of a multiple-line command in the same history entry
shopt -s expand_aliases
shopt -s extglob # Extended pattern
# Correct minor errors in the spelling of a directory
shopt -s cdspell
shopt -s dirspell

# show list automatically, without double tab
#bind "set show-all-if-ambiguous On"
if [ -t 1 ]; then
  bind "TAB:menu-complete"
  bind "set show-all-if-ambiguous on"
  bind "set completion-ignore-case on"
  bind "set menu-complete-display-prefix on"
  bind '"\e[Z":menu-complete-backward'
fi

# Create an array of potential dotfiles
dotfiles=(
  "${HOME}/.bash_aliases"
  "${HOME}/.bash_functions"
  "${HOME}/.proxyrc"
)

# Work through our list of dotfiles, if a match is found, load it
# shellcheck source=/dev/null
for dotfile in "${dotfiles[@]}"; do
  [[ -r "${dotfile}" ]] && . "${dotfile}"
done

#Find a command in your grep history
#alias gh='history|grep'
#Count files
alias count='find . -type f | wc -l'
#Create a Python virtual environment
#alias ve='python3 -m venv ./venv'
#activates the environment
#alias va='source ./venv/bin/activate'
#Add a copy progress bar
#alias cpv='rsync -ah --info=progress2'
#removes full-line comments and blank lines
alias decomment='egrep -v "^[[:space:]]*((#|;|//).*)?$" '
#To see the list of mounted hard drives
alias mnt='mount | grep -E ^/dev | sort | column -t'
# Easier navigation: .., ..., ...., .....
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
# Display formatted path
alias path='printf "%b\n" "${PATH//:/\\n}"'

alias sdiff='sdiff -w $(( "${COLUMNS:-$(tput cols)}" - 2 ))'
#Find a Command in Your Grep History
alias h='history | grep'
#Find process
function p() { ps aux | grep "$1" | grep -v grep; }
# Memory usage
#alias memu='ps -e -o rss=,args= | sort -b -k1,1n | pr -TW$COLUMNS'

alias -- +x='chmod +x'
alias -- -x='chmod -x'

#octal ls -l (may be instead ll?)
alias ols="ls -la --color | awk '{k=0;for(i=0;i<=8;i++)k+=((substr(\$1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(\" %0o \",k);print}'"


# # Farben definieren
# RED='\033[1;31m'
# GREEN='\033[1;32m'
# BLUE='\033[1;34m'
# CYAN='\033[1;36m'
# WHITE='\033[1;37m'
# RESET='\033[0m'
#
# # Exportieren des PS1 je nach Benutzerrechten (Root vs. Normaler Benutzer)
# if [[ ${EUID} == 0 ]]; then
#     export PS1="\A ${RED}\u${WHITE}@${BLUE}\h${WHITE}:${CYAN}[\w]${WHITE}:${RESET} "
# else
#     export PS1="\A ${GREEN}\u${WHITE}@${BLUE}\h${WHITE}:${CYAN}[\w]${WHITE}:${RESET} "
# fi

if [[ ${EUID} == 0 ]]; then
    # Root user
    export PS1='\[\e[1;37m\]\A \[\e[1;31m\]\u\[\e[1;37m\]@\[\e[1;34m\]\h\[\e[1;37m\]:\[\e[1;36m\][\w]\[\e[1;37m\]:\[\e[0m\] '
else
    # Normal user
    export PS1='\[\e[1;37m\]\A \[\e[1;32m\]\u\[\e[1;37m\]@\[\e[1;34m\]\h\[\e[1;37m\]:\[\e[1;36m\][\w]\[\e[1;37m\]:\[\e[0m\] '
fi



if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


venv_manager() {
    local ACTION=$1 VENV_DIR=${2:-.venv} PYTHON=${3:-python3}
    local GREEN='\033[0;32m' RED='\033[0;31m' YELLOW='\033[0;33m' BLUE='\033[0;34m' RESET='\033[0m'
    local BOLD='\033[1m'

    echo_color() { echo -e "${!1}${BOLD}$2${RESET}"; }

    usage() {
        echo_color BLUE "Usage: venv_manager {create|remove|activate|deactivate|status|howto} [venv_dir] [python_executable]"
        echo
        echo "Actions:"
        echo "  create     - Create a new virtual environment"
        echo "  remove     - Remove an existing virtual environment"
        echo "  activate   - Activate an existing virtual environment"
        echo "  deactivate - Deactivate the current virtual environment"
        echo "  status     - Show the status of the virtual environment"
        echo "  howto      - Display information on using and transferring virtual environments"
        echo
        echo "Options:"
        echo "  venv_dir   - Directory for the virtual environment (default: .venv)"
        echo "  python_executable - Python executable to use (default: python3)"
    }

    howto() {
        echo_color BLUE "Virtual Environment Howto:"
        echo
        echo "1. Creating a virtual environment:"
        echo "   venv_manager create myenv"
        echo
        echo "2. Activating the environment:"
        echo "   venv_manager activate myenv"
        echo
        echo "3. Installing packages:"
        echo "   pip install package_name"
        echo
        echo "4. Deactivating the environment:"
        echo "   venv_manager deactivate"
        echo
        echo "5. Transferring to another server (Method 1 - Requirements file):"
        echo "   a. Create a requirements file:"
        echo "      pip freeze > requirements.txt"
        echo
        echo "   b. Transfer the requirements file to the new server"
        echo
        echo "   c. On the new server, create a new virtual environment:"
        echo "      venv_manager create myenv"
        echo
        echo "   d. Activate the new environment:"
        echo "      venv_manager activate myenv"
        echo
        echo "   e. Install the packages from the requirements file:"
        echo "      pip install -r requirements.txt"
        echo
        echo "6. Transferring to another server (Method 2 - Tar archive):"
        echo "   a. Create a tar archive of the virtual environment:"
        echo "      tar -czf myenv.tar.gz -C /path/to/parent/dir myenv"
        echo
        echo "   b. Transfer the tar file to the new server using scp or your preferred method:"
        echo "      scp myenv.tar.gz user@newserver:/path/to/destination/"
        echo
        echo "   c. On the new server, extract the tar file:"
        echo "      tar -xzf myenv.tar.gz -C /path/to/extract/"
        echo
        echo "   d. Activate the transferred environment:"
        echo "      source /path/to/extract/myenv/bin/activate"
        echo
        echo "   e. Update the environment's path (if necessary):"
        echo "      virtualenv --relocatable /path/to/extract/myenv"
        echo
        echo "Note: When using the tar method, ensure that both servers have compatible"
        echo "      Python versions and system libraries. You may need to reinstall"
        echo "      certain packages if there are significant differences between the servers."
    }

    create_venv() {
        echo_color BLUE "Creating virtualenv '$VENV_DIR' using $PYTHON..."
        if ! command -v virtualenv &> /dev/null; then
            echo_color YELLOW "virtualenv not found. Attempting to install it..."
            if ! pip install --user virtualenv; then
                echo_color RED "Failed to install virtualenv. Please install it manually and try again."
                return 1
            fi
        fi
        if ! virtualenv --always-copy -p $PYTHON "$VENV_DIR"; then
            echo_color RED "Failed to create virtualenv using virtualenv with --always-copy option."
            return 1
        fi
        source "$VENV_DIR/bin/activate" &&
        pip install --upgrade pip wheel &&
        echo_color GREEN "Virtualenv '$VENV_DIR' created and activated." ||
        { echo_color RED "Failed to setup virtualenv."; return 1; }
    }

    if [[ "$ACTION" != "create" && "$ACTION" != "remove" && "$ACTION" != "activate" && "$ACTION" != "deactivate" && "$ACTION" != "status" && "$ACTION" != "howto" ]]; then
        usage
        return 1
    fi

    case "$ACTION" in
        create)
            if [[ -d "$VENV_DIR" ]]; then
                echo_color YELLOW "Virtualenv '$VENV_DIR' already exists."
                read -p "Overwrite? (y/n) " REPLY
                [[ ! "$REPLY" =~ ^[Yy]$ ]] && echo_color RED "Cancelled." && return 1
                rm -rf "$VENV_DIR"
            fi
            create_venv
            ;;
        remove)
            [[ ! -d "$VENV_DIR" ]] && echo_color RED "Virtualenv '$VENV_DIR' not found." && return 1
            echo_color YELLOW "Removing virtualenv '$VENV_DIR'..."
            rm -rf "$VENV_DIR" && echo_color GREEN "Virtualenv '$VENV_DIR' removed." ||
            { echo_color RED "Failed to remove virtualenv."; return 1; }
            ;;
        activate)
            [[ ! -d "$VENV_DIR" ]] && echo_color RED "Virtualenv '$VENV_DIR' not found." && return 1
            source "$VENV_DIR/bin/activate" &&
            echo_color GREEN "Virtualenv '$VENV_DIR' activated." ||
            { echo_color RED "Failed to activate virtualenv."; return 1; }
            ;;
        deactivate)
            [[ -z "$VIRTUAL_ENV" ]] && echo_color YELLOW "No active virtualenv found." && return 0
            deactivate &&
            echo_color GREEN "Virtualenv deactivated." ||
            { echo_color RED "Failed to deactivate virtualenv."; return 1; }
            ;;
        status)
            if [[ -n "$VIRTUAL_ENV" ]]; then
                echo_color GREEN "Active virtualenv: $VIRTUAL_ENV"
                echo "Python version: $($VIRTUAL_ENV/bin/python --version)"
                echo "Pip version: $($VIRTUAL_ENV/bin/pip --version)"
            else
                echo_color YELLOW "No active virtualenv."
                [[ -d "$VENV_DIR" ]] && echo_color BLUE "Virtualenv '$VENV_DIR' exists but is not activated." ||
                echo_color RED "Virtualenv '$VENV_DIR' does not exist."
            fi
            ;;
        howto)
            howto
            ;;
    esac
}



#get a certain column of the output. Example: df -h|fawk 2
function fawk {
    first="awk '{print "
    last="}'"
    cmd="${first}\$${1}${last}"
    eval $cmd
}

# extract file
# ex () {
#     if [ -f $1 ] ; then
#         case $1 in
#             *.tar.bz2)   tar xvjf $1                  ;;
#             *.tar.gz)    tar xvzf $1                  ;;
#             *.bz2)       bunzip2 $1                   ;;
#             *.rar)       unrar x $1                   ;;
#             *.gz)        gunzip $1                    ;;
#             *.tar)       tar xvf $1                   ;;
#             *.tbz2)      tar xvjf $1                  ;;
#             *.tgz)       tar xvzf $1                  ;;
#             *.zip)       unzip $1                     ;;
#             *.Z)         uncompress $1                ;;
#             *.7z)        7z x $1                      ;;
#             *)           echo "can't extract '$1'..." ;;
#         esac
#     else
#         echo "'$1' is not a valid file!"
#     fi
# }

ex() {
    local usage="Usage: ex [OPTIONS] file1 [file2 ...]"
    local verbose=false
    local target_dir=""
    local delete_after=false
    local mode="extract"
    local compress_format=""
    local exclude_patterns=()

    # Color definitions
    declare -A colors=(
        [GREEN]='\033[0;32m'
        [RED]='\033[0;31m'
        [YELLOW]='\033[0;33m'
        [BLUE]='\033[0;34m'
        [NC]='\033[0m'
    )

    echo_color() {
        local color="${colors[$1]}"
        shift
        echo -e "${color}$*${colors[NC]}"
    }

    show_help() {
        cat << EOF
${colors[BLUE]}Extract and Compress (ex) Function Help:${colors[NC]}

Description:
  ex is a versatile function for extracting and compressing various types of files.

Syntax:
  ex [OPTIONS] file1 [file2 ...]

Options:
  -x, --extract           Extract mode (default)
  -c, --compress format   Compress mode (specify format: tar.gz, tar.bz2, zip, 7z)
  -v, --verbose           Verbose mode (show detailed output)
  -t, --target dir        Specify target directory for extraction or compression
  -d, --delete            Delete original file(s) after operation
  -e, --exclude pattern   Exclude files/directories matching the pattern or specified in the file (compression only)
  -h, --help              Show this help message

Supported extraction formats:
  .tar.bz2, .tar.gz, .bz2, .rar, .gz, .tar, .tbz2, .tgz, .zip, .Z, .7z, .xz, .exe, .tar.xz, .tar.zst

Supported compression formats:
  tar.gz, tar.bz2, zip, 7z

Exclude Patterns:
  The --exclude option allows you to specify patterns for files or directories to exclude during compression.
  You can use it in two ways:
  1. Specify a file containing exclude patterns (one per line)
  2. Provide a single exclude pattern directly
  - For tar-based formats (tar.gz, tar.bz2): Use standard tar exclude patterns
  - For zip: Use standard zip exclude patterns
  - For 7z: Use 7z exclude patterns

Examples:
  ex archive.tar.gz                                    # Extract archive.tar.gz
  ex --verbose --target /tmp file1.zip file2.rar       # Extract files to /tmp with verbose output
  ex --compress tar.gz --target /tmp file1 file2       # Compress files to /tmp/archive.tar.gz
  ex --extract --delete archive.zip                    # Extract and delete archive.zip after extraction
  ex -c zip -e '*.log' --target /tmp dir1 dir2         # Compress dirs to zip, excluding .log files
  ex --compress tar.gz --exclude 'temp/' -e '*.tmp' file1  # Compress to tar.gz, excluding temp dir and .tmp files
  ex -c zip --exclude exclude.txt dir1 dir2            # Compress to zip, using patterns from exclude.txt
EOF
    }

    # Use getopt for better long option handling
    local options
    options=$(getopt -o xc:vt:de:h -l extract,compress:,verbose,target:,delete,exclude:,help -n 'ex' -- "$@")
    
    if [ $? -ne 0 ]; then
        echo "Error: Invalid option" >&2
        return 1
    fi

    eval set -- "$options"

    while true; do
        case "$1" in
            -x|--extract)
                mode="extract"
                shift ;;
            -c|--compress)
                mode="compress"
                compress_format="$2"
                shift 2 ;;
            -v|--verbose)
                verbose=true
                shift ;;
            -t|--target)
                target_dir="$2"
                shift 2 ;;
            -d|--delete)
                delete_after=true
                shift ;;
            -e|--exclude)
                exclude_patterns+=("$2")
                shift 2 ;;
            -h|--help)
                show_help
                return 0 ;;
            --)
                shift
                break ;;
            *)
                echo "Internal error!"
                return 1 ;;
        esac
    done

    if [ $# -eq 0 ]; then
        echo "$usage" >&2
        return 1
    fi

    command_exists() {
        command -v "$1" >/dev/null 2>&1
    }

    extract_file() {
        local file="$1"
        local extract_dir="${target_dir:-.}"
        
        [ -d "$extract_dir" ] || mkdir -p "$extract_dir"
        
        local cmd=""
        
        case "$file" in
            *.tar.bz2|*.tbz2)   cmd="tar xjf '$file' -C '$extract_dir'" ;;
            *.tar.gz|*.tgz)     
                if command_exists pigz; then
                    cmd="tar --use-compress-program=pigz -xf '$file' -C '$extract_dir'"
                else
                    cmd="tar xzf '$file' -C '$extract_dir'"
                fi ;;
            *.bz2)              cmd="bunzip2 -c '$file' > '$extract_dir/$(basename "${file%.bz2}")'" ;;
            *.rar)              cmd="unrar x '$file' '$extract_dir' ${verbose:+-inul}" ;;
            *.gz)               
                if command_exists pigz; then
                    cmd="pigz -dc '$file' > '$extract_dir/$(basename "${file%.gz}")'"
                else
                    cmd="gunzip -c '$file' > '$extract_dir/$(basename "${file%.gz}")'"
                fi ;;
            *.tar)              cmd="tar xf '$file' -C '$extract_dir'" ;;
            *.zip)              cmd="unzip ${verbose:+-q} '$file' -d '$extract_dir'" ;;
            *.Z)                cmd="uncompress -c '$file' > '$extract_dir/$(basename "${file%.Z}")'" ;;
            *.7z)               cmd="7z x '$file' -o'$extract_dir' ${verbose:+-bd}" ;;
            *.xz)               cmd="xz -dc '$file' > '$extract_dir/$(basename "${file%.xz}")'" ;;
            *.exe)              cmd="cabextract '$file' -d '$extract_dir' ${verbose:+-q}" ;;
            *.tar.xz)           cmd="tar xJf '$file' -C '$extract_dir'" ;;
            *.tar.zst)          cmd="tar --zstd -xf '$file' -C '$extract_dir'" ;;
            *)                  echo_color RED "Error: Unable to extract '$file' - unknown archive type." ; return 1 ;;
        esac

        if $verbose; then
            echo "Executing: $cmd"
            eval "$cmd"
        else
            eval "$cmd" >/dev/null 2>&1
        fi
    }

    process_exclude_patterns() {
        local patterns=()
        for item in "${exclude_patterns[@]}"; do
            if [ -f "$item" ]; then
                while IFS= read -r line || [[ -n "$line" ]]; do
                    [ -z "$line" ] && continue
                    patterns+=("$line")
                done < "$item"
            else
                patterns+=("$item")
            fi
        done
        echo "${patterns[@]}"
    }

    compress_files() {
        local output_file="$target_dir/archive.$compress_format"
        [ -d "$target_dir" ] || mkdir -p "$target_dir"
        
        local quiet_flag=$(! $verbose && echo "--quiet")
        local exclude_opts=""
        
        # Process exclude patterns
        local processed_patterns=($(process_exclude_patterns))
        for pattern in "${processed_patterns[@]}"; do
            case "$compress_format" in
                tar.gz|tar.bz2)
                    exclude_opts="$exclude_opts --exclude='$pattern'" ;;
                zip)
                    exclude_opts="$exclude_opts -x '$pattern'" ;;
                7z)
                    exclude_opts="$exclude_opts -xr!$pattern" ;;
            esac
        done
        
        case "$compress_format" in
            tar.gz)
                if command_exists pigz; then
                    eval tar --use-compress-program=pigz -cf "$output_file" $exclude_opts "$@" $quiet_flag
                else
                    eval tar czf "$output_file" $exclude_opts "$@" $quiet_flag
                fi ;;
            tar.bz2)
                if command_exists pbzip2; then
                    eval tar --use-compress-program=pbzip2 -cf "$output_file" $exclude_opts "$@" $quiet_flag
                else
                    eval tar cjf "$output_file" $exclude_opts "$@" $quiet_flag
                fi ;;
            zip)
                if command_exists pigz; then
                    eval zip -r $(! $verbose && echo "-q") "$output_file" "$@" -Z pigz $exclude_opts
                else
                    eval zip -r $(! $verbose && echo "-q") "$output_file" "$@" $exclude_opts
                fi ;;
            7z)
                eval 7z a "$output_file" "$@" $exclude_opts $(! $verbose && echo "-bd") ;;
            *)
                echo_color RED "Error: Unsupported compression format '$compress_format'"
                return 1 ;;
        esac
    }

    if [ "$mode" = "extract" ]; then
        for file in "$@"; do
            if [ -f "$file" ]; then
                echo_color GREEN "Extracting $file..."
                if extract_file "$file"; then
                    echo_color GREEN "Extraction of $file completed successfully."
                    if $delete_after; then
                        rm "$file" && echo_color YELLOW "Deleted original archive: $file"
                    fi
                else
                    echo_color RED "Error: Extraction of $file failed."
                fi
            else
                echo_color YELLOW "Warning: '$file' is not a valid file!"
            fi
        done
    elif [ "$mode" = "compress" ]; then
        echo_color GREEN "Compressing files to $compress_format format..."
        if compress_files "$@"; then
            echo_color GREEN "Compression completed successfully."
            if $delete_after; then
                echo_color YELLOW "Deleting original files..."
                rm "$@" && echo_color YELLOW "Original files deleted."
            fi
        else
            echo_color RED "Error: Compression failed."
        fi
    fi
}

# Create a new directory and enter it
mkd() {
        mkdir -p "$@"
        cd "$@" || return 1
}

rcp() {
    local usage="Usage: rcp [OPTIONS] source destination"
    local compress=false move=false
    local user="" port="" identity="" limit="" exclude_file=""
    local use_scp=false verbose=false

    # Color definitions
    local GREEN='\033[0;32m'
    local RED='\033[0;31m'
    local YELLOW='\033[0;33m'
    local BLUE='\033[0;34m'
    local NC='\033[0m' # No Color

    echo_color() {
        local color=$1
        shift
        echo -e "${color}$@${NC}"
    }

    show_help() {
        cat << EOF
${BLUE}Remote Copy (rcp) Function Help:${NC}

Description:
  rcp is a versatile function for copying files/directories locally or to/from remote systems.
  It supports both rsync and scp, with various options for compression, moving files, and more.

Syntax:
  rcp [OPTIONS] source destination

Options:
  -z, --compress           Compress the transfer (uses tar and pigz/gzip)
  -m, --move               Move files instead of copying (delete source after successful transfer)
  -u, --user USERNAME      Specify username for remote connections
  -p, --port PORT          Specify SSH port
  -i, --identity FILE      Specify SSH identity file (private key)
  -l, --limit RATE         Set bandwidth limit (in KB/s, for rsync only)
  -e, --exclude FILE       Specify exclude file or pattern
  -s, --use-scp            Force using SCP instead of rsync
  -v, --verbose            Verbose output
  -h, --help               Show this help message

Exclude Patterns:
  The --exclude option can be used to specify an exclude file or a single pattern. 
  You can use it in two ways:
  1. Specify a file containing exclude patterns (one per line)
  2. Provide a single exclude pattern directly

  Pattern examples:
  - /path/to/file.bac       Exclude a single file
  - /path/to/*.bac          Exclude all .bac files in the specified directory
  - /path/to                Exclude an entire directory
  - /path/to/*              Exclude the contents of a directory, but not the directory itself
  - *.tmp                   Exclude all files ending with .tmp in any directory
  - /path/to/dir/*.{jpg,png,gif}  Exclude all jpg, png, and gif files in the specified directory

Examples:
  rcp /path/to/source /path/to/destination
  rcp --compress --verbose --exclude '*.log' /path/to/source user@remote:/path/to/destination
  rcp -m -p 2222 -i ~/.ssh/my_key /path/to/source user@remote:/path/to/destination
  rcp --move --use-scp --exclude exclude.txt /path/to/source user@remote:/path/to/destination
  rcp -z -l 1000 -e '**/*.tmp' /path/to/source user@remote:/path/to/destination
EOF
    }

    # Use getopt for better long option handling
    local options
    options=$(getopt -o zmu:p:i:l:e:svh -l compress,move,user:,port:,identity:,limit:,exclude:,use-scp,verbose,help -n 'rcp' -- "$@")
    
    if [ $? -ne 0 ]; then
        echo "Error: Invalid option" >&2
        return 1
    fi

    eval set -- "$options"

    while true; do
        case "$1" in
            -z|--compress)
                compress=true
                shift ;;
            -m|--move)
                move=true
                shift ;;
            -u|--user)
                user="$2"
                shift 2 ;;
            -p|--port)
                port="$2"
                shift 2 ;;
            -i|--identity)
                identity="$2"
                shift 2 ;;
            -l|--limit)
                limit="$2"
                shift 2 ;;
            -e|--exclude)
                exclude_file="$2"
                shift 2 ;;
            -s|--use-scp)
                use_scp=true
                shift ;;
            -v|--verbose)
                verbose=true
                shift ;;
            -h|--help)
                show_help
                return 0 ;;
            --)
                shift
                break ;;
            *)
                echo "Internal error!"
                return 1 ;;
        esac
    done

    if [ $# -ne 2 ]; then
        echo "$usage" >&2
        return 1
    fi

    local src="$1" dest="$2"
    local temp_dir=""
    local tarfile=""

    # Function to process exclude patterns
    process_exclude_patterns() {
        local exclude_patterns=()
        if [ -f "$exclude_file" ]; then
            while IFS= read -r line || [[ -n "$line" ]]; do
                [ -z "$line" ] && continue
                exclude_patterns+=("$line")
            done < "$exclude_file"
        elif [ -n "$exclude_file" ]; then
            exclude_patterns+=("$exclude_file")
        fi
        echo "${exclude_patterns[@]}"
    }

    # Generate exclude options for rsync
    generate_rsync_excludes() {
        local patterns=("$@")
        local rsync_excludes=""
        for pattern in "${patterns[@]}"; do
            rsync_excludes+=" --exclude='$pattern'"
        done
        echo "$rsync_excludes"
    }

    # Generate exclude options for tar
    generate_tar_excludes() {
        local patterns=("$@")
        local tar_excludes=""
        for pattern in "${patterns[@]}"; do
            tar_excludes+=" --exclude='$pattern'"
        done
        echo "$tar_excludes"
    }

    # Process exclude patterns
    local exclude_patterns=($(process_exclude_patterns))

    if $compress; then
        local src_basename=$(basename "$src")
        temp_dir=$(mktemp -d)
        tarfile="$temp_dir/${src_basename}.tar.gz"
        
        echo_color $YELLOW "Compressing $src..."
        local tar_command="tar czf '$tarfile' -C '$(dirname "$src")' '$src_basename' $(generate_tar_excludes "${exclude_patterns[@]}")"
        if ! eval $tar_command; then
            echo_color $RED "Compression failed."
            rm -rf "$temp_dir"
            return 1
        fi
        src="$tarfile"
    fi

    local transfer_cmd=""
    local transfer_opts=""

    if $use_scp; then
        transfer_cmd="scp"
        transfer_opts="-r"
        $compress && transfer_opts+=" -C"
        [ -n "$port" ] && transfer_opts+=" -P $port"
        [ -n "$identity" ] && transfer_opts+=" -i $identity"

        if [[ "$dest" != *:* && -n "$user" ]]; then
            dest="${user}@${dest}"
        fi

        # For SCP, we need to filter files before transfer
        if [ -n "$exclude_file" ] && ! $compress; then
            local temp_src=$(mktemp -d)
            rsync -a $(generate_rsync_excludes "${exclude_patterns[@]}") "$src/" "$temp_src/"
            src="$temp_src"
        fi
    else
        transfer_cmd="rsync"
        transfer_opts="-avh --progress"
        [ -n "$port" ] && transfer_opts+=" -e 'ssh -p $port'"
        [ -n "$identity" ] && transfer_opts+=" -e 'ssh -i $identity'"
        [ -n "$limit" ] && transfer_opts+=" --bwlimit=$limit"
        transfer_opts+=" $(generate_rsync_excludes "${exclude_patterns[@]}")"
        $move && transfer_opts+=" --remove-source-files"
    fi

    $verbose && echo_color $YELLOW "Command: $transfer_cmd $transfer_opts $src $dest"

    echo_color $GREEN "Transferring $src to $dest..."
    if ! eval $transfer_cmd $transfer_opts \"$src/\" \"$dest\"; then
        echo_color $RED "Transfer failed."
        $compress && rm -rf "$temp_dir"
        $use_scp && [ -n "$exclude_file" ] && ! $compress && rm -rf "$temp_src"
        return 1
    fi

    if $compress; then
        echo_color $YELLOW "Extracting archive at destination..."
        if [[ "$dest" == *:* ]]; then
            # Remote destination
            local remote_host="${dest%%:*}"
            local remote_path="${dest#*:}"
            if ! ssh $remote_host "cd '$remote_path' && tar -xzf '$(basename "$tarfile")' && rm -f '$(basename "$tarfile")'"; then
                echo_color $RED "Remote extraction failed."
                rm -rf "$temp_dir"
                return 1
            fi
        else
            # Local destination
            if ! tar -xzf "$tarfile" -C "$dest"; then
                echo_color $RED "Local extraction failed."
                rm -rf "$temp_dir"
                return 1
            fi
            rm -f "$tarfile"
        fi
        rm -rf "$temp_dir"
    fi

    if $move && ! $use_scp; then
        echo_color $YELLOW "Cleaning up source..."
        if [ -d "$1" ]; then
            rm -rf "$1"
        else
            rm -f "$1"
        fi
    fi

    $use_scp && [ -n "$exclude_file" ] && ! $compress && rm -rf "$temp_src"

    echo_color $GREEN "Operation completed successfully."
}


#Enchanced du
duu() {
    local usage="Usage: duu [OPTIONS] [DIRECTORY]"
    local max_depth=1
    local sort_order="nr"
    local target_dir="."

    # Color definitions
    local -r BLUE=$'\033[0;34m'
    local -r GREEN=$'\033[0;32m'
    local -r YELLOW=$'\033[0;33m'
    local -r CYAN=$'\033[0;36m'
    local -r MAGENTA=$'\033[0;35m'
    local -r WHITE=$'\033[1;37m'
    local -r BOLD=$'\033[1m'
    local -r RESET=$'\033[0m'
    local -r BG_BLACK=$'\033[40m'

    show_help() {
        cat << EOF
${BOLD}${WHITE}Disk Usage Utility (duu)${RESET}

${WHITE}Description:${RESET}
  duu is a colorful and informative disk usage analysis tool.

${WHITE}Syntax:${RESET}
  duu [OPTIONS] [DIRECTORY]

${WHITE}Options:${RESET}
  -d, --max-depth DEPTH   Maximum depth to traverse (default: 1)
  -r, --reverse           Sort in reverse order (smallest first)
  -h, --help              Show this help message
  -?                      Show this help message

${WHITE}Examples:${RESET}
  duu                     Show disk usage of current directory
  duu /path/to/directory  Show disk usage of specified directory
  duu -d 2 /home          Show disk usage with max depth of 2 in /home
  duu --reverse           Show disk usage sorted from smallest to largest

EOF
    }

    # Manual option parsing
    while (( "$#" )); do
        case "$1" in
            -d|--max-depth)
                if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
                    max_depth=$2
                    shift 2
                else
                    echo "Error: Argument for $1 is missing" >&2
                    return 1
                fi
                ;;
            -r|--reverse)
                sort_order="n"
                shift
                ;;
            -h|--help|-\?)
                show_help
                return 0
                ;;
            -*) # unsupported flags
                echo "Error: Unsupported flag $1" >&2
                return 1
                ;;
            *) # preserve positional arguments
                target_dir="$1"
                shift
                ;;
        esac
    done

    # Validate target directory
    if [ ! -d "$target_dir" ]; then
        echo "Error: '$target_dir' is not a valid directory" >&2
        return 1
    fi

    du -k --max-depth="$max_depth" "$target_dir" 2>/dev/null | sort -"$sort_order" | awk -v blue="$BLUE" -v green="$GREEN" -v yellow="$YELLOW" -v cyan="$CYAN" -v magenta="$MAGENTA" -v bold="$BOLD" -v white="$WHITE" -v reset="$RESET" -v bg_black="$BG_BLACK" '
    function human_readable(size) {
        units="KMGT"
        for (u=1; size >= 1024 && u < 4; u++) {
            size /= 1024
        }
        return sprintf("%.2f %s", size, substr(units, u, 1))
    }
    function get_color(unit) {
        if (unit == "K") return green
        if (unit == "M") return yellow
        if (unit == "G") return cyan
        if (unit == "T") return magenta
        return blue
    }
    function bar_chart(percentage, width) {
        filled = int(percentage * width / 100)
        empty = width - filled
        bar = ""
        for (i = 0; i < filled; i++) bar = bar "█"
        for (i = 0; i < empty; i++) bar = bar "░"
        return bar
    }
    BEGIN {
        print "\n" bold white bg_black "  Disk Usage Summary  " reset
        print bold white "Size       Unit   Usage    Path" reset
        print white "---------- ------ --------- --------------------" reset
    }
    {
        if (NR == 1) {
            total = $1
        } else if ($2 != ".") {  # Skip the '.' directory
            size = human_readable($1)
            split(size, arr, " ")
            color = get_color(arr[2])
            percentage = $1 / total * 100
            bar = bar_chart(percentage, 9)
            printf "%s%10s %s%-6s%s %s%-9s%s %s\n", color, arr[1], bold, arr[2], reset, color, bar, reset, $2
        }
    }
    END {
        total_hr = human_readable(total)
        split(total_hr, arr, " ")
        color = get_color(arr[2])
        print white "----------------------------------------" reset
        printf "%s%sTotal: %s%10s %-6s%s\n", bold, white, color, arr[1], arr[2], reset
    }
    '
}



#swap two files or dirs
swapf() {
    local usage="Usage: swapf [OPTION] <file1> <file2>"
    local BLUE=$'\033[0;34m'
    local RED=$'\033[0;31m'
    local GREEN=$'\033[0;32m'
    local YELLOW=$'\033[0;33m'
    local RESET=$'\033[0m'

    echo_color() {
        local color=$1
        shift
        echo -e "${color}$@${RESET}"
    }

    show_help() {
        cat << EOF
${YELLOW}Swap Files (swapf) Utility${RESET}

${BLUE}Description:${RESET}
  swapf is a utility to safely swap the contents of two files or directories.

${BLUE}Syntax:${RESET}
  swapf [OPTION] <file1> <file2>

${BLUE}Options:${RESET}
  -h, --help    Display this help message
  -?            Display this help message

${BLUE}Arguments:${RESET}
  <file1>       First file or directory to swap
  <file2>       Second file or directory to swap

${BLUE}Examples:${RESET}
  swapf file1.txt file2.txt    Swap contents of file1.txt and file2.txt
  swapf dir1 dir2              Swap contents of dir1 and dir2

${BLUE}Note:${RESET}
  - Both files/directories must exist.
  - You cannot swap a file with a directory.
EOF
    }

    # Check for help options
    if [[ "$1" == "-h" || "$1" == "--help" || "$1" == "-?" ]]; then
        show_help
        return 0
    fi

    if [ $# -ne 2 ]; then
        echo_color "$RED" "Error: Incorrect number of arguments" >&2
        echo_color "$BLUE" "$usage" >&2
        return 1
    fi

    if [ ! -e "$1" ]; then
        echo_color "$RED" "Error: '$1' does not exist" >&2
        return 1
    fi

    if [ ! -e "$2" ]; then
        echo_color "$RED" "Error: '$2' does not exist" >&2
        return 1
    fi

    if [ -d "$1" ] && [ ! -d "$2" ]; then
        echo_color "$RED" "Error: Cannot swap a directory with a non-directory" >&2
        return 1
    fi

    if [ ! -d "$1" ] && [ -d "$2" ]; then
        echo_color "$RED" "Error: Cannot swap a non-directory with a directory" >&2
        return 1
    fi

    local tmp=$(mktemp -d)
    if [ ! -d "$tmp" ]; then
        echo_color "$RED" "Error: Failed to create temporary directory" >&2
        return 1
    fi

    # Use cp instead of mv for the first operation to preserve the original in case of failure
    if ! cp -a "$1" "$tmp/"; then
        echo_color "$RED" "Error: Failed to copy '$1' to temporary location" >&2
        rm -rf "$tmp"
        return 1
    fi

    if ! mv "$2" "$1"; then
        echo_color "$RED" "Error: Failed to move '$2' to '$1'" >&2
        rm -rf "$tmp"
        return 1
    fi

    if ! mv "$tmp"/* "$2"; then
        echo_color "$RED" "Error: Failed to move temporary file to '$2'" >&2
        # Try to revert the changes
        mv "$1" "$2"
        mv "$tmp"/* "$1"
        rm -rf "$tmp"
        return 1
    fi

    rm -rf "$tmp"
    echo_color "$GREEN" "Successfully swapped '$1' and '$2'"
}


# Function to create and initialize a script if it doesn't already exist
evi() {
    [ $# -eq 0 ] && { echo "Usage: evi <filename>" >&2; return 1; }
    local file="$1"
    if [ ! -f "$file" ]; then
        case "$file" in
            *.sh)  echo '#!/usr/bin/env bash' > "$file" ;;
            *.py)  echo '#!/usr/bin/env python' > "$file" ;;
            *)     echo "Unsupported file type" >&2; return 1 ;;
        esac
        chmod +x "$file"
    fi
    vim +"normal Go" +startinsert "$file"
}

# Top 20 memory-consuming processes
topm() {
    echo -e "${WHITE}Top 20 memory-consuming processes${RESET}"
    echo -e "${CYAN}MEM(MB) ${WHITE}PID ${GREEN}USER ${BLUE}COMMAND${RESET}"
    ps -eo rss,pid,user,cmd --sort=-rss | head -n 21 | awk 'NR>1 {printf "'"${CYAN}"'%-10.1f '"${WHITE}"'%-8s '"${GREEN}"'%-12s '"${BLUE}"'%s'"${RESET}"'\n", $1/1024, $2, $3, $4}'
}

# Top 20 CPU-consuming processes
topc() {
    echo -e "${WHITE}Top 20 CPU-consuming processes${RESET}"
    echo -e "${CYAN}CPU(%) ${WHITE}PID ${GREEN}USER ${BLUE}COMMAND${RESET}"
    ps -eo pcpu,pid,user,cmd --sort=-pcpu | head -n 21 | awk 'NR>1 {printf "'"${CYAN}"'%-7.1f '"${WHITE}"'%-8s '"${GREEN}"'%-12s '"${BLUE}"'%s'"${RESET}"'\n", $1, $2, $3, $4}'
}
