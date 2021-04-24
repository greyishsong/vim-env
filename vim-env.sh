#!/bin/bash

if [ $HOME = ""]; then
    echo "[error]Could not get \"home\" directory for current user, check the HOME environment variable"
    exit 1
fi

# install vim 8.0+ and universal-ctags
echo "[info]Install vim..."
sudo apt install -y vim vim-gtk
echo "Done."
echo "[info]Install ctags..."
sudo apt install -y universal-ctags
echo "Done."

# install node.js for coc.nvim
echo "[info]Install node.js for coc.nvim..."
if [ "$(node -v)" = "" ]; then
    chmod u+x resource/lts
    ./resource/lts
    sudo npm install -g nrm --registry=https://registry.npm.taobao.org
    nrm use taobao
fi
echo "Done."

# install vim-plug for plug management
echo "[info]Install vim-plug..."
mkdir -p $HOME/.vim/autoload
cp resource/plug.vim $HOME/.vim/autoload
if [ ! -f $HOME/.vimrc ]; then
    touch $HOME/.vimrc
fi
cat config/plugins.vimrc > $HOME/.vimrc
echo "Done."

# install powerline fonts
echo "[info]Install powerline fonts..."
sudo apt install -y fonts-powerline
echo "Done."

# install plugins
echo "[info]Install plugins of vim..."
vim -c "PlugInstall" -c "qa!"
vim -c "CocInstall coc-json coc-sh coc-snippets" -c "qa!"
if [ "$(ls $HOME/.vim/plugged)" = "" ]; then
    echo "[error]Fail to install plugins for vim, there may be some errors with the Internet environment or file authority."
    exit 1
fi
echo "Done."

# merge vimrc configuration file
echo "[info]join configurations of plugins into vimrc..."
for conf in $(ls config | grep vimrc)
do
    if [ $conf != "plugins.vimrc" ]
    then
        cat config/$conf >> $HOME/.vimrc
    fi
done
echo "Done."

# copy custom snippets
echo "[info]copy custom snippets..."
if [ ! -f $HOME/.config/coc/ultisnips ]
then
    mkdir -p $HOME/.config/coc/ultisnips
fi
for snippet in $(ls resource/ultisnips)
do
    cp resource/snippet $HOME/.config/coc/ultisnips
done
echo "Done."

echo "Finished."
