return {
	"beauwilliams/focus.nvim",
	enabled = true,
	config = function()
		require("focus").setup()
	end,
	event = "VeryLazy",
}
