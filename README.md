# Pre-install tasks on Silverblue

- Change to zsh `sudo usermod --shell /usr/bin/zsh mcritchlow`
- Install [starship][starship] to `~/.local/bin`
- Install JetBrainsMono Nerd Font `~.local/share/fonts`

```sh
mkdir -p ~/.local/share/fonts
curl -L https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz | tar Jxf - -C ~/.local/share/fonts/
```

[starship]:https://starship.rs/faq/#how-do-i-install-starship-without-sudo

# Installation

To be safe initially, probably run stow on the individual directories.

Note: this does a clone using `https`, switch to `ssh` once keys are setup.

```sh
$ git clone https://github.com/mcritchlow/dotfiles-stow.git
$ cd dotfiles-stow
$ stow zsh
$ show ssh
$ ...
```

See:
- https://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html
- https://www.gnu.org/software/stow/manual/html_node/Invoking-Stow.html


