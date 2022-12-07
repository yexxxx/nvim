-- :h mason-default-settings
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})


-- mason-lspconfig uses the `lspconfig` server names in the APIs it exposes - not `mason.nvim` package names
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
require("mason-lspconfig").setup({
  -- 确保安装，根据需要填写
  ensure_installed = {
    "sumneko_lua",
    "bashls",
    "dockerls",
    "jsonls",
    "rust_analyzer",
    "yamlls",
    "gopls",
    "jdtls",
    "sqlls",
    "marksman",
  },
  -- automatic_installation = false,
})


local lspconfig = require("lspconfig")

-- lspconfig.sumneko_lua.setup({})
-- lspconfig.gopls.setup({})
-- 安装列表
-- { key: 服务器名， value: 配置文件 }
-- key 必须为下列网址列出的 server name，不可以随便写
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  sumneko_lua = require("lsp.config.lua"), -- lua/lsp/config/lua.lua
  bashls = require("lsp.config.bash"),
  -- pyright = require("lsp.config.pyright"),
  --dockerls = require("lsp.config.docker"),
  gopls = require("lsp.config.go"),
  --jdtls = require("lsp.config.java"),
  jsonls = require("lsp.config.json"),
  --sqlls = require("lsp.config.sql"),
  -- rust_analyzer = require("lsp.config.rust"),
  yamlls = require("lsp.config.yamlls"),
  remark_ls = require("lsp.config.markdown"),
}

for name, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    -- 自定义初始化配置文件必须实现on_setup 方法
   config.on_setup(lspconfig[name])
  else
    -- 使用默认参数
   lspconfig[name].setup({})
  end
end

