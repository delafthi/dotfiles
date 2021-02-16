local M = {}
local lsp = require('lspconfig')
local u = require('utils')

function M.setup()
  local on_attach = function(client, bufnr)

    u.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Mappings.
    local opts = { noremap=true, silent=true }
    u.bufmap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<Cr>', opts)
    u.bufmap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<Cr>', opts)
    u.bufmap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<Cr>', opts)
    u.bufmap(bufnr, 'n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<Cr>', opts)
    u.bufmap(bufnr, 'n', 'gs', '<Cmd>lua vim.lsp.buf.signature_help()<Cr>', opts)
    u.bufmap(bufnr, 'n', '<Leader>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<Cr>', opts)
    u.bufmap(bufnr, 'n', '<Leader>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<Cr>', opts)
    u.bufmap(bufnr, 'n', '<Leader>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<Cr>', opts)
    u.bufmap(bufnr, 'n', '<Leader>D', '<Cmd>lua vim.lsp.buf.type_definition()<Cr>', opts)
    u.bufmap(bufnr, 'n', '<Leader>rn', '<Cmd>lua vim.lsp.buf.rename()<Cr>', opts)
    u.bufmap(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<Cr>', opts)
    u.bufmap(bufnr, 'n', '<Leader>e', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<Cr>', opts)
    u.bufmap(bufnr, 'n', '[d', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<Cr>', opts)
    u.bufmap(bufnr, 'n', ']d', '<Cmd>lua vim.lsp.diagnostic.goto_next()<Cr>', opts)
    u.bufmap(bufnr, 'n', '<Leader>q', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<Cr>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
      u.bufmap(bufnr, 'n', '<Leader>lf', '<cmd>lua vim.lsp.buf.formatting()<Cr>', opts)
    elseif client.resolved_capabilities.document_range_formatting then
      u.bufmap(bufnr, 'n', '<Leader>lf', '<cmd>lua vim.lsp.buf.formatting()<Cr>', opts)
    end
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
      vim.api.nvim_exec([[
        augroup lsp_document_highlight
          autocmd!
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup end
        ]], false)
    end
  end

  -- Sign Character customization
  local sign_chars = vim.api.nvim_exec(
    [[
    sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=LspDiagnosticsSignError
    sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=LspDiagnosticsSignWarning
    sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=LspDiagnosticsSignInformation
    sign define LspDiagnosticsSignHint text=ﯦ texthl=LspDiagnosticsSignHint linehl= numhl=LspDiagnosticsSignHint
    ]],
    true
  )

  -- Setup different language servers
  -- bash-language-server
  lsp.bashls.setup{ on_attach = on_attach }
  -- c-language-server
  lsp.ccls.setup{ on_attach = on_attach }
  -- dockerfile-language-server
  lsp.dockerls.setup{ on_attach = on_attach }
  -- haskell-language-server
  lsp.hls.setup{
    on_attach = on_attach,
    root_dir = lsp.util.root_pattern('*.cabal', 'stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml')
  }
  -- python-language-server
  lsp.pyls.setup{
    on_attach = on_attach,
    root_dir = lsp.util.root_pattern('.git', vim.fn.getcwd()),
  }
  -- sumneko lua-language-server
  local sumneko_lua_root_path = vim.fn.stdpath('cache') .. '/lspconfig/sumneko_lua/lua-language-server'
  local sumneko_lua_binary = sumneko_lua_root_path .. '/bin/Linux/lua-language-server'
  lsp.sumneko_lua.setup{
    on_attach = on_attach,
    cmd = {sumneko_lua_binary, '-E', sumneko_lua_root_path .. '/main.lua'};
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          enable = true,
          -- Get the language server to recognize the vim and awesome globals
          globals = {'vim', 'awesome', 'client', 'root', 'screen'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
            },
        },
      },
    },
  }
  -- (La)Tex-language-server
  lsp.texlab.setup{ on_attach = on_attach }
  -- vim-language-server
  lsp.vimls.setup{ on_attach = on_attach }
  -- yaml-language-server
  lsp.yamlls.setup{ on_attach = on_attach }
end

return M
