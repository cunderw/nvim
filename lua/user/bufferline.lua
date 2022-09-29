local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup({
  options = {
    numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
    buffer_close_icon = "",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
    diagnostics_update_in_insert = false,
    offsets = {
      {
        filetype = "NvimTree",
        text = "Explorer",
        padding = 1,
        highlight = "Directory",
        text_align = "left"
      },
    },
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    separator_style = "thin", -- { '', '' }, -- | "thick" | "thin" | { 'any', 'any' },
    always_show_bufferline = true,
    custom_filter = function(buf_number, buf_numbers)
      -- filter out filetypes you don't want to see
      -- if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
      --   return true
      -- end
      -- filter out by buffer name
      if vim.fn.bufname(buf_number) ~= "[dap-repl]" then
        return true
      end
    end,
    groups = {
      items = {
        {
          name = "Proto",
          highlight = { underline = true, sp = "blue" },
          auto_close = true,
          icon = "",
          priority = 2,
          matcher = function(buf)
            return buf.name:match("%.proto")
          end,
        },
        {
          name = "Tests",
          highlight = { underline = true, sp = "blue" },
          auto_close = true,
          icon = "",
          priority = 3,
          matcher = function(buf)
            return buf.name:match("%_test") or buf.name:match("%_spec")
          end,
        },
      },
    },
  },
})
