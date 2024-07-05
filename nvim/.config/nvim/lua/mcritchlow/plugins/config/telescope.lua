local ok, telescope = pcall(require, "telescope")

if not ok then
  return
end

local actions = require('telescope.actions')
local action_state = require("telescope.actions.state")

local custom_actions = {}

function custom_actions.fzf_multi_select(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = table.getn(picker:get_multi_selection())

  if num_selections > 1 then
    -- actions.file_edit throws - context of picker seems to change
    --actions.file_edit(prompt_bufnr)
    actions.send_selected_to_qflist(prompt_bufnr)
    actions.open_qflist()
  else
    actions.file_edit(prompt_bufnr)
  end
end

telescope.setup {
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  },
  pickers = {
    find_files = {
      find_command = { "fd", "--ignore", "-L", "-tf", "-tl", "--strip-cwd-prefix" }
    },
  },
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
      width = 0.75,
      prompt_position = "bottom",
      preview_cutoff = 120,
    },
    file_sorter = require 'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require 'telescope.sorters'.get_generic_fuzzy_sorter,
    path_display = {
      "absolute",
    },
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-x>"] = false,
        ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
        ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
        ["<cr>"] = custom_actions.fzf_multi_select,
        ["<C-q>"] = actions.send_to_qflist,
      },
      n = {
        ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
        ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
        ["<cr>"] = custom_actions.fzf_multi_select
      }
    }
  }
}
-- Use fzf extension for telescope
require('telescope').load_extension('fzf')
-- Git coauthors (which-key mapping in mappings.lua)
require('telescope').load_extension('githubcoauthors')

M = {}

M.search_dotfiles = function()
  require("telescope.builtin").find_files({
    prompt_title = "< VimRC >",
    cwd = "$HOME/projects/personal/dotfiles",
  })
end

-- Action to get the git commit sha hash
local action_state = require('telescope.actions.state')
local function copy_commit_sha(prompt_bufnr)
  local selection = action_state.get_selected_entry()
  actions.close(prompt_bufnr)
  vim.fn.setreg("+", selection.value)
  print("Copied commit: " .. selection.value .. " to clipboard")
end

-- Extend git_commits builtin with ability to copy commit hash
M.git_commits_with_sha = function()
  require("telescope.builtin").git_commits({ attach_mappings = function(_, map)
    map('i', '<c-y>', copy_commit_sha)
    map('n', '<c-y>', copy_commit_sha)
    return true
  end })
end

M.file_browser = function()
  require("telescope.builtin").file_browser({ attach_mappings = function(_, map)
    local function set_new_wd(prompt_bufnr)
      local dir = actions.get_selected_entry(prompt_bufnr).value
      vim.fn.execute("cd " .. dir, "silent")
      actions.close(prompt_bufnr)
      print("Change working directory to : " .. dir)
    end

    map('i', '<c-g>', set_new_wd)
    map('n', '<c-g>', set_new_wd)

    return true
  end })
end

-- Choose config module to reload
M.reload = function()
  local utils = require("mcritchlow.utils")
  -- Telescope will give us something like mcritchlow/utils.lua,
  -- so this function convert the selected entry to
  -- the module name: mcritchlow.utils
  local function get_module_name(s)
    local module_name;

    module_name = s:gsub("%.lua", "")
    module_name = module_name:gsub("%/", ".")
    module_name = module_name:gsub("%.init", "")

    return module_name
  end

  local prompt_title = "~ neovim modules ~"

  -- sets the path to the lua folder
  local path = "$HOME/.config/nvim/lua"

  local opts = {
    prompt_title = prompt_title,
    cwd = path,

    attach_mappings = function(_, map)
      -- Adds a new map to ctrl+e.
      map("i", "<c-e>", function(_)
        vim.notify("Reloading module..", vim.log.levels.INFO)
        -- these two a very self-explanatory
        local entry = require("telescope.actions.state").get_selected_entry()
        local name = get_module_name(entry.value)

        -- call the helper method to reload the module
        utils.reload_module(name)
        vim.notify(name .. " reloaded!", vim.log.levels.INFO)
      end)

      return true
    end
  }

  -- call the builtin method to list files
  require('telescope.builtin').find_files(opts)
end

return M
