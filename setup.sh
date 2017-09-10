#! /bin/bash

echo 'git pull'
git pull



echo 'git submodule init'
git submodule init



echo 'git submodule update'
git submodule update




function install_zsh {
    if which zsh > /dev/null
    then
        echo 'zsh has installed'
    else
        if which apt-get > /dev/null
        then
            echo 'sudo apt-get install -y zsh'
            sudo apt-get install -y zsh
        fi

        if which yum > /dev/null
        then
            echo 'sudo yum install -y zsh'
            sudo yum install -y zsh
        fi

        if which brew >/dev/null
        then
            echo 'brew install zsh zsh-completions'
            brew install zsh zsh-completions
        fi
    fi

    echo '$SHELL' $SHELL
    if [ $SHELL == '/bin/zsh' ] || [ $SHELL == '/usr/bin/zsh' ]
    then
        echo '$SHELL' $SHELL
    else
        echo 'chsh -s $(which zsh)'
        chsh -s $(which zsh)

        echo 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"'
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

        echo 'source ~/.zshrc'
        source ~/.zshrc
    fi
}


function install_powerline {
    if ! which pip > /dev/null
    then
        echo 'pip has not installed'
    else
        if which powerline > /dev/null
        then
            echo 'powerline has installed'
        else
            # echo 'pip install powerline-status'
            # pip install powerline-status

            echo 'sudo bash -c "$(which pip) install powerline-status"'
            sudo -H bash -c "$(which pip) install powerline-status"
            # sudo -H bash -c "$(which pip) uninstall powerline-status"
        fi
    fi
}



echo 'cd ~/.zsh'
cd ~/.zsh

case "$OSTYPE" in
  solaris*)
    echo "SOLARIS" ;;
  darwin*)
    echo "OSX"
    ;; 
  linux*)
    echo "LINUX"
    ;;
  bsd*) 
      echo "BSD" ;;
  msys*) 
     echo "WINDOWS" ;;
  *)
    echo "unknown: $OSTYPE" ;;
esac

install_zsh

install_powerline

echo 'cp ~/.zsh/.zshrcf ~/'
cp ~/.zsh/.zshrcf ~/


if [ -e ~/.zshrc ]
then
    grepResult=$(cat ~/.zshrc | grep '^source ~/.zshrcf')
    echo ~/.zshrc $grepResult
    if [ ${#grepResult} == 0 ]
    then
        echo 'source ~/.zshrcf'     >> ~/.zshrc
        /bin/zsh -c 'source ~/.zshrc'
    fi

    echo $'cat ~/.zshrc | grep \'^source ~/.zshrcf\''
    cat ~/.zshrc | grep '^source ~/.zshrcf'
fi



