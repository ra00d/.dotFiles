local function convertWordUnderCursor(word)
  -- Get the current line and cursor position
  local line = vim.fn.line "."
  local col = vim.fn.col "."

  -- Get the word under the cursor using a regular expression
  local currentWord = vim.fn.expand "<cword>"

  -- Convert the word to snake case
  -- local word = camelToSnake(currentWord)

  -- Replace the word in the current line
  vim.fn.setline(
    line,
    vim.fn.substitute(vim.fn.getline(line), "\\V" .. vim.fn.escape(currentWord, "\\") .. "\\>", word, "")
  )

  -- Move the cursor to the end of the replaced word
  vim.fn.cursor { line, col + #word - #currentWord }
end

-- CONVERT CAMEL CASE TO SNAKE CASE
function CamelToSnake()
  -- Get the word under the cursor using a regular expression
  local camelCase = vim.fn.expand "<cword>"

  local snakeCase = camelCase:sub(1, 1) -- Convert the first letter to lowercase
  snakeCase = snakeCase .. camelCase:sub(2):gsub("%u", function(c)
    return "_" .. c:lower()
  end)
  convertWordUnderCursor(snakeCase)
end

function SnakeToCamel()
  local snakeCase = vim.fn.expand "<cword>"
  local camelCase = snakeCase:gsub("_(%l)", string.upper)
  convertWordUnderCursor(camelCase)
end

vim.api.nvim_create_user_command("ConvertSnakeCase", function()
  CamelToSnake()
end, {})
vim.api.nvim_create_user_command("ConvertCamelCase", function()
  SnakeToCamel()
end, {})
