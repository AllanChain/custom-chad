local has_project, project = pcall(require, "project_nvim")

local M = {}

M.section_header = {
  type = "text",
  val = {
    [[                                                                       ]],
    [[  ██████   █████                   █████   █████  ███                  ]],
    [[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
    [[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
    [[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
    [[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
    [[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
    [[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
    [[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
  },
  opts = {
    position = "center",
    hl = "String",
  },
}

function M.open_project(project_path)
  local success = require("project_nvim.project").set_pwd(project_path, "alpha")
  if not success then
    return
  end
  require("telescope.builtin").find_files {
    cwd = project_path,
  }
end

function M.recent_projects(start)
  if start == nil then
    start = 1
  end
  if not has_project then
    return require("alpha.themes.theta").mru(start, vim.fn.getcwd())
  end
  local buttons = {}
  local project_paths = project.get_recent_projects()
  local added_projects = 0
  -- most recent project is the last
  for i = #project_paths, 1, -1 do
    if added_projects == 9 then
      break
    end
    local project_path = project_paths[i]
    local stat = vim.loop.fs_stat(project_path .. "/.git")
    if stat ~= nil and stat.type == "directory" then
      added_projects = added_projects + 1
      local shortcut = tostring(added_projects)
      buttons[added_projects] = {
        type = "button",
        val = project_path,
        on_press = function()
          M.open_project(project_path)
        end,
        opts = {
          position = "center",
          shortcut = shortcut,
          cursor = 48,
          width = 50,
          align_shortcut = "right",
          hl_shortcut = "Keyword",
          keymap = {
            "n",
            shortcut,
            "<cmd>lua require('custom.plugins.alpha').open_project('" .. project_path .. "')<CR>",
            { noremap = true, silent = true, nowait = true },
          },
        },
      }
    end
  end
  return buttons
end

M.section_projects = {
  type = "group",
  val = {
    {
      type = "text",
      val = "Recent Projects",
      opts = {
        hl = "SpecialComment",
        shrink_margin = false,
        position = "center",
      },
    },
    { type = "padding", val = 1 },
    { type = "group", val = M.recent_projects },
  },
}

function M.footer_text()
  ---@diagnostic disable-next-line:undefined-field
  local total_plugins = #vim.tbl_keys(_G.packer_plugins)
  local datetime = os.date " %Y-%m-%d   %H:%M:%S"
  local version = vim.version()
  local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

  return datetime .. "   " .. total_plugins .. " plugins" .. nvim_version_info
end

M.section_footer = {
  type = "text",
  val = M.footer_text(),
  opts = {
    hl = "Constant",
    position = "center",
  },
}

function M.shortcuts()
  local keybind_opts = { silent = true, noremap = true }
  vim.api.nvim_create_autocmd({ "User AlphaReady" }, {
    callback = function(_)
      vim.api.nvim_buf_set_keymap(0, "n", "p", "<cmd>Telescope projects<CR>", keybind_opts)
      vim.api.nvim_buf_set_keymap(0, "n", "t", "<cmd>Telescope themes<CR>", keybind_opts)
      vim.api.nvim_buf_set_keymap(0, "n", "s", "<cmd>e $MYVIMRC<CR>", keybind_opts)
      vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>q<CR>", keybind_opts)
    end,
  })
  return {
    {
      type = "text",
      val = {
        " Project [p]     Themes [t]     Settings [s]    󰅚 Quit [q]",
      },
      opts = {
        position = "center",
        hl = {
          { "String", 1, 20 },
          { "Keyword", 20, 38 },
          { "Function", 38, 60 },
          { "Constant", 60, 80 },
        },
      },
    },
  }
end

M.section_shortcuts = { type = "group", val = M.shortcuts }

M.config = {
  layout = {
    M.section_header,
    { type = "padding", val = 1 },
    M.section_projects,
    { type = "padding", val = 2 },
    M.section_shortcuts,
    { type = "padding", val = 1 },
    M.section_footer,
  },
}

return M
