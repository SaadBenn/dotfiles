# User configuration.
#
# This file should contain the product-specific configuration.
# For example, one may overwrite default global configuration
# values such as ROOT_ONLY.
# Plus, one should define the three greeter functions 'welcome',
# 'installation_complete', and 'installation_incomplete'.

# Set to 1 to enforce root installations.
#ROOT_ONLY=0

# Overwrite to disable the initial touch-all-files.
#INITIAL_TOUCH_ALL=1

# Overwrite to disable task dependency checking.
#TASK_DEPENDENCY_CHECKING=1

# Overwrite default utils & tasks directories.
#UTILS_DIR=${INSTALLER_PATH}/data/utils
#TASKS_DIR=${INSTALLER_PATH}/data/tasks

# Overwrite default log-to-stdout config.
#LOG_STDOUT=( "ERROR" "IMPORTANT" "WARNING" "INFO" "SKIP" "START" "FINISH" )

DOTFILES_ROOT=$(pwd)

function welcome() {
    echo -e "\e[00;32mWelcome to the new and shiny installer framework!\e[00m"
}

function installation_complete() {
    echo -e "\e[00;32mMove along now, there's nothing else you can do!\e[00m"

    # If you want the install script to terminate automatically:
    #exit 0
}

function installation_incomplete() {
    echo -e "\e[00;31mWhoopsie!\e[00m"
}


function link_file () {
    local src=$1 dst=$2

    local overwrite= backup= skip=
    local action=

    if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
    then

        if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
        then

            local currentSrc="$(readlink $dst)"

            if [ "$currentSrc" == "$src" ]
            then

                skip=true;

            else

                user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
                [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
                read -n 1 action

                case "$action" in
                    o )
                    overwrite=true;;
                    O )
                    overwrite_all=true;;
                    b )
                    backup=true;;
                    B )
                    backup_all=true;;
                    s )
                    skip=true;;
                    S )
                    skip_all=true;;
                    * )
                    ;;
                esac

            fi

        fi

        overwrite=${overwrite:-$overwrite_all}
        backup=${backup:-$backup_all}
        skip=${skip:-$skip_all}

        if [ "$overwrite" == "true" ]
        then
            rm -rf "$dst"
            success "removed $dst"
        fi

        if [ "$backup" == "true" ]
        then
            mv "$dst" "${dst}.backup"
            success "moved $dst to ${dst}.backup"
        fi

        if [ "$skip" == "true" ]
        then
            success "skipped $src"
        fi
    fi

    if [ "$skip" != "true" ]  # "false" or empty
    then
        ln -s "$1" "$2"
        success "linked $1 to $2"
    fi
}
