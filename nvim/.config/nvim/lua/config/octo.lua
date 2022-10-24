local M = {}

function M.config()
  local c = require("nordic.palette")

  require("octo").setup({
    default_remote = { "upstream", "origin" }, -- order to try remotes
    reaction_viewer_hint_icon = "", -- marker for user reactions
    user_icon = " ", -- user icon
    timeline_marker = "", -- timeline marker
    timeline_indent = "2", -- timeline indentation
    right_bubble_delimiter = "", -- Bubble delimiter
    left_bubble_delimiter = "", -- Bubble delimiter
    github_hostname = "", -- GitHub Enterprise host
    snippet_context_lines = 4, -- number or lines around commented lines
    issues = {
      order_by = { -- criteria to sort results of `Octo issue list`
        field = "CREATED_AT", -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
        direction = "DESC", -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
      },
    },
    pull_requests = {
      order_by = { -- criteria to sort the results of `Octo pr list`
        field = "CREATED_AT", -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
        direction = "DESC", -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
      },
      always_select_remote_on_create = "false", -- always give prompt to select base remote repo when creating PRs
    },
    file_panel = {
      size = 10, -- changed files panel rows
      use_icons = true, -- use web-devicons in file panel
    },
    colors = {
      white = c.dark_white,
      grey = c.gray,
      black = c.dark_black,
      red = c.red,
      dark_red = c.red,
      green = c.green,
      dark_green = c.green,
      yellow = c.yellow,
      dark_yellow = c.yellow,
      blue = c.blue,
      dark_blue = c.intense_blue,
      purple = c.purple,
    },
    mappings = {
      issue = {
        close_issue = { lhs = "<C-s>ic", desc = "close issue" },
        reopen_issue = { lhs = "<C-s>io", desc = "reopen issue" },
        list_issues = {
          lhs = "<C-s>il",
          desc = "list open issues on same repo",
        },
        reload = { lhs = "<C-s>u", desc = "reload issue" },
        open_in_browser = { lhs = "<C-s>b", desc = "open issue in browser" },
        copy_url = { lhs = "<C-s>y", desc = "copy url to system clipboard" },
        add_assignee = { lhs = "<C-s>aa", desc = "add assignee" },
        remove_assignee = { lhs = "<C-s>ad", desc = "remove assignee" },
        create_label = { lhs = "<C-s>lc", desc = "create label" },
        add_label = { lhs = "<C-s>la", desc = "add label" },
        remove_label = { lhs = "<C-s>ld", desc = "remove label" },
        goto_issue = {
          lhs = "<C-s>gi",
          desc = "navigate to a local repo issue",
        },
        add_comment = { lhs = "<C-s>ca", desc = "add comment" },
        delete_comment = { lhs = "<C-s>cd", desc = "delete comment" },
        next_comment = { lhs = "<C-s>n", desc = "go to next comment" },
        prev_comment = { lhs = "<C-s>p", desc = "go to previous comment" },
        react_hooray = { lhs = "<C-s>ro", desc = "add/remove 🎉 reaction" },
        react_heart = { lhs = "<C-s>rh", desc = "add/remove ❤️ reaction" },
        react_eyes = { lhs = "<C-s>re", desc = "add/remove 👀 reaction" },
        react_thumbs_up = { lhs = "<C-s>rp", desc = "add/remove 👍 reaction" },
        react_thumbs_down = {
          lhs = "<C-s>rd",
          desc = "add/remove 👎 reaction",
        },
        react_rocket = { lhs = "<C-s>rr", desc = "add/remove 🚀 reaction" },
        react_laugh = { lhs = "<C-s>rl", desc = "add/remove 😄 reaction" },
        react_confused = { lhs = "<C-s>rc", desc = "add/remove 😕 reaction" },
      },
      pull_request = {
        checkout_pr = { lhs = "<C-s>po", desc = "checkout PR" },
        merge_pr = { lhs = "<C-s>pm", desc = "merge commit PR" },
        squash_and_merge_pr = { lhs = "<C-s>psm", desc = "squash and merge PR" },
        list_commits = { lhs = "<C-s>pc", desc = "list PR commits" },
        list_changed_files = { lhs = "<C-s>pf", desc = "list PR changed files" },
        show_pr_diff = { lhs = "<C-s>pd", desc = "show PR diff" },
        add_reviewer = { lhs = "<C-s>va", desc = "add reviewer" },
        remove_reviewer = { lhs = "<C-s>vd", desc = "remove reviewer request" },
        close_issue = { lhs = "<C-s>ic", desc = "close PR" },
        reopen_issue = { lhs = "<C-s>io", desc = "reopen PR" },
        list_issues = {
          lhs = "<C-s>il",
          desc = "list open issues on same repo",
        },
        reload = { lhs = "<C-s>u", desc = "reload PR" },
        open_in_browser = { lhs = "<C-s>y", desc = "open PR in browser" },
        copy_url = { lhs = "<C-s>y", desc = "copy url to system clipboard" },
        add_assignee = { lhs = "<C-s>aa", desc = "add assignee" },
        remove_assignee = { lhs = "<C-s>ad", desc = "remove assignee" },
        create_label = { lhs = "<C-s>lc", desc = "create label" },
        add_label = { lhs = "<C-s>la", desc = "add label" },
        remove_label = { lhs = "<C-s>ld", desc = "remove label" },
        goto_issue = {
          lhs = "<C-s>gi",
          desc = "navigate to a local repo issue",
        },
        add_comment = { lhs = "<C-s>ca", desc = "add comment" },
        delete_comment = { lhs = "<C-s>cd", desc = "delete comment" },
        next_comment = { lhs = "]c", desc = "go to next comment" },
        prev_comment = { lhs = "[c", desc = "go to previous comment" },
        react_hooray = { lhs = "<C-s>rp", desc = "add/remove 🎉 reaction" },
        react_heart = { lhs = "<C-s>rh", desc = "add/remove ❤️ reaction" },
        react_eyes = { lhs = "<C-s>re", desc = "add/remove 👀 reaction" },
        react_thumbs_up = { lhs = "<C-s>ru", desc = "add/remove 👍 reaction" },
        react_thumbs_down = {
          lhs = "<C-s>rd",
          desc = "add/remove 👎 reaction",
        },
        react_rocket = { lhs = "<C-s>rr", desc = "add/remove 🚀 reaction" },
        react_laugh = { lhs = "<C-s>rl", desc = "add/remove 😄 reaction" },
        react_confused = { lhs = "<C-s>rc", desc = "add/remove 😕 reaction" },
      },
      review_thread = {
        goto_issue = {
          lhs = "<C-s>gi",
          desc = "navigate to a local repo issue",
        },
        add_comment = { lhs = "<C-s>ca", desc = "add comment" },
        add_suggestion = { lhs = "<C-s>sa", desc = "add suggestion" },
        delete_comment = { lhs = "<C-s>cd", desc = "delete comment" },
        next_comment = { lhs = "]c", desc = "go to next comment" },
        prev_comment = { lhs = "[c", desc = "go to previous comment" },
        select_next_entry = {
          lhs = "]q",
          desc = "move to previous changed file",
        },
        select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
        close_review_tab = { lhs = "<C-s>", desc = "close review tab" },
        react_hooray = { lhs = "<C-s>rp", desc = "add/remove 🎉 reaction" },
        react_heart = { lhs = "<C-s>rh", desc = "add/remove ❤️ reaction" },
        react_eyes = { lhs = "<C-s>re", desc = "add/remove 👀 reaction" },
        react_thumbs_up = { lhs = "<C-s>r+", desc = "add/remove 👍 reaction" },
        react_thumbs_down = {
          lhs = "<C-s>r-",
          desc = "add/remove 👎 reaction",
        },
        react_rocket = { lhs = "<C-s>rr", desc = "add/remove 🚀 reaction" },
        react_laugh = { lhs = "<C-s>rl", desc = "add/remove 😄 reaction" },
        react_confused = { lhs = "<C-s>rc", desc = "add/remove 😕 reaction" },
      },
      submit_win = {
        approve_review = { lhs = "<C-s>a", desc = "approve review" },
        comment_review = { lhs = "<C-s>c", desc = "comment review" },
        request_changes = { lhs = "<C-s>r", desc = "request changes review" },
        close_review_tab = { lhs = "q", desc = "close review tab" },
      },
      review_diff = {
        add_review_comment = {
          lhs = "<C-s>ca",
          desc = "add a new review comment",
        },
        add_review_suggestion = {
          lhs = "<C-s>sa",
          desc = "add a new review suggestion",
        },
        focus_files = {
          lhs = "<C-s>e",
          desc = "move focus to changed file panel",
        },
        toggle_files = {
          lhs = "<C-s>t",
          desc = "hide/show changed files panel",
        },
        next_thread = { lhs = "]t", desc = "move to next thread" },
        prev_thread = { lhs = "[t", desc = "move to previous thread" },
        select_next_entry = {
          lhs = "]q",
          desc = "move to previous changed file",
        },
        select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
        close_review_tab = { lhs = "q", desc = "close review tab" },
        toggle_viewed = { lhs = "<Tab>", desc = "toggle viewer viewed state" },
      },
      file_panel = {
        next_entry = { lhs = "j", desc = "move to next changed file" },
        prev_entry = { lhs = "k", desc = "move to previous changed file" },
        select_entry = {
          lhs = "<Cr>",
          desc = "show selected changed file diffs",
        },
        refresh_files = { lhs = "<C-s>u", desc = "refresh changed files panel" },
        focus_files = {
          lhs = "<C-s>e",
          desc = "move focus to changed file panel",
        },
        toggle_files = {
          lhs = "<C-s>t",
          desc = "hide/show changed files panel",
        },
        select_next_entry = {
          lhs = "]q",
          desc = "move to previous changed file",
        },
        select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
        close_review_tab = { lhs = "q", desc = "close review tab" },
        toggle_viewed = { lhs = "<Tab>", desc = "toggle viewer viewed state" },
      },
    },
  })
end

return M
