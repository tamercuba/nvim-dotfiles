return {              -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()
    local wki = 'which_key_ignore'
    -- Document existing key chains
    require('which-key').register {
      { "<leader>f",  group = "[F]ind" },
      { "<leader>f_", hidden = true },
      { "<leader>g",  group = "[G]it" },
      { "<leader>g_", hidden = true },
      { "<leader>v",  group = "LSP" },
      { "<leader>v_", hidden = true },
      {
        { "<leader>h", desc = "Git [H]unk", mode = "v" },
      }
    }
  end,
}
