#!/bin/bash

set -e

initLocation=$(pwd)
PLUG=~/.zsh/plugins
SOURCE=~/source/git
CONFIG=~/.config

sudo apt-get update
sudo apt-get install unzip zsh exuberant-ctags clangd-14 -y
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-14 100

chsh -s /usr/bin/zsh

mkdir -p ~/Downloads

cd ~/Downloads

NODE_VERSION='v22.11.0'

wget https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz
tar -xf node-${NODE_VERSION}-linux-x64.tar.xz

sudo cp -r node-${NODE_VERSION}-linux-x64/* /usr/
rm -rf $PLUG

mkdir -p $SOURCE
mkdir -p $PLUG
cd $PLUG

plugins="zsh-users/zsh-autosuggestions zsh-users/zsh-completions zsh-users/zsh-syntax-highlighting eendroroy/alien"

for plugin in $plugins; do
    git clone "https://github.com/$plugin";
done

cd $PLUG/alien/libs

git clone https://github.com/eendroroy/promptlib-zsh.git promptlib
git clone https://github.com/chrissicool/zsh-256color.git
git clone https://github.com/mafredri/zsh-async.git

cd $initLocation

cp ./files/.zshrc ~/.zshrc

rm -rf ~/Downloads/node*

git config --global user.name "rcoones"
git config --global user.email "robert_coones@zohomail.com"
git config --global core.editor code