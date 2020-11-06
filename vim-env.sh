#!/bin/bash

USER_HOME=$(python3 get-config.py default homepath)
if [ $USER_HOME = ""]; then
    echo "[error]Value \"homepath\" in local.conf is required to run script"
    exit 1
fi

# install vim 8.0+ and exuberant-ctags
echo "[info]Install vim..."
apt install -y vim vim-gtk
echo "Done."
echo "[info]Install ctags for taglist plugin..."
apt install -y exuberant-ctags
echo "Done."

# install node.js for coc.nvim
echo "[info]Install node.js for coc.nvim..."
if [ "$(node -v)" = "" ]; then
    curl -sL install-node.now.sh/lts | bash
    npm install -g nrm --registry=https://registry.npm.taobao.org
    nrm use taobao
fi
echo "Done."

# install vim-plug for plug management
echo "[info]Install vim-plug..."
mkdir -p $USER_HOME/.vim/autoload
cp resource/plug.vim $USER_HOME/.vim/autoload
if [ ! -f $USER_HOME/.vimrc ]; then
    touch $USER_HOME/.vimrc
fi
cat config/plugins.vimrc > $USER_HOME/.vimrc
echo "Done."

# install powerline fonts
echo "[info]Install powerline fonts..."
apt install -y fonts-powerline
echo "Done."

# install plugins
echo "[info]Install plugins of vim..."
vim -c "PlugInstall" -c "qa!"
vim -c "CocInstall coc-json coc-jedi coc-sh" -c "qa!"
if [ "$(ls $USER_HOME/.vim/plugged)" = "" ]; then
    echo "[error]Fail to install plugins for vim, there may be some errors with the Internet environment or file authority."
    exit 1
fi
echo "Done."

# configure plugins
echo "[info]join configurations of plugins into vimrc..."
cat config/custom.vimrc >> $USER_HOME/.vimrc
cat config/nerdtree.vimrc >> $USER_HOME/.vimrc
cat config/coc.vimrc >> $USER_HOME/.vimrc
cp config/coc-settings.json $USER_HOME/.vim
echo "Done."
