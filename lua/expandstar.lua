local M = {}
local keys = {}
local init_flag = true

local function init_keys()
  local last_pattern = vim.fn.getreg("/")
  for old_key, _ in string.gmatch(last_pattern, "\\<(.-)\\>") do
    keys[old_key] = old_key
  end
end

local function toggle_key()
  local cword = vim.fn.expand('<cword>')
  if keys[cword] ~= nil then
    keys[cword] = nil
  else
    keys[cword] = cword
  end
end

local function del_keys()
  keys = {}
  vim.fn.setreg("/", "")
  vim.opt.hlsearch = false
end

local function show_hilight()
  if init_flag == true then
    init_flag = false
    init_keys()
  end
  local make_pattern = function ()
    local pattern = ""
    if next(keys) == nil then
      goto exit
    end
    for _,key in pairs(keys) do
      pattern = string.format("%s\\<%s\\>\\|", pattern, key)
    end
    pattern = string.sub(pattern, 1, -3)
    ::exit::
    return pattern
  end

	-- @/ = last_pattern
  vim.fn.setreg("/", make_pattern())
  vim.opt.hlsearch = true
end

local function star_command()
  toggle_key()
  show_hilight()
end

M.debug = function ()
  vim.pretty_print(keys)
end

M.setup = function ()
  vim.keymap.set('n', '*', star_command, {desc="expendstar toggle"})
  vim.keymap.set('n', '#', show_hilight, {desc="expendstar show"})
  vim.keymap.set('n', 'd*', del_keys, {desc="expendstar del all"})
end

return M
