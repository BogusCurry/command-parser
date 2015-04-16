
--- Parse given comment into arguments and flags
-- @param ...
-- @return args, flags
function parseArgs(...)
  local str = table.concat({...}, " ");
  local args = {};
  local flags = {};

  local function grabQuoted(str)
    local prevChar = nil;

    --first char is known "
    for i = 2, #str do
      ch = string.sub(str, i, i);
      if ch == "\"" and prevChar ~= "\\" then
        --end quote
        return string.sub(str, 2, i - 1), string.sub(str, i + 1, #str);
      end
      prevChar = ch;
    end

    -- unterminated quoted string
    return str, "";
  end

  --strip whitespace
  while str and #str > 0 do
    str = string.match(str, "%s*(.*)");
    local ch = string.sub(str, 1, 1);

    if ch == "-" then
      --flag
      local flag, eq, farg, rest;

      flag, eq, rest = string.match(str, "-(%w)(=?)(.*)");
      farg = "";

      if not flag then
        error("invalid arguments!");
      end

      if eq ~= "" then
        --there'll be a parameter
        if string.sub(rest, 1, 1) == "\"" then
          farg, rest = grabQuoted(rest);
        else
          farg, rest = string.match(rest, "(%S+)%s*(.*)");
        end
      end

      flags[flag] = farg;
      str = rest;

    elseif ch == "\"" then
      --literal string
      args[#args + 1], str = grabQuoted(str);
    else
      --regular param
      args[#args + 1], str = string.match(str, "(%S+)%s*(.*)");
    end
  end

  return args, flags;
end

