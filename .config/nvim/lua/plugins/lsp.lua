return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- LSP アタッチ時のキーマップ
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
        callback = function(args)
          local buf = args.buf
          local map = function(lhs, rhs)
            vim.keymap.set("n", lhs, rhs, { buffer = buf, silent = true })
          end
          map("gd",         vim.lsp.buf.definition)
          map("gr",         vim.lsp.buf.references)
          map("gi",         vim.lsp.buf.implementation)
          map("gt",         vim.lsp.buf.type_definition)
          map("gs",         vim.lsp.buf.document_symbol)
          map("gS",         vim.lsp.buf.workspace_symbol)
          map("<leader>rn", vim.lsp.buf.rename)
          map("K",          vim.lsp.buf.hover)
          map("[g",         vim.diagnostic.goto_prev)
          map("]g",         vim.diagnostic.goto_next)
        end,
      })

      vim.diagnostic.config({
        virtual_text  = { prefix = "✨" },
        signs         = true,
        underline     = true,
        update_in_insert = false,
      })

      -- PHP: intelephense
      if vim.fn.executable("intelephense") == 1 then
        lspconfig.intelephense.setup({
          capabilities = capabilities,
          settings = {
            intelephense = {
              stubs = {
                "apache","bcmath","bz2","calendar","com_dotnet","Core","ctype","curl",
                "date","dba","dom","enchant","exif","FFI","fileinfo","filter","fpm","ftp",
                "gd","gettext","gmp","hash","iconv","imap","intl","json","ldap","libxml",
                "mbstring","meta","mysqli","oci8","odbc","openssl","pcntl","pcre","PDO",
                "pdo_ibm","pdo_mysql","pdo_pgsql","pdo_sqlite","pgsql","Phar","posix",
                "pspell","readline","Reflection","session","shmop","SimpleXML","snmp",
                "soap","sockets","sodium","SPL","sqlite3","standard","superglobals",
                "sysvmsg","sysvsem","sysvshm","tidy","tokenizer","xml","xmlreader",
                "xmlrpc","xmlwriter","xsl","Zend OPcache","zip","zlib","wordpress",
              },
            },
          },
        })
      end

      -- Bash: bash-language-server
      if vim.fn.executable("bash-language-server") == 1 then
        lspconfig.bashls.setup({
          capabilities = capabilities,
          settings = {
            bashIde = {
              explainshell     = { enabled = false },
              diagnostics      = { disabled = { "source-non-constant", "SC3043" } },
            },
          },
        })
      end

      -- Python: pylsp
      if vim.fn.executable("pylsp") == 1 then
        lspconfig.pylsp.setup({
          capabilities = capabilities,
          settings = {
            pylsp = {
              plugins = {
                pylint      = { enabled = false },
                flake8      = { enabled = false },
                mccabe      = { enabled = false },
                pycodestyle = { enabled = true, ignore = { "W293", "E302", "E501" } },
                pyflakes    = { enabled = false },
              },
            },
          },
        })
      end
    end,
  },
}
