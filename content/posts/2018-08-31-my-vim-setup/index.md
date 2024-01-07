---
title: "My VIM Setup"
date: "2018-08-31"
categories: 
  - "dev"
---

This will be my first post in English, I give up - after so many year,me  having doubts about my English is going to get any better so I hope you understand me at least.

#### Why ?

I am using VIM as my main editor for php and javascript for more than a year already.

What I learned is that I really like this minimalist approach - building your own "IDE" step by step, including only the things you need. If you prefer full IDE - please go with Intellij (the best I have used in this class), but if you are going to use Sublime Text or VSCode or Atom or whatever, there is no reason not to use VIM instead.

Then once I got used to all the keybindings and I adjusted them a bit to fit my workflow I got hooked. Now I can barely work with "normal" text editor. I spent some time to learn touchtyping and now I am getting really irritated when my fingers have to move out of the home row of the keyboard. VIM helps a ton with this. I even added a plugin for Firefox called [vimium](https://github.com/philc/vimium) so I can control my browser with vim key bindings (its not ideal, but its something)

#### Train yourself

You really need to teach yourself out of the habit of using arrow keys. In my experience this wont happen until you just disable the arrow keys. Just put this in your .vimrc

" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

 

#### Plugin manager

First we are going to start with the plugin manager. I prefer using [Vundle](https://github.com/VundleVim/Vundle.vim), one you set it up it is really easy to work with. You have other options like Pathogen or vim-plug. It doesn't matter so much which one you choose, just pick one.

#### Plugins

I am going to share with you just the essentials.

[vim-javascript](https://github.com/pangloss/vim-javascript) adds better syntax highlighting, but if you are writing code for nodejs

[vim-node](https://github.com/moll/vim-node) will give you better support for "gf" (go to file) and "gd" (go to definition), etc.

[php-vim](https://github.com/StanAngeloff/php.vim) will get you started with PHP

[YouCompleteMe](https://github.com/Valloric/YouCompleteMe) will give you great autocompletion.

[NERDTree](https://github.com/scrooloose/nerdtree) will give you the file browsing capabilities that you need. At first I was using it in separate window left of window where I edit code in more classic IDE fashion, but soon I realized that I don't really need to stay there all the time. Now I use it only when I want to open new file. Pay attention that this plugin is way more powerful than it initially seems. You can create new files/folders with "ma" or delete them with "md". Just open nerdtree by either typing "NERDTree" or just ":e ." and hit "?" to see the full list of options.

[BufExplorer](https://github.com/jlanzarotta/bufexplorer) gives you a list of all open buffers so you can easily navigate between them. I have mapped it to `<leader>w` so I can easily see everything when I have a lot of files opened.

[WinTabs](https://github.com/zefei/vim-wintabs) is an excellent plugin that will represent all the open files as tabs that you can easily switch between. Your right hand is sitting on keys J - ; and your left on A-F. VIM already usese HJKL for navigation, so it came natural to me to map \`:WintabsNext\` to `<leader>f` and `:WintabsPrevious` to \`<leader>a\`.

[ALE](https://github.com/w0rp/ale) or Asynchronous Lint Engine is amazing plugin that lets you integrate linter like eslint or php-cs-fixer with VIM. You get all the best features from the linters that you choose plus automatically fixing your code when you have. No more unformatted code, no more mixed tabs and spaces, no need to come up with excuses why you have used double instead of single quotes.

[ack.vim](https://github.com/mileszs/ack.vim) is a plugin that lets you search for text in your project's files. I personally chose to configure it to work with [the\_silver\_searcher](https://github.com/ggreer/the_silver_searcher) which is much faster. Just type something like \`Ack @todo\` and you will get a list of all files that contain this string.

Ctags is the way to navigate inside your code and there are several options that you can choose from, but I really like [vim-gutentags](https://github.com/ludovicchabant/vim-gutentags). It kind of just works. Just install ctags then the plugin and you are done. I find this one most useful for PHP.

[phpactor](https://github.com/phpactor/phpactor) is where it gets serious. It gives you very nice features like automatically adding "use Whatever/Class/You/Need". You can see where is your class used, it adds code navigation, jump to definition, refatoring functions, etc. I basically can't write PHP without this plugin.

 

#### Bonus Tips

One of the best things that I have done is remapping my <leader> key to space

let mapleader=" "

The default leader key is "\\", but this just adds too much stress to my right pinky finger and after a while it just hurts. Thumbs are much tougher. Moving to my tab to the right is <space>f, to the left <space>a. It made everything so much easier for me.

 

I hope I was being helpful. Explore and experiment. I will try to add my dotfiles soon.
