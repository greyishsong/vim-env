#!/bin/bash

DEVSTACK_HOME="/opt/stack"

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
mkdir -p $DEVSTACK_HOME/.vim/autoload
cp plug.vim $DEVSTACK_HOME/.vim/autoload
if [ ! -f $DEVSTACK_HOME/.vimrc ]; then
    touch $DEVSTACK_HOME/.vimrc
fi
cat config/plugins.vimrc > $DEVSTACK_HOME/.vimrc
echo "Done."

# install powerline fonts
echo "[info]Install powerline fonts..."
apt install -y fonts-powerline
apt install -y fontconfig
mkdir -p $DEVSTACK_HOME/.config/fontconfig/conf.d
cp 50-enable-terminess-powerline.conf $DEVSTACK_HOME/.config/fontconfig/conf.d
fc-cache -vf
echo "let g:airline_powerline_fonts = 1" >> $DEVSTACK_HOME/.vimrc
echo "Done."

# install plugins
echo "[info]Install plugins of vim..."
vim -c "PlugInstall" -c "qa!"
if [ "$(ls $DEVSTACK_HOME/.vim/plugged)" = "" ]; then
    echo "[error]Fail to install plugins for vim, please check your Internet environment."
    exit 1
fi
echo "Done."

# configure plugins
echo "[info]join configurations of plugins into vimrc..."
cat config/custom.vimrc >> $DEVSTACK_HOME/.vimrc
cat config/nerdtree.vimrc >> $DEVSTACK_HOME/.vimrc
cat config/coc.vimrc >> $DEVSTACK_HOME/.vimrc
cp config/coc-settings.json $DEVSTACK_HOME/.vim
echo "Done."
