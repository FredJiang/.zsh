#! /bin/bash

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
            echo 'pip install powerline-status'
            pip install powerline-status
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

echo 'cp ~/.zsh/.zshrcFred ~/'
cp ~/.zsh/.zshrcFred ~/


if [ -e ~/.zshrc ]
then
    grepResult=$(cat ~/.zshrc | grep '^source ~/.zshrcFred')
    echo ~/.zshrc $grepResult
    if [ ${#grepResult} == 0 ]
    then
        echo 'source ~/.zshrcFred'     >> ~/.zshrc
        /bin/zsh -c 'source ~/.zshrc'
    fi

    echo $'cat ~/.zshrc | grep \'^source ~/.zshrcFred\''
    cat ~/.zshrc | grep '^source ~/.zshrcFred'
fi



