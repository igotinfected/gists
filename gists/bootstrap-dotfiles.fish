#!/usr/bin/env fish

# retrieve dotfiles
echo "==> ⬇️  downloading dotfiles..."
git clone --bare https://github.com/igotinfected/dotfiles $HOME/.dotfiles

# force restore dotfiles (i.e. overwrite tracked files if they already exist)
echo "==> ⚙️  setting up dotfiles..."
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" checkout -f

# force ignore all untracked files
echo "==> 🙈 ignoring all untracked files..."
git --git-dir="$DOTFILES_FOLDER" --work-tree="$HOME" config --local status.showUntrackedFiles no

echo "==> ✅ done! Start a new shell or run `fish_source` to refresh your shell!"
