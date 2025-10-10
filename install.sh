#!/usr/bin/env bash
set -e  # 出错即退出

echo "🚀 开始安装 Oh My Zsh 环境..."

# ==============================
# 1. 检查并安装 zsh
# ==============================
if ! command -v zsh >/dev/null 2>&1; then
  echo "🔧 未检测到 zsh，正在安装..."
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    sudo apt update && sudo apt install -y zsh
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install zsh
  else
    echo "❌ 不支持的系统类型：$OSTYPE"
    exit 1
  fi
else
  echo "✅ 已检测到 zsh"
fi

# ==============================
# 2. 安装 Oh My Zsh（若未安装）
# ==============================
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "📦 安装 Oh My Zsh..."
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "✅ Oh My Zsh 已存在"
fi

# ==============================
# 3. 安装 Powerlevel10k 主题
# ==============================
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo "🎨 安装 Powerlevel10k 主题..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "$ZSH_CUSTOM/themes/powerlevel10k"
else
  echo "✅ Powerlevel10k 已存在"
fi

# ==============================
# 4. 安装常用插件（可选）
# ==============================
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "✨ 安装 zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "💡 安装 zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# ==============================
# 5. 建立配置文件软链接
# ==============================
echo "🔗 创建配置文件链接..."
ln -sf ~/.config/zsh/.p10k.zsh ~/.p10k.zsh

# ==============================
# 6. 设置默认 shell
# ==============================
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "⚙️  设置 zsh 为默认 shell..."
  chsh -s "$(which zsh)"
fi

echo "🎉 安装完成！请重新打开终端或运行："
echo "    exec zsh"

