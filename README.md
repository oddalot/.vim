These instructions were modified from http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/

<h3>Installation:</h3>

    git clone git://github.com/oddalot/.vim.git ~/.vim

Create symlink:

    ln -s ~/.vim/vimrc ~/.vimrc

If using tmux create that symlink:

    ln -s ~/.vim/tmux.conf ~/.tmux.conf

Switch to the `~/.vim` directory, and fetch submodules:

    cd ~/.vim
    git submodule init
    git submodule update

<hr>

<h4>Upgrading a plugin bundle</h4>

At some point in the future, the fugitive plugin might be updated. To fetch the latest changes, go into the fugitive repository, and pull the latest version:

    cd ~/.vim/bundle/vim-fugitive
    git pull origin master

Upgrading all bundled plugins

You can use the foreach command to execute any shell script in from the root of all submodule directories. To update to the latest version of each plugin bundle, run the following:

    git submodule foreach git pull origin master

<h4>Removing a plugin bundle</h4>

These steps seem to work for removing a submodule from the repository:

1.) remove the entries in .gitmodules

2.) remove the entries in .git/config

3.) Run the following command:

    git rm --cached bundle/sumodulename
