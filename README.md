# dotfiles

My personal Linux and macOS configurations and settings


## Installation

:warning: **Warning:** Installing my dotfiles will overwrite your old dotfiles. If you have any dotfiles in your home directory, back them up before doing anything else. That way you can revert to your old settings if you want to.


### Using Git and the bootstrap script

You can clone the repository wherever you want by running:

```bash
git clone https://github.com/Div99/dotfiles
```

Then, all you have to do is source the bootstrap script:

```bash
source dotfiles/bootstrap.sh
```

To update your local repository with any changes I've made, just source the bootstrap script again.

## Configuration

### Using Vim with Tmux

Mouse scrolling is enabled by default.

For Mac:
- Select text with `fn` key pressed to do normal copy with `Cmd` + c.
  (Alternatively select text with `fn` + `Cmd` pressed if this doesn't work)
- For copying a block of text with vertical tmux split, select text with
  `fn` + `alt` pressed to select a rectangular block.
- Paste should be working as normal. (Auto-indent is turned off for the pasted text
  using [vim-bracketed-paste](https://github.com/ConradIrwin/vim-bracketed-paste))
