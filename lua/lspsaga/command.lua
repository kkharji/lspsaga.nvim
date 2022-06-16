local command = {}
local provider = require "lspsaga.provider"
local lsprename = require "lspsaga.rename"
local lsphover = require "lspsaga.hover"
local diagnostic = require "lspsaga.diagnostic"
local codeaction = require "lspsaga.codeaction"
local signature = require "lspsaga.signaturehelp"
local implement = require "lspsaga.implement"

local subcommands = {
  lsp_finder = provider.lsp_finder,
  preview_definition = provider.preview_definition,
  rename = lsprename.rename,
  hover_doc = lsphover.render_hover_doc,
  show_cursor_diagnostics = diagnostic.show_cursor_diagnostics,
  show_line_diagnostics = diagnostic.show_line_diagnostics,
  yank_line_diagnostics = diagnostic.yank_line_messages,
  diagnostic_jump_next = diagnostic.navigate "next",
  diagnostic_jump_prev = diagnostic.navigate "prev",
  code_action = codeaction.code_action,
  range_code_action = codeaction.range_code_action,
  signature_help = signature.signature_help,
  implement = implement.lspsaga_implementation,
  toggle_virtual_text = diagnostic.toggle_virtual_text,
}

function command.command_list()
  return vim.tbl_keys(subcommands)
end

function command.load_command(cmd, ...)
  local args = { ... }
  if next(args) ~= nil then
    subcommands[cmd](args[1])
  else
    subcommands[cmd]()
  end
end

return command
