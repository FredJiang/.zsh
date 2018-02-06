#! /bin/bash

# PS1='[$USER@$HOSTNAME %c]$ '

function echoCo {
    echo -e "\033[32m$@\033[0m"
}


function echoMe {
    echo -e "\033[35m$@\033[0m"
}


function echoEr {
    echo -e "\033[31m$@\033[0m"
}


case "$OSTYPE" in
  solaris*)
    echoMe "SOLARIS"
    ;;
  darwin*)
    echoMe "OSX"
    ;; 
  linux*)
    echoMe "LINUX"
    ;;
  bsd*) 
    echoMe "BSD"
    ;;
  msys*) 
    echoMe "WINDOWS"
     ;;
  *)
    echoMe "unknown: $OSTYPE"
    ;;
esac


# echoCo 'git pull'
#         git pull


# echoCo 'git submodule init'
#         git submodule init


# echoCo 'git submodule update'
#         git submodule update


function install_zsh {
    if which zsh > /dev/null; then
        echoMe 'zsh has installed'
    else
        if which apt-get > /dev/null; then
            echoCo 'sudo apt-get install -y zsh'
                    sudo apt-get install -y zsh
        fi

        if which yum > /dev/null; then
            echoCo 'sudo yum install -y zsh'
                    sudo yum install -y zsh
        fi

        if which brew > /dev/null; then
            echoCo 'brew install zsh zsh-completions'
                    brew install zsh zsh-completions
        fi
    fi

    if [ $SHELL == '/bin/zsh' ] || [ $SHELL == '/usr/bin/zsh' ]; then
        echoMe '$SHELL' $SHELL
    else
        echoCo 'chsh -s $(which zsh)'
                chsh -s $(which zsh)

        echoCo 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'
                sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

        echoCo 'source ~/.zshrc'
                source ~/.zshrc
    fi
}


install_zsh


function install_pip {
    if which pip > /dev/null; then
        echoMe 'pip has installed'
    else
        if which apt-get > /dev/null; then
            echoCo 'sudo apt-get install -y python-setuptools python-dev build-essential'
                    sudo apt-get install -y python-setuptools python-dev build-essential

            echoCo 'sudo easy_install pip'
                    sudo easy_install pip
        fi

        # if which yum > /dev/null; then
        # fi

        # if which brew > /dev/null; then
        # fi
    fi
}


install_pip


function install_powerline {
    if which powerline > /dev/null; then
        echoMe 'powerline has installed'
    else
        # echoCo 'pip install powerline-status'
        #         pip install powerline-status

        echoCo 'sudo -H bash -c "$(which pip) install powerline-status"'
                sudo -H bash -c "$(which pip) install powerline-status"
        
        # echoCo 'sudo -H bash -c "$(which pip) uninstall powerline-status"'
        #         sudo -H bash -c "$(which pip) uninstall powerline-status"
    fi
}


install_powerline


function install_autojump {
    if which autojump > /dev/null; then
        echoMe 'autojump has installed'
    else
        echoCo 'cd ~/.zsh/mypackages/autojump'
                cd ~/.zsh/mypackages/autojump
        echoCo './install.py'
                ./install.py
    fi
}


install_autojump


if [ -e ~/.zshrc ]; then
    echoCo      "cat ~/.zshrc | grep '^source ~/.zsh/.zshrcf'"
    grepResult=$(cat ~/.zshrc | grep '^source ~/.zsh/.zshrcf')
    echo $grepResult

    if [ ${#grepResult} == 0 ]; then
        echoCo "echo 'source ~/.zsh/.zshrcf' >> ~/.zshrc"
                echo 'source ~/.zsh/.zshrcf' >> ~/.zshrc
        echoCo "/bin/zsh -c 'source ~/.zshrc'"
                /bin/zsh -c 'source ~/.zshrc'
    fi

    echoCo "cat ~/.zshrc | grep '^source ~/.zsh/.zshrcf'"
            cat ~/.zshrc | grep '^source ~/.zsh/.zshrcf'
fi
