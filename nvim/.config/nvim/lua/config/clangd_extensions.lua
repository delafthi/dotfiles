local M = {}

function M.config()
  local ok, clangd_ext = pcall(function()
    return require("clangd_extensions")
  end)

  if not ok then
    print("Here")
    return
  end

  local capabilities = require("config.nvim-lspconfig").get_capabilities()
  local on_attach = require("config.nvim-lspconfig").on_attach

  clangd_ext.setup({
    server = {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = {
        "/usr/bin/clangd",
        "--all-scopes-completion",
        "--background-index",
        "--clang-tidy",
        "--cross-file-rename",
        "--header-insertion=iwyu",
        "--header-insertion-decorators",
      },
    },
    extensions = {
      -- defaults:
      -- Automatically set inlay hints (type hints)
      autoSetHints = true,
      -- Whether to show hover actions inside the hover window
      -- This overrides the default hover handler
      hover_with_actions = true,
      -- These apply to the default ClangdSetInlayHints command
      inlay_hints = {
        -- Only show inlay hints for the current line
        only_current_line = false,
        -- Event which triggers a refersh of the inlay hints.
        -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
        -- not that this may cause  higher CPU usage.
        -- This option is only respected when only_current_line and
        -- autoSetHints both are true.
        only_current_line_autocmd = "CursorHold",
        -- whether to show parameter hints with the inlay hints or not
        show_parameter_hints = true,
        -- whether to show variable name before type hints with the inlay hints or not
        show_variable_name = false,
        -- prefix for parameter hints
        parameter_hints_prefix = "<- ",
        -- prefix for all the other hints (type, chaining)
        other_hints_prefix = "=> ",
        -- whether to align to the length of the longest line in the file
        max_len_align = false,
        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,
        -- whether to align to the extreme right or not
        right_align = false,
        -- padding from the right if right_align is true
        right_align_padding = 7,
        -- The color of the hints
        highlight = "Comment",
      },
      ast = {
        role_icons = {
          type = "",
          declaration = "",
          expression = "",
          specifier = "",
          statement = "",
          ["template argument"] = "",
        },

        kind_icons = {
          Compound = "",
          Recovery = "",
          TranslationUnit = "",
          PackExpansion = "",
          TemplateTypeParm = "",
          TemplateTemplateParm = "",
          TemplateParamObject = "",
        },

        highlights = {
          detail = "Comment",
        },
      },
    },
  })
end

return M
