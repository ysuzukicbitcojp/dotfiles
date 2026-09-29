# Neovim 設定（lazy.nvim）

lazy.nvim + init.lua で構成した Neovim 設定。

## ディレクトリ構成

`~/.config/nvim` を `~/dotfiles/.config/nvim` へのシンボリックリンクとして使う。

```bash
ln -s ~/dotfiles/.config/nvim ~/.config/nvim
```

```
~/.config/nvim/  →  ~/dotfiles/.config/nvim/
├── init.lua             # lazy.nvim のブートストラップ
├── lazy-lock.json       # プラグインのバージョン固定
├── UltiSnips/           # スニペット
└── lua/
    ├── config/
    │   ├── options.lua      # vim.opt 設定
    │   ├── keymaps.lua      # キーマップ
    │   └── autocmds.lua     # augroup / autocmd
    └── plugins/
        ├── colorscheme.lua  # molokai
        ├── telescope.lua    # ファジーファインダー
        ├── git.lua          # gitgutter, fugitive
        ├── lsp.lua          # nvim-lspconfig（PHP / Bash / Python）
        ├── cmp.lua          # nvim-cmp（コード補完）
        ├── editor.lua       # easymotion, surround, commentary 等
        ├── ui.lua           # airline, devicons
        ├── snippets.lua     # UltiSnips
        └── misc.lua         # markdown-preview, obsession
```

## 初回セットアップ

### 1. 前提ツールの確認

```bash
# LSP サーバー（使うものだけ）
which intelephense        # PHP
which bash-language-server
which pylsp               # Python

# markdown-preview のビルドに必要
which npm
```

### 2. Neovim を起動する

```bash
nvim
```

初回起動時に lazy.nvim が自動でインストールされ、続いて全プラグインのダウンロードとインストールが実行される。完了後に `:q` で一度終了し、再起動すると設定が完全に反映される。

### 3. インストール状態の確認

```
:Lazy
```

`lazy-lock.json` に記録されたバージョンに揃える場合は `:Lazy restore` を実行する。

## プラグイン管理

| 操作 | コマンド |
|---|---|
| 状態確認・操作UI | `:Lazy` |
| 全プラグイン更新 | `:Lazy update` |
| 記録済みバージョンに復元 | `:Lazy restore` |
| 不要プラグイン削除 | `:Lazy clean` |
| プロファイル確認 | `:Lazy profile` |

### プラグインの追加

`lua/plugins/` 以下の任意の `.lua` ファイルに追記するか、新しいファイルを作成する。lazy.nvim がディレクトリ内の全 `.lua` を自動検出する。

```lua
-- 例: lua/plugins/new_plugin.lua
return {
  {
    "author/plugin-name",
    event = "BufReadPre",   -- 遅延ロードトリガー（省略で起動時ロード）
    config = function()
      require("plugin-name").setup({})
    end,
  },
}
```

### 遅延ロードの判断基準

`:Lazy` で `not loaded` と表示されるプラグインは、トリガー条件が満たされるまでロードされない。これは正常な動作だが、プラグインの性質によっては起動時ロードが必要になる。

| 性質 | 設定 | 例 |
|---|---|---|
| キー操作・コマンドで明示的に使う | `keys` / `cmd` で遅延ロード可 | telescope, fugitive |
| 特定ファイルタイプでのみ使う | `ft` で遅延ロード可 | vim-rails, markdown-preview |
| 起動時から常駐して状態を監視する | `lazy = false` 必須 | airline, gitgutter |
| セッション復元後も継続動作が必要 | `lazy = false` 必須 | vim-obsession |

**vim-obsession の例**: `cmd = "Obsession"` にすると `:Obsession` を手動実行するまでロードされず、`nvim -S Session.vim` でセッション復元した後の自動保存 autocmd が登録されないため変更が失われる。

### Lua で VimScript に空辞書を渡す際の注意

Lua の `{}` は VimScript に空配列として渡るため、辞書型を期待する設定には `vim.empty_dict()` を使う。

```lua
-- NG: 空配列として渡り E1206 になる
vim.g["some#dict#setting"] = {}

-- OK
vim.g["some#dict#setting"] = vim.empty_dict()
```

## パス設計

全パスを `vim.fn.stdpath()` で解決しており、XDG 環境変数に自動追従する。

| stdpath キー | デフォルト解決先 | 用途 |
|---|---|---|
| `"config"` | `$XDG_CONFIG_HOME/nvim` | 設定ファイル、UltiSnips |
| `"data"` | `$XDG_DATA_HOME/nvim` | lazy.nvim 本体・プラグイン |
| `"state"` | `$XDG_STATE_HOME/nvim` | undo 履歴、shada |
| `"cache"` | `$XDG_CACHE_HOME/nvim` | キャッシュ |

### 別環境でパスを変えたい場合

シェルの設定ファイル（`.bashrc` / `.zshrc`）で XDG 変数を上書きするだけでよい。Neovim 側のコード変更は不要。

```bash
# 例: 作業用サーバーで別ディレクトリを使う場合
export XDG_DATA_HOME="/work/.local/share"
export XDG_CONFIG_HOME="/work/.config"
```

### 複数設定を同居させたい場合（Neovim 0.9+）

```bash
# デフォルト設定: ~/.config/nvim
nvim

# 別の設定: ~/.config/nvim-work
NVIM_APPNAME=nvim-work nvim
```

## 環境変数

| 変数 | 用途 | デフォルト値 |
|---|---|---|
| `ZENHAN_PATH` | WSL用 zenhan.exe のパス | なし（未設定時は zenhan 連携を無効化） |
| `XDG_CONFIG_HOME` | 設定ファイルのベースディレクトリ | `~/.config` |
| `XDG_DATA_HOME` | プラグインのインストール先ベース | `~/.local/share` |

`ZENHAN_PATH` を別環境で使う場合：

```bash
export ZENHAN_PATH="/mnt/c/Users/<username>/tools/zenhan/zenhan.exe"
```

未設定、またはファイルが存在しない場合は zenhan の autocmd が無効化されるため、エラーにはならない。

## LSP

### 対応言語

| 言語 | LSP サーバー | インストール |
|---|---|---|
| PHP | `intelephense` | `npm install -g intelephense` |
| Bash | `bash-language-server` | `npm install -g bash-language-server` |
| Python | `pylsp` | `pip install python-lsp-server` |

実行可能ファイルが `PATH` に存在しない場合、そのサーバーのセットアップはスキップされる（エラーにはならない）。

### LSP キーマップ（バッファローカル）

| キー | 操作 |
|---|---|
| `gd` | 定義へジャンプ |
| `gr` | 参照一覧 |
| `gi` | 実装へジャンプ |
| `gt` | 型定義へジャンプ |
| `gs` | ドキュメントシンボル検索 |
| `gS` | ワークスペースシンボル検索 |
| `K` | ホバードキュメント表示 |
| `<leader>rn` | リネーム |
| `[g` / `]g` | 診断エラーを前後に移動 |

### 新しい LSP サーバーの追加

`lua/plugins/lsp.lua` の `config` 関数内に追記する：

```lua
if vim.fn.executable("typescript-language-server") == 1 then
  lspconfig.ts_ls.setup({ capabilities = capabilities })
end
```

## コード補完（nvim-cmp）

| キー | 操作 |
|---|---|
| `<C-Space>` | 補完を手動で起動 |
| `<C-n>` / `<C-p>` | 候補を選択 |
| `<CR>` | 候補を確定（選択なしの場合は確定しない） |
| `<C-e>` | 補完を閉じる |
| `<C-d>` / `<C-u>` | ドキュメントをスクロール |
| `<Tab>` | UltiSnips のスニペット展開（補完候補選択には使わない） |
| `<C-j>` / `<C-k>` | UltiSnips のプレースホルダーを前後に移動 |

## Neovim バージョン互換性

| プラグイン | 固定バージョン | 理由 | 解除条件 |
|---|---|---|---|
| telescope.nvim | `tag = "v0.1.9"` | v0.2.0 以降は nvim 0.10.4 以上が必要 | nvim を 0.10.4 以上に更新したら `tag` を削除 |

nvim を更新した際は `lua/plugins/telescope.lua` の `tag` 指定を見直すこと。

## 注意点

- **初回起動時間**: 全プラグインのクローンが走るため数分かかる場合がある
- **markdown-preview のビルド**: `npm` が必要。初回 markdown ファイルを開いた際にバックグラウンドでビルドが走る
- **UltiSnips と nvim-cmp の Tab 競合**: Tab キーは UltiSnips に委ねており、補完候補のナビゲーションには `<C-n>` / `<C-p>` を使う
- **win-ime-con.nvim**: `has("win32") || has("win64")` が偽の場合（Linux/WSL 含む）はロードされない
