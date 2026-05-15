# macOS Terminal 环境配置

这是一套以 **Ghostty + Zsh + Starship + Vim + Yazi + btop** 为核心的 macOS 终端工作环境配置。

目标是：在拿到一台新的 Mac 后，可以根据本文档，尽可能快速地恢复出一致的终端使用体验。

> 当前仓库默认作为 `~/.config` 使用。

---

## 1. 组件总览

| 组件 | 作用 | 对应配置 |
| --- | --- | --- |
| Ghostty | 终端模拟器，负责窗口、字体、主题、光标、快捷键等 | `ghostty/config` |
| Zsh | Shell，本套环境的命令行入口 | `.zshrc` |
| Starship | Shell Prompt，负责终端提示符样式 | `starship.toml` |
| Maple Mono NF CN | 终端字体，提供中文和 Nerd Font 图标支持 | Ghostty 中引用 |
| Vim | 轻量编辑器，提供基础语法高亮与常用编辑能力 | `.vimrc` |
| Yazi | 终端文件管理器 | `yazi/` |
| btop | 终端系统监控工具 | `btop/btop.conf` |

---

## 2. 新机器初始化流程

建议按下面顺序安装，这样最不容易遗漏。

### 2.1 安装 Homebrew

如果新机器还没有 Homebrew，先执行：

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

安装完成后，按 Homebrew 提示把它加入 shell 环境。

### 2.2 安装基础软件

```bash
brew install git vim starship yazi btop zsh-completions zsh-autosuggestions zsh-syntax-highlighting
brew install --cask ghostty
```

说明：

- macOS 系统自带的 `vim` 也可以使用，并且能支持基础语法高亮；但更推荐通过 Homebrew 安装 `vim`，这样通常能获得更新的版本，以及更好的 `termguicolors` 和终端特性支持
- `zsh-completions`、`zsh-autosuggestions`、`zsh-syntax-highlighting` 都会被 `.zshrc` 直接加载

### 2.3 安装字体

当前终端配置使用的字体是 **Maple Mono NF CN**，Ghostty 配置中已经指定了它。

先添加字体仓库：

```bash
brew tap homebrew/cask-fonts
```

再安装字体：

```bash
brew install --cask font-maple-mono-nf-cn
```

安装完成后，如果 Ghostty 已经打开，建议重启一次 Ghostty。

### 2.4 拉取仓库到 `~/.config`

如果你希望直接复用这套目录结构，推荐把仓库 clone 到 `~/.config`：

```bash
git clone git@github.com:zhichenghou/dot_config.git ~/.config
```

如果你的 `~/.config` 已经有其他内容，建议先备份，再决定是合并还是单独迁移需要的配置。

### 2.5 建立软链接

这一步很关键，因为有些程序的默认配置位置不完全在 `~/.config` 下。

#### Zsh

把仓库里的 `.zshrc` 链接到用户目录：

```bash
ln -sfn ~/.config/.zshrc ~/.zshrc
```

#### Vim

把仓库里的 `.vimrc` 链接到用户目录，这样 Vim 打开时就会加载语法高亮和基础编辑配置：

```bash
ln -sfn ~/.config/.vimrc ~/.vimrc
```

#### Ghostty

Ghostty 默认读取的是 macOS Application Support 下的配置文件，因此建议建立链接：

```bash
mkdir -p ~/Library/Application\ Support/com.mitchellh.ghostty
ln -sfn ~/.config/ghostty/config ~/Library/Application\ Support/com.mitchellh.ghostty/config
```

### 2.6 重新加载 Shell

```bash
source ~/.zshrc
```

然后可以执行下面命令确认 Vim 配置已经生效：

```bash
vim ~/.vimrc
```

或者直接关闭并重新打开终端。

---

## 3. 分组件安装与配置

## 3.1 Ghostty

### 作用

Ghostty 是当前环境使用的终端模拟器，负责：

- 字体和字号
- 主题
- 窗口尺寸和内边距
- 光标样式
- 透明度
- shell integration
- 自定义按键行为

### 安装

```bash
brew install --cask ghostty
```

### 配置文件

- 仓库内配置：`~/.config/ghostty/config`
- Ghostty 实际读取位置：`~/Library/Application Support/com.mitchellh.ghostty/config`

### 当前配置特点

- 字体：`Maple Mono NF CN`
- 主题：`Material Design Colors`
- 开启窗口状态保存
- 使用 block 光标
- 启用 zsh shell integration

如果字体没有生效，优先检查字体是否已安装，以及 Ghostty 配置文件是否已经正确建立软链接。

---

## 3.2 Zsh

### 作用

Zsh 是整个终端环境的 Shell 入口，负责：

- PATH 设置
- 补全系统初始化
- 插件加载
- Starship 初始化
- 常用 alias

### 安装

macOS 默认自带 zsh，一般不需要额外安装。

本配置 **不依赖 Oh My Zsh**。

但需要安装下面这些通过 Homebrew 提供的插件：

```bash
brew install zsh-completions zsh-autosuggestions zsh-syntax-highlighting
```

### 配置文件

- 仓库内配置：`~/.config/.zshrc`
- 实际使用位置：`~/.zshrc`

### 生效方式

```bash
ln -sfn ~/.config/.zshrc ~/.zshrc
source ~/.zshrc
```

### 当前配置特点

- 使用 Homebrew 路径下的补全脚本
- 启用自动建议
- 启用语法高亮
- 自动初始化 Starship
- 提供 `ll='ls -alFG'` 别名

---

## 3.3 Starship

### 作用

Starship 负责终端提示符外观，包括：

- 用户名
- 当前目录
- Git 分支与状态
- 常见语言运行时信息
- Docker / Conda / 时间等信息

### 安装

```bash
brew install starship
```

### 配置文件

- `~/.config/starship.toml`

### 生效方式

Starship 会在 `.zshrc` 中自动初始化，不需要单独配置：

```bash
eval "$(starship init zsh)"
```

### 注意事项

这套提示符用了很多 Nerd Font 图标，所以 **字体必须安装**，否则会出现乱码或图标显示异常。

---

## 3.4 Vim

### 作用

Vim 是当前环境里的轻量编辑器方案，主要提供：

- 基础语法高亮
- 文件类型识别
- 缩进与常用编辑设置
- 搜索高亮与增量搜索
- 与当前终端字体、配色风格保持一致的基础观感

### 安装

```bash
brew install vim
```

> macOS 自带 Vim 也可以直接使用；如果你只是想要基础编辑和语法高亮，可以不额外安装。
> 但如果你希望获得更稳定的真彩色显示、更新的版本和更一致的终端体验，仍然建议优先使用 Homebrew 安装版。

### 配置目录

- 仓库内配置：`~/.config/.vimrc`
- 实际使用位置：`~/.vimrc`

### 生效方式

```bash
ln -sfn ~/.config/.vimrc ~/.vimrc
```

### 首次启动

```bash
vim
```

如果想直接验证当前配置是否被读取，可以执行：

```bash
vim ~/.vimrc
```

### 当前配置说明

- 不依赖任何插件管理器
- 默认开启 `syntax on`
- 默认开启 `filetype plugin indent on`
- 启用行号、搜索高亮、增量搜索、2 空格缩进等基础编辑能力
- 在支持的 Vim 版本下启用 `termguicolors`

如果语法高亮没有生效，优先检查：

1. `vim --version` 是否支持 `+syntax`
2. `~/.vimrc` 是否正确链接到了 `~/.config/.vimrc`
3. 是否通过 `vim` 而不是其他编辑器启动

---

## 3.5 Yazi

### 作用

Yazi 是终端文件管理器，用于快速浏览、进入、筛选和操作文件。

### 安装

```bash
brew install yazi
```

### 配置目录

- `~/.config/yazi/yazi.toml`
- `~/.config/yazi/init.lua`
- `~/.config/yazi/package.toml`

### 当前配置特点

- 文件列表布局比例已调整
- 默认显示隐藏文件
- 启用了 `git.yazi` 插件初始化配置

### 插件说明

仓库内已经包含 `git.yazi` 相关内容；如果在新机器上插件没有正常工作，可以手动执行：

```bash
ya pkg add yazi-rs/plugins:git
```

### 启动方式

```bash
yazi
```

---

## 3.6 btop

### 作用

btop 是终端内的系统监控工具，可查看：

- CPU
- 内存
- 磁盘
- 网络
- 进程列表

### 安装

```bash
brew install btop
```

### 配置文件

- `~/.config/btop/btop.conf`

### 启动方式

```bash
btop
```

---

## 4. 验证环境是否搭建成功

完成安装后，可以逐项检查：

### 检查 Zsh

```bash
echo $SHELL
source ~/.zshrc
```

### 检查 Starship

```bash
starship --version
```

重新打开终端后，应当能看到新的提示符样式。

### 检查 Ghostty

- 打开 Ghostty
- 确认字体为 `Maple Mono NF CN`
- 确认图标没有乱码

### 检查 Vim

```bash
vim --version | head -n 5
vim ~/.vimrc
```

打开后应能看到基础语法高亮与行号。

### 检查 Yazi

```bash
yazi
```

### 检查 btop

```bash
btop
```

---

## 5. 常见问题

### 5.1 Starship 图标乱码

通常是字体没有正确安装，或者终端没有使用 `Maple Mono NF CN`。

建议检查：

1. 是否执行了字体安装命令
2. Ghostty 是否加载了仓库中的配置
3. 是否重启过 Ghostty

### 5.2 `.zshrc` 修改后不生效

执行：

```bash
source ~/.zshrc
```

如果仍不生效，检查 `~/.zshrc` 是否正确链接到了 `~/.config/.zshrc`。

### 5.3 Vim 语法高亮没有生效

优先检查这些内容：

- `vim --version` 输出里是否包含 `+syntax`
- `~/.vimrc` 是否正确链接到 `~/.config/.vimrc`
- 是否使用 `vim` 打开文件
- 终端字体是否已正确安装

### 5.4 Ghostty 配置没有生效

检查这个链接是否存在：

```bash
ls -l ~/Library/Application\ Support/com.mitchellh.ghostty/config
```

如果没有指向 `~/.config/ghostty/config`，重新建立软链接即可。

---

## 6. 一次性安装命令参考

如果你想尽快搭起来，可以直接按下面顺序执行：

```bash
brew tap homebrew/cask-fonts
brew install git vim starship yazi btop zsh-completions zsh-autosuggestions zsh-syntax-highlighting
brew install --cask ghostty font-maple-mono-nf-cn
git clone git@github.com:zhichenghou/dot_config.git ~/.config
ln -sfn ~/.config/.zshrc ~/.zshrc
ln -sfn ~/.config/.vimrc ~/.vimrc
mkdir -p ~/Library/Application\ Support/com.mitchellh.ghostty
ln -sfn ~/.config/ghostty/config ~/Library/Application\ Support/com.mitchellh.ghostty/config
source ~/.zshrc
```

然后分别启动：

```bash
vim ~/.vimrc
yazi
btop
```
