-- local ok, code_runner = pcall(require, "code_runner")
--
-- if not ok then
-- 	return
-- end

local code_runner = require("code_runner")

code_runner.setup({
  -- put here the commands by filetype
  filetype = {
		java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
		python = "python3 -u",
		typescript = "deno run",
		rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt",
    julia = "julia",
	},
})
