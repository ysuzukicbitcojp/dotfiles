# Dotfiles

WSL2（Ubuntu）で使っている個人用の設定ファイル集です。`~/dotfiles` に clone し、各ファイルをホームディレクトリへシンボリックリンクして使います。

## 収録内容

| ファイル | 内容 |
|---|---|
| `.bashrc` | bash 設定（PATH、エイリアス、プロンプト、fzf 連携） |
| `.config/nvim/` | Neovim 設定（lazy.nvim + init.lua）。詳細は [`.config/nvim/README.md`](.config/nvim/README.md) |
| `.tmux.conf` | tmux 設定（TPM でプラグイン管理） |
| `.gitconfig` | Git のエイリアス、diff/merge ツール設定（fzf 連携あり） |
| `.git-prompt.sh` | プロンプトに Git の状態を表示するスクリプト |
| `.dircolors` | `ls` の配色 |
| `.myclirc` | mycli（MySQL クライアント）設定 |
| `.aider.conf.yml` | aider 設定 |

`.ssh/config`、`.claude/` などの環境固有・機密情報を含むファイルは収録していません。

## セットアップ

### 1. リポジトリの取得

```bash
git clone https://github.com/ysuzukicbitcojp/dotfiles.git ~/dotfiles
```

### 2. 外部リポジトリの取得（任意）

fzf の拡張スクリプト（fzf-extras）は別リポジトリで管理しています。使う場合のみ clone してください。

```bash
git clone https://github.com/strongmaimai369/fzf-extras.git ~/dotfiles/.fzf-extras
```

### 3. シンボリックリンクの作成

既存のファイルがある場合は、先に退避してから実行してください。

```bash
ln -s ~/dotfiles/.bashrc ~/.bashrc
ln -s ~/dotfiles/.dircolors ~/.dircolors
ln -s ~/dotfiles/.git-prompt.sh ~/.git-prompt.sh
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.myclirc ~/.myclirc
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.aider.conf.yml ~/.aider.conf.yml

mkdir -p ~/.config
ln -s ~/dotfiles/.config/nvim ~/.config/nvim

# fzf-extras を取得した場合
ln -s ~/dotfiles/.fzf-extras ~/.fzf-extras
```

`.bashrc` は `.dircolors`、`.git-prompt.sh`、fzf 拡張スクリプトを読み込みます。ファイルが存在しない場合は読み込みをスキップします。

### 4. 環境固有の設定（bash）

API キーなどの機密情報や環境ごとに異なる値は、`.bashrc` に書かずに `~/.bashrc.local` に記述してください。`.bashrc` の読み込み時に、このファイルがあれば読み込みます。

```bash
# ~/.bashrc.local
export AZURE_API_KEY=...
export AZURE_API_VERSION=...
export AZURE_API_BASE=https://<your-resource>.openai.azure.com
export AWS_PROFILE=...
export AWS_REGION=...
export ZENHAN_PATH="/mnt/c/Users/<username>/tools/zenhan/zenhan.exe"
```

```bash
chmod 600 ~/.bashrc.local
```

### 5. 個人情報の設定（Git）

`.gitconfig` はユーザー名とメールアドレスを含めず、`~/dotfiles/.gitconfig.private` を読み込む構成にしています。このファイルは `.gitignore` 対象なので、各自で作成してください。

```ini
# ~/dotfiles/.gitconfig.private
[user]
    name = Your Name
    email = you@example.com
```

### 6. tmux プラグインのインストール

`.tmux.conf` は TPM を前提にしています。

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

tmux 起動後、`prefix` + `I` でプラグインをインストールします。

### 7. Neovim プラグインのインストール

`nvim` を初回起動すると lazy.nvim とプラグインが自動でインストールされます。記録済みのバージョンに揃える場合は、次のコマンドを実行してください。

```vim
:Lazy restore
```

### 8. aider（任意）

`.aider.conf.yml` は Azure OpenAI を使う設定です。API キーなどは手順 4 の `~/.bashrc.local` で環境変数として渡してください。

## 依存ツール

| ツール | インストール例 |
|---|---|
| [fzf](https://github.com/junegunn/fzf) | `git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install` |
| tmux | `sudo apt install tmux` |
| Neovim | `sudo apt install neovim`（新しいバージョンが必要な場合は公式リリースを利用） |
| mycli | `pip install mycli` |

pyenv、nvm、composer、pnpm、Google Cloud SDK は `.bashrc` から参照しますが、未インストールでもエラーにはなりません。

`.gitconfig` のエイリアスの一部（`git co`、`git d` など）と fzf 拡張スクリプトは fzf を使います。

## ライセンス

同梱の `.git-prompt.sh` は Git プロジェクト由来で、GPL-2.0 に従います。
