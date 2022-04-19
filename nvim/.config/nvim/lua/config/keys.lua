local keymap = vim.keymap
local wk = require("which-key")

local opts = { silent = true }

-- Tab
wk.register({
  ["<Tab>"] = { "Indent cursor" },
})

-- Navigate tabs
keymap.set({ "n", "i", "t" }, "<C-t>d", "<C-\\><C-n>:tabclose<Cr>", opts)
keymap.set(
  { "n", "i", "t" },
  "<C-t>n",
  "<C-\\><C-n>:BufferLineCycleNext<Cr>",
  opts
)
keymap.set(
  { "n", "i", "t" },
  "<C-t>p",
  "<C-\\><C-n>:BufferLineCyclePrev<Cr>",
  opts
)
keymap.set({ "n", "i", "t" }, "<C-t>t", "<C-\\><C-n>:tabnew<Cr>", opts)
wk.register({
  ["<C-t>"] = {
    name = "+tabs",
    d = { "Close tab" },
    n = { "Next tab" },
    p = { "Previous tab" },
    t = { "Create new tab" },
  },
})

-- Exit the terminal
keymap.set({ "t" }, "<C-x>", "<C-\\><C-n>", opts)
wk.register({
  ["<C-x>"] = { "Exit insert mode" },
})

-- Move visual lines
keymap.set({ "n", "v" }, "j", "gj", opts)
keymap.set({ "n", "v" }, "k", "gk", opts)

-- The cursor should stay in the expected place
keymap.set({ "n", "v" }, "n", "nzzzv", opts)
keymap.set({ "n", "v" }, "N", "Nzzzv", opts)
keymap.set("n", "J", "mzJ`z", opts)
wk.register({
  n = { "Next search result" },
  N = { "Previous search result" },
  J = { "Merge with next line" },
})

-- Add the expected behaviour of Y
keymap.set("n", "Y", "y$", opts)
wk.register({
  Y = { "Yank until end of line" },
})

-- Add undo breakpoints
keymap.set("i", ",", ",<C-g>u", opts)
keymap.set("i", ".", ".<C-g>u", opts)
keymap.set("i", ";", ";<C-g>u", opts)

-- Clear searches with <Esc>
keymap.set("n", "<Esc>", ":noh<Cr>", opts)

-- Move lines
keymap.set("n", "<M-J>", ":m .+1<Cr>==", opts)
keymap.set("n", "<M-K>", ":m .-2<Cr>==", opts)
keymap.set("v", "<M-J>", ":m '>+1<Cr>gv=gv", opts)
keymap.set("v", "<M-K>", ":m '<-2<Cr>gv=gv", opts)
keymap.set("i", "<M-J>", "<Esc>:m .+1<Cr>==gi", opts)
keymap.set("i", "<M-K>", "<Esc>:m .-2<Cr>==gi", opts)
wk.register({
  ["<M-J>"] = { "Move line down" },
  ["<M-K>"] = { "Move line up" },
})

-- Easier window resizing
keymap.set({ "n", "i" }, "<M-h>", ":vertical resize -2<Cr>", opts)
keymap.set({ "n", "i" }, "<M-j>", ":resize +2<Cr>", opts)
keymap.set({ "n", "i" }, "<M-k>", ":resize -2<Cr>", opts)
keymap.set({ "n", "i" }, "<M-l>", ":vertical resize +2<Cr>", opts)
keymap.set("t", "<M-h>", "<C-\\><C-n>:vertical resize -2<Cr>i", opts)
keymap.set("t", "<M-j>", "<C-\\><C-n>:resize +2<Cr>i", opts)
keymap.set("t", "<M-k>", "<C-\\><C-n>:resize -2<Cr>i", opts)
keymap.set("t", "<M-l>", "<C-\\><C-n>:vertical resize +2<Cr>i", opts)
wk.register({
  ["<M-h>"] = { "Horizontally decrease window size" },
  ["<M-j>"] = { "Vertically increase window size" },
  ["<M-k>"] = { "Vertically decrease window size" },
  ["<M-l>"] = { "Horizontally increase window size" },
})

-- Keep the selection when indenting
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Jump to previous and next matches for the f and t search
keymap.set({ "n", "v" }, ";", "<Plug>Lightspeed_;_ft", opts)
keymap.set({ "n", "v" }, ",", "<Plug>Lightspeed_,_ft", opts)
wk.register({
  s = { "Lightspeed search" },
  S = { "Lightspeed search backwards" },
  [";"] = { "Next ft search match" },
  [","] = { "Previous ft search match" },
})

-- Evaluate a code section
keymap.set("v", "<Leader>e", function()
  require("util.evaluate").section()
end, opts)

-- Harpoon
keymap.set({ "n", "i", "t" }, "<M-1>", function()
  require("harpoon.ui").nav_file(1)
end, opts)
keymap.set({ "n", "i", "t" }, "<M-2>", function()
  require("harpoon.ui").nav_file(2)
end, opts)
keymap.set({ "n", "i", "t" }, "<M-3>", function()
  require("harpoon.ui").nav_file(3)
end, opts)
keymap.set({ "n", "i", "t" }, "<M-4>", function()
  require("harpoon.ui").nav_file(4)
end, opts)
wk.register({
  ["<M-1>"] = { "Jump to first marked file" },
  ["<M-2>"] = { "Jump to second marked file" },
  ["<M-3>"] = { "Jump to third marked file" },
  ["<M-4>"] = { "Jump to fourth marked file" },
})

-- Luasnip
keymap.set({ "n", "i" }, "<C-Tab>", function()
  local ls = require("luasnip")
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, opts)
keymap.set({ "n", "i" }, "<C-e>", function()
  local ls = require("luasnip")
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, opts)
wk.register({
  ["<C-Tab>"] = { "Switch between choices" },
  ["<C-e>"] = { "Expand or jump in snippets" },
})

-- Navigator
keymap.set({ "n", "v", "t" }, "<C-h>", function()
  require("Navigator").left()
end, opts)
keymap.set({ "n", "v", "t" }, "<C-j>", function()
  require("Navigator").down()
end, opts)
keymap.set({ "n", "v", "t" }, "<C-k>", function()
  require("Navigator").up()
end, opts)
keymap.set({ "n", "v", "t" }, "<C-l>", function()
  require("Navigator").right()
end, opts)
wk.register({
  ["<C-h>"] = { "Activate left window" },
  ["<C-j>"] = { "Activate lower window" },
  ["<C-k>"] = { "Activate upper window" },
  ["<C-l>"] = { "Activate right window" },
})

-- <C-g>
wk.register({
  ["<C-g>"] = {
    name = "+goto/get",
    n = {
      name = "+next",
      c = {
        "Go to the beginning of the next class",
      }, -- Defined in nvim-treesitter.lua
      C = {
        "Go to the end of the next class ",
      }, -- Defined in nvim-treesitter.lua
      f = {
        "Go to the beginning of the next function",
      }, -- Defined in nvim-treesitter.lua
      F = {
        "Go to the end of the next function",
      }, -- Defined in nvim-treesitter.lua
      t = {
        ":tn<Cr>",
        "Go to the next matching tag",
      },
    },
    p = {
      name = "+previous",
      c = {
        "Go to the beginning of the previous class",
      }, -- Defined in nvim-treesitter.lua
      C = {
        "Go to the end of the previous class ",
      }, -- Defined in nvim-treesitter.lua
      f = {
        "Go to the beginning of the previous function",
      }, -- Defined in nvim-treesitter.lua
      F = {
        "Go to the end of the previous function",
      }, -- Defined in nvim-treesitter.lua
      t = {
        ":tN<Cr>",
        "Go to the previous matching tag",
      },
    },
  },
})

-- C-c
wk.register({
  ["<C-c>"] = {
    name = "+custom",
  },
})

-- Leader
wk.register({
  ["<Leader>"] = {
    a = {
      name = "+action",
      g = {
        name = "+generate",
        c = {
          function()
            require("neogen").generate()
          end,
          "Generate documentation",
        },
      },
      s = { "Swap with next parameter" }, -- Defined in nvim-treesitter.lua
      S = { "Swap with previous parameter" }, -- Defined in nvim-treesitter.lua
    },
    b = {
      name = "+buffer",
      b = {
        function()
          require("telescope.builtin").buffers()
        end,
        "Show buffers",
      },
      d = { ":bdelete %<Cr>:bd<Space>", "Delete buffer" },
      f = { ":Format<Cr>", "Format the buffer" },
      n = { ":pnext<Cr>", "Next buffer" },
      p = { ":bprevious<Cr>", "Previous buffer" },
    },
    e = {
      name = "+evaluate",
      b = {
        function()
          require("util.evaluate").buffer()
        end,
        "Evaluate the current buffer",
      },
      e = {
        function()
          require("util.evaluate").line()
        end,
        "Evaluate the current line",
      },
    },
    d = {
      name = "+debugger",
      b = {
        name = "+breakpoint",
        b = {
          function()
            require("dap").toggle_breakpoint()
          end,
          "Toggle breakpoint",
        },
        g = {
          function()
            require("dapui").toggle()
          end,
          "Toggle GUI",
        },
        l = {
          function()
            require("dap").set_breakpoint(
              nil,
              nil,
              vim.fn.input("Log point message: ")
            )
          end,
          "Log breakpoint",
        },
      },
      r = {
        function()
          require("dap").repl.toggle()
        end,
        "Toggle REPL",
      },
    },
    f = {
      name = "+file",
      n = { ":enew<Cr>", "New file" },
      b = {
        function()
          require("telescope").extensions.file_browser.file_browser()
        end,
        "File browser",
      },
      f = {
        function()
          require("telescope.builtin").fd({ hidden = true })
        end,
        "Find file",
      },
      g = {
        function()
          require("telescope.builtin").git_files()
        end,
        "Files",
      },
      r = {
        function()
          require("telescope.builtin").oldfiles()
        end,
        "Recent files",
      },
    },
    g = {
      name = "+git",
      b = {
        function()
          require("telescope.builtin").git_branches()
        end,
        "Branches",
      },
      c = {
        function()
          require("telescope.builtin").git_commits()
        end,
        "Commits",
      },
      g = {
        function()
          require("neogit").open({ kind = "vsplit" })
        end,
        "Neogit",
      },
      i = {
        name = "+issue",
        l = {
          ":Octo issue list<Cr>",
          "List issues",
        },
        n = {
          ":Octo issue create<Cr>",
          "Create new issue",
        },
      },
      p = {
        name = "+pull request",
        l = {
          ":Octo pr list<Cr>",
          "List PRs",
        },
      },
      s = {
        function()
          require("telescope.builtin").git_status()
        end,
        "Status",
      },
    },
    h = {
      name = "+help",
      a = {
        function()
          require("telescope.builtin").autocommands()
        end,
        "Auto commands",
      },
      c = {
        function()
          require("telescope.builtin").commands()
        end,
        "Commands",
      },
      f = {
        function()
          require("telescope.builtin").filetypes()
        end,
        "File types",
      },
      h = {
        function()
          require("telescope.builtin").help_tags()
        end,
        "Help pages",
      },
      k = {
        function()
          require("telescope.builtin").keymaps()
        end,
        "Keymaps",
      },
      l = {
        "<Cmd>TSHighlightCapturesUnderCursor<Cr>",
        "Highlight group under cursor",
      },
      m = {
        function()
          require("telescope.builtin").man_pages()
        end,
        "Man pages",
      },
      p = {
        name = "+packer",
        c = { "<Cmd>PackerCompile<Cr>", "Compile" },
        i = { "<Cmd>PackerInstall<Cr>", "Install" },
        p = { "<Cmd>PackerSync<Cr>", "Sync" },
        s = { "<Cmd>PackerStatus<Cr>", "Status" },
      },
      o = {
        function()
          require("telescope.builtin").vim_options()
        end,
        "Options",
      },
      s = {
        function()
          require("telescope.builtin").highlights()
        end,
        "Highlight groups",
      },
      t = {
        function()
          require("telescope.builtin").builtin()
        end,
        "Telescope",
      },
    },
    n = {
      name = "+neorg",
      i = {
        ":Neorg inject-metadata<Cr>",
        "Inject File header",
      },
      m = {
        name = "+mode",
      },
      n = { ":NeorgStart<Cr>", "Load the latest workspace" },
      t = {
        name = "+task",
        a = { ":Neorg gtd capture<Cr>", "Add a task" },
        t = { ":Neorg gtd views<Cr>", "View the tasks" },
      },
      w = {
        name = "+workspace",
        g = { ":Neorg workspace gtd<Cr>", "GTD" },
        n = { ":Neorg workspace notes<Cr>", "Notes" },
        p = {
          ":Neorg workspace projects<Cr>",
          "Projects",
        },
        s = { ":Neorg workspace school<Cr>", "School" },
      },
      ["?"] = { ":Neorg news all<Cr>", "View news" },
    },
    o = {
      name = "+open",
      m = { "<Plug>MarkdownPreviewToggle", "Toggle markdown preview" },
      t = {
        name = "+terminal",
        f = {
          ":ToggleTerm direction=float<Cr>",
          "Open a floating terminal",
        },
        t = {
          ":ToggleTerm direction=tab<Cr>",
          "Open a terminal tab",
        },
        v = {
          ":ToggleTerm direction=vertical<Cr>",
          "Open a terminal in a vertical split",
        },
        x = {
          ":ToggleTerm direction=horizontal<Cr>",
          "Open a terminal in a horizontal split",
        },
      },
    },
    p = {
      name = "+project",
      p = {
        function()
          require("telescope").extensions.project.project({})
        end,
        "Open Projects",
      },
    },
    t = {
      name = "+toggle",
      s = { ":setlocal spell!<Cr>", "Spell check" },
    },
    s = {
      name = "+search",
      g = {
        function()
          require("telescope.builtin").live_grep()
        end,
        "Grep",
      },
      b = {
        function()
          require("telescope.builtin").current_buffer_fuzzy_find()
        end,
        "Buffer",
      },
      h = {
        function()
          require("telescope.builtin").command_history()
        end,
        "Command history",
      },
      m = {
        function()
          require("telescope.builtin").marks()
        end,
        "Marks",
      },
      s = {
        function()
          require("telescope.builtin").lsp_document_symbols({
            symbols = {
              "Class",
              "Function",
              "Method",
              "Constructor",
              "Interface",
              "Module",
            },
          })
        end,
        "Symbols",
      },
    },
    w = {
      name = "+workspace",
      h = {
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        "Toggle harpoon menu",
      },
      m = {
        function()
          require("harpoon.mark").add_file()
        end,
        "Add file to harpoon list",
      },
      s = {
        name = "+session",
        l = {
          function()
            require("persistence").load({ last = true })
          end,
          "Restore last",
        },
        s = {
          function()
            require("persistence").load()
          end,
          "Restore",
        },
        q = {
          function()
            require("persistence").stop()
          end,
          "Stop",
        },
      },
      x = {
        name = "+errors",
        x = { "<Cmd>TroubleToggle<Cr>", "Trouble" },
        w = { "<Cmd>TroubleWorkspaceToggle<Cr>", "Workspace Trouble" },
        d = { "<Cmd>TroubleDocumentToggle<Cr>", "Document Trouble" },
        t = { "<Cmd>TodoTrouble<Cr>", "Todo Trouble" },
        T = { "<Cmd>TodoTelescope<Cr>", "Todo Telescope" },
        l = { "<Cmd>lopen<Cr>", "Open Location List" },
        q = { "<Cmd>copen<Cr>", "Open Quickfix List" },
      },
    },
  },
})
