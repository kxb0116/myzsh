```sh
git clone https://github.com/kxb0116/myzsh.git ~/.config/zsh
cd ~/.config/zsh/
./install.sh
```
添加这一段到 `~/.zshrc` 的开头
```sh
if [[ -f $HOME/.config/zsh/.ohmyzsh_config ]]; then
    source $HOME/.config/zsh/.ohmyzsh_config
fi
```