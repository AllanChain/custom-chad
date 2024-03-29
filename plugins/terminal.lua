--[[======================================================
--                       Terminal
--======================================================]]
return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VimEnter",
    config = function()
      local ok, toggleterm = pcall(require, "toggleterm")
      if not ok then
        return
      end
      toggleterm.setup {
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_terminals = false,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "float",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
        },
      }
    end,
  },
}
