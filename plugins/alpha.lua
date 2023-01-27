local has_project, project = pcall(require, "project_nvim")

local M = {}

M.header = {
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

function M.footer_text()
  ---@diagnostic disable-next-line:undefined-field
  local total_plugins = #vim.tbl_keys(_G.packer_plugins)
  local datetime = os.date " %Y-%m-%d   %H:%M:%S"
  local version = vim.version()
  local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

  return datetime .. "   " .. total_plugins .. " plugins" .. nvim_version_info
end

function M.recent_projects(start)
  if start == nil then
    start = 1
  end
  if not has_project then
    return require("alpha.themes.theta").mru(start, vim.fn.getcwd())
  end
  local buttons = {}
  for i, project_path in pairs(project.get_recent_projects()) do
    if i > 9 then
      break
    end
    local shortcut = tostring(i - start + 1)
    buttons[i] = {
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
  return buttons
end

M.projects = {
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

M.config = {
  layout = {
    { type = "padding", val = 1 },
    M.header,
    { type = "padding", val = 2 },
    M.projects,
    { type = "padding", val = 2 },
    {
      type = "text",
      val = M.footer_text(),
      opts = {
        hl = "Constant",
        position = "center",
      },
    },
  },
  -- opts = {
  --   margin = 5,
  -- },
}

return M
