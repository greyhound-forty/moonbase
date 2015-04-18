# moonbase
My default home environment for new servers

###Setup includes:  
1. [Prezto](https://github.com/sorin-ionescu/prezto) as the wrapper around zsh  
2. Default bin directory with tools like [ngrok](https://ngrok.com/), [todo.sh](http://todotxt.com/), [jq](https://stedolan.github.io/jq/), and [dropbox cli](http://www.dropboxwiki.com/tips-and-tricks/using-the-official-dropbox-command-line-interface-cli)  
3. **Work in progress** My shell cleaner/dotfile organizer  


### Installation  

```
git clone https://github.com/greyhound-forty/moonbase.git "${MOONBASE:-$HOME}/.moonbase
```

```
setopt EXTENDED_GLOB
for cfgfile in "${MOONBASE:-$HOME}/.moonbase/runcoms/^README.md(.N); do
  ln -s "$cfgile" "${MOONBASE:-$HOME}/.${cfgfile:t}"
done
```
