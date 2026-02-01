local function convertWordUnderCursor(word)
  -- Get the current line and cursor position
  local line = vim.fn.line(".")
  local col = vim.fn.col(".")

  -- Get the word under the cursor using a regular expression
  local currentWord = vim.fn.expand("<cword>")

  -- Convert the word to snake case
  -- local word = camelToSnake(currentWord)

  -- Replace the word in the current line
  vim.fn.setline(
    line,
    vim.fn.substitute(vim.fn.getline(line), "\\V" .. vim.fn.escape(currentWord, "\\") .. "\\>", word, "")
  )

  -- Move the cursor to the end of the replaced word
  vim.fn.cursor({ line, col + #word - #currentWord })
end

-- CONVERT CAMEL CASE TO SNAKE CASE
function CamelToSnake()
  -- Get the word under the cursor using a regular expression
  local camelCase = vim.fn.expand("<cword>")

  local snakeCase = camelCase:sub(1, 1) -- Convert the first letter to lowercase
  snakeCase = snakeCase .. camelCase:sub(2):gsub("%u", function(c)
    return "_" .. c:lower()
  end)
  convertWordUnderCursor(snakeCase)
end

function SnakeToCamel()
  local snakeCase = vim.fn.expand("<cword>")
  local camelCase = snakeCase:gsub("_(%l)", string.upper)
  convertWordUnderCursor(camelCase)
end

vim.api.nvim_create_user_command("ConvertSnakeCase", function()
  CamelToSnake()
end, {})
vim.api.nvim_create_user_command("ConvertCamelCase", function()
  SnakeToCamel()
end, {})

local function hexToRgb(hex)
  hex = hex:gsub("#", "")
  return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end

local function rgbToHsl(hex)
  local r, g, b = hexToRgb(hex)
  r, g, b = r / 255, g / 255, b / 255

  local max, min = math.max(r, g, b), math.min(r, g, b)
  local h, s, l

  l = (max + min) / 2

  if max == min then
    h, s = 0, 0 -- achromatic
  else
    local d = max - min
    s = l > 0.5 and d / (2 - max - min) or d / (max + min)
    if max == r then
      h = (g - b) / d + ((g - b) < 0 and 6 or 0)
    elseif max == g then
      h = (b - r) / d + 2
    else
      print(r, g, d, h)
      h = (r - g) / d + 4
    end
    h = h / 6
  end

  return h * 360, s * 100, l * 100
end
function GetHslValue()
  -- Get color from clipboard
  local clipboard_content = vim.fn.getreg("*")
  -- Check if the content is a hex color code
  local hexColor = clipboard_content:match("#%x%x%x%x%x%x")
  if hexColor then
    local h, s, l = rgbToHsl(hexColor)
    -- h = h * 255
    -- s = s * 100
    -- l = l * 100
    -- print(string.format("Hex: %s", hexColor))
    local result = string.format("%.3f %i%% %i%%", h, s, l)

    -- Get the current buffer number and cursor position
    local cursor_pos = vim.fn.getpos(".")
    -- Insert the line under the cursor
    vim.api.nvim_buf_set_text(0, cursor_pos[2] - 1, cursor_pos[3] - 1, cursor_pos[2] - 1, cursor_pos[3] - 1, { result })
  else
    print("Clipboard content is not a valid hex color code.")
  end
end

vim.api.nvim_create_user_command("GetHslValue", "lua  GetHslValue()", {})
vim.api.nvim_create_user_command("GenSecret", function()
  local sercert = vim.fn.system([[node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"]])
  local cursor_pos = vim.fn.getpos(".")
  -- Insert the line under the cursor
  vim.api.nvim_buf_set_text(0, cursor_pos[2] - 1, cursor_pos[3] - 1, cursor_pos[2] - 1, cursor_pos[3] - 1, { sercert })
end, {})

local function wrap_try_catch()
  -- Get the start and end lines of the visual selection
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")

  -- Get the selected lines as a table
  local selected_lines = vim.fn.getline(start_line, end_line)

  -- Define the try-catch block
  local try_catch_block = {
    "try {",
  }

  -- Add the selected lines, indented
  ---@diagnostic disable-next-line: param-type-mismatch
  for _, line in ipairs(selected_lines) do
    table.insert(try_catch_block, "    " .. line)
  end

  -- Add the catch block
  table.insert(try_catch_block, "} catch (err) {")
  table.insert(try_catch_block, "    console.error(err);")
  table.insert(try_catch_block, "}")

  -- Replace the selected lines with the try-catch block
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, try_catch_block)
end
-- Create a custom command to call the function
vim.api.nvim_create_user_command("WrapTryCatch", wrap_try_catch, { range = true })
