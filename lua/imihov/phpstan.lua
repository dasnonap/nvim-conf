local io = require("io")

-- Checks if File Exists
function checkFileExists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

-- Create PHP Stan config located in the root of the CWD, because phpstan needs to know where to index
function createPhpStanConfig()
	local hasPhpStanConfig = checkFileExists("phpstan.neon")
	if hasPhpStanConfig == false then
		local fileHandler = io.open("phpstan.neon", "w")
		fileHandler:write("parameters:\n")
		fileHandler:write("\tlevel: 10\n")
		fileHandler:write("\tpaths:\n")
		fileHandler:write("\t\t - wp-includes\n")
		fileHandler:write("\t\t - wp-content\n")
		fileHandler:close()
	end
end

-- Hook event on only PHP files
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.php" },
	callback = createPhpStanConfig,
})
