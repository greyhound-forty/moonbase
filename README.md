# moonbase
My default home environment for new servers

###Setup includes:  
1. [Prezto](https://github.com/sorin-ionescu/prezto) as the wrapper around zsh  
2. Default bin directory with tools like [ngrok](https://ngrok.com/), [todo.sh](http://todotxt.com/), [jq](https://stedolan.github.io/jq/), and [dropbox cli](http://www.dropboxwiki.com/tips-and-tricks/using-the-official-dropbox-command-line-interface-cli)  
3. **Work in progress** My shell cleaner/dotfile organizer  


### Installation  

1. To setup a new shell make sure that git, zsh, keychain, and tmux are installed.

        [apt-get/yum] update && [apt-get/yum/ install git zsh tmux keychain -y

2. Clone the repository:

        git clone https://github.com/greyhound-forty/moonbase.git "${MOONBASE:-$HOME}/.moonbase

3. Start a zsh session (just type in zsh) and then create your new Zsh configuration by copying the configuration files:

        setopt EXTENDED_GLOB
	for cfgfile in "${MOONBASE:-$HOME}/.moonbase/runcoms/^README.md(.N); do        
	    ln -s "$cfgfile" "${MOONBASE:-$HOME}/.${cfgfile:t}"
        done

4. Set Zsh as your default shell:

        chsh -s /bin/zsh

5. Open a new Zsh terminal window or tab.

