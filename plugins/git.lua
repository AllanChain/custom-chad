--[[======================================================
--               Git and version control
--======================================================]]
return {
  {
    "akinsho/git-conflict.nvim",
    event = "BufReadPost",
    opts = {
      default_mappings = false,
      disable_diagnostics = true,
      highlights = {
        incoming = "ConflictIncoming",
        current = "ConflictCurrent",
      },
    },
    config = function(_, opts)
      local ok, gc = pcall(require, "git-conflict")
      if not ok then
        return
      end
      gc.setup(opts)
    end,
  },
}
