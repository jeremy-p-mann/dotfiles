local keymap = require "jer.keymaps"
local nremap = keymap.nremap

local notify = require("notify").notify

IS_HIDDEN = false

local get_current_time = function()
  return vim.fn.systemlist("date +%Y-%m-%dT%H:%M:%S%Z")[1]
end

vim.cmd [[
    hi default SOMETHING guifg=#4F6752
  ]]

local get_status_bar = function(doro)
  local progress = doro.remaining / doro.duration
  local ans = "["
  for i = 1, 10 do
    local value = i / 10
    if value <= progress then
      ans = ans .. "="
    else
      ans = ans .. "-"
    end
  end
  ans = ans .. "]"
  return ans
end

local fields = {
  "name",
  "duration",
  "remaining",
  "unit",
  "outcome",
  "datetime",
}

local get_config = function()
  return { csv_filepath = string.format("%s/doros.csv", vim.fn.stdpath "data") }
end

-- timer

local format_time = function(time_seconds)
  local seconds_in_a_minute = 60
  local seconds = math.fmod(time_seconds, seconds_in_a_minute)
  local minutes = (time_seconds - seconds) / seconds_in_a_minute
  local minutes_str = string.format("%s", minutes)
  local seconds_str = string.format("%s", seconds)
  if seconds < 10 then
    seconds_str = "0" .. seconds
  end
  if minutes < 10 then
    minutes_str = "0" .. minutes
  end
  return minutes_str .. ":" .. seconds_str
end

local range = function(start, stop, step)
  local ans = {}
  local value = start
  local index = 1
  while value <= stop do
    ans[index] = value
    value = value + step
    index = index + 1
  end
  return ans
end

local timer_length_opts = {}
for _, second in pairs(range(0, 600, 1)) do
  table.insert(
    timer_length_opts,
    { value = second, text = format_time(second) }
  )
end

local start_timer = function(callback, interval)
  local timer = vim.loop.new_timer()
  local function ontimeout()
    callback(timer)
  end
  vim.loop.timer_start(timer, interval, interval, ontimeout)
  return timer
end

local stop_timer = function(timer)
  vim.loop.timer_stop(timer)
  vim.loop.close(timer)
end

local time = {
  stop_timer = stop_timer,
  start_timer = start_timer,
  length_ops = timer_length_opts,
  one_second = 1000,
  format_time = format_time,
}

local create_window = function(content)
  local ui = vim.api.nvim_list_uis()[1]
  local buf = vim.api.nvim_create_buf(false, true)
  local ref_width = ui.width
  local ref_height = ui.height
  local rel_width = 0.2
  local rel_height = 0.2
  local width = math.floor(ref_width * rel_width)
  local height = math.floor(ref_height * rel_height)
  local col = ui.width - (width / 2)
  local row = ui.height - (height / 2)
  local opts = {
    relative = "editor",
    width = width,
    height = 4,
    col = col,
    row = row,
    style = "minimal",
    -- border = "rounded",
  }
  vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
  vim.api.nvim_buf_set_lines(buf, 0, -1, true, content)
  local window = vim.api.nvim_open_win(buf, false, opts)
  vim.api.nvim_win_set_option(
    window,
    "winhl",
    "Normal:SOMETHING,FloatBorder:SOMETHING"
  )
  return window
end

local set_content = function(lines, window)
  local buf = vim.api.nvim_win_get_buf(window)
  vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)
  return window
end

local set_doro_window_content = function(content, doro)
  if IS_HIDDEN then
    if doro.window ~= nil then
      vim.api.nvim_win_close(doro.window, true)
      doro.window = nil
    end
  else
    if doro.window == nil then
      doro.window = create_window(content)
    else
      doro.window = set_content(content, doro.window)
    end
  end
  return doro
end
-- doros

local default_doro = {
  name = "doro",
  duration = 5,
  remaining = 5,
  unit = "seconds",
  outcome = { name = "TBD", icon = "⏲️ " },
  notification_window = nil,
  datetime = nil,
  window = nil,
}

local describe_doro = function(doro)
  local info = doro.name
    .. " | "
    .. doro.duration
    .. " seconds | "
    .. doro.outcome.icon
    .. " | "
    .. doro.outcome.name
    .. " | "
    .. doro.datetime
  return info
end

local outcomes = {
  { name = "spaghetti", icon = "🍝" },
  { name = "tomato", icon = "🍅" },
  { name = "clown", icon = "🤡" },
}

local get_outcome_from_name = function(name)
  for _, outcome in ipairs(outcomes) do
    if outcome.name == name then
      return outcome
    end
  end
end

local get_stage = function(doro)
  if doro.remaining >= doro.duration then
    return "start"
  elseif doro.remaining <= 0 then
    return "finish"
  else
    return "ongoing"
  end
end

local get_notification_content = function(doro)
  local f_duration = time.format_time(doro.duration)
  local msg = {
    start = f_duration,
    ongoing = get_status_bar(doro)
      .. " \n"
      .. time.format_time(doro.remaining)
      .. " of "
      .. f_duration,
    finish = f_duration .. " complete",
  }
  local titles = {
    start = doro.name,
    ongoing = doro.name,
    finish = doro.name,
  }
  local status = {
    start = "info",
    ongoing = "info",
    finish = "info",
  }
  local assemble_content = function(stage)
    return {
      msg = msg[stage],
      title = titles[stage],
      status = status[stage],
      icon = doro.outcome.icon,
    }
  end
  return assemble_content(get_stage(doro))
end

-- doro transformers

local update_doro_notification = function(doro)
  local cont = get_notification_content(doro)
  local opts = {
    title = cont.title,
    timeout = false,
    icon = cont.icon,
    replace = doro.notification_window,
  }
  local content = { opts.icon .. " " .. opts.title }
  local body = vim.split(cont.msg, "\n")
  table.insert(content, "")
  for _, line in pairs(body) do
    table.insert(content, line)
  end
  doro = set_doro_window_content(content, doro)
  return doro
end

local _set_doro_value = function(doro, property, value)
  local new_values = value
  doro[property] = new_values
  doro = update_doro_notification(doro)
  return doro
end

local start_doro_timer = function(doro, callback)
  local timer
  local increment_callback = function()
    vim.schedule(function()
      _set_doro_value(doro, "remaining", doro.remaining - 1)
      if doro.remaining <= 0 then
        time.stop_timer(timer)
        callback(doro)
      end
    end)
  end
  timer = time.start_timer(increment_callback, time.one_second)
end

local change_doro_name = function(doro, callback)
  vim.ui.input({ prompt = "Doro Name: " }, function(name)
    doro = _set_doro_value(doro, "name", name)
    callback(doro)
  end)
end

local change_doro_duration = function(doro, callback)
  vim.ui.select(time.length_ops, {
    prompt = "Doro Duration: ",
    format_item = function(duration)
      return duration.text
    end,
  }, function(duration)
    local duration_seconds = duration.value
    doro = _set_doro_value(doro, "duration", duration_seconds)
    doro = _set_doro_value(doro, "remaining", duration_seconds)
    callback(doro)
  end)
end

local change_doro_outcome = function(doro, callback)
  local opts = {
    prompt = "Complete! Rate experience of " .. doro.name,
    format_item = function(outcome)
      return outcome.icon
    end,
  }
  local select_callback = function(outcome)
    _set_doro_value(doro, "outcome", outcome)
    callback(doro)
  end
  local outcome = vim.ui.select(outcomes, opts, select_callback)
  return outcome
end

local _persist_doro_to_csv = function(doro)
  local row_string
  local csv_filepath = get_config().csv_filepath
  for index, field in ipairs(fields) do
    local value = doro[field]
    if field == "outcome" then
      value = value.name
    end
    if field == "datetime" then
      value = get_current_time()
    end
    if index == 1 then
      row_string = value
    else
      row_string = row_string .. "," .. value
    end
  end
  local cmd = 'echo "' .. row_string .. '" >> ' .. csv_filepath
  vim.fn.system(cmd)
end

local _get_all_doros = function()
  local csv_filepath = get_config().csv_filepath
  local ans = {}
  local raw_results = vim.fn.systemlist("cat " .. csv_filepath)
  for i, cs_string in pairs(raw_results) do
    if i > 1 then
      local split_string = vim.split(cs_string, ",")
      local record = {}
      for index, field_to_record in pairs(fields) do
        local value = split_string[index]
        if field_to_record == "outcome" then
          value = get_outcome_from_name(value)
        end
        record[field_to_record] = value
      end
      table.insert(ans, record)
    end
  end
  return ans
end

local record_doro = function(doro, callback)
  -- table.insert(all_doros, doro)
  _persist_doro_to_csv(doro)
  callback(doro)
end

local do_nothing = function(doro)
  return doro
end

local compose_doro_tranformations = function(functions)
  local ans = {}
  if #functions == 0 then
    return do_nothing
  end
  local reversed_functions = {}
  for i = 1, #functions do
    table.insert(reversed_functions, functions[#functions - i + 1])
  end
  for index, doro_trans in ipairs(reversed_functions) do
    if index == 1 then
      table.insert(ans, function(doro)
        doro_trans(doro, do_nothing)
      end)
    else
      local next_function = function(doro)
        doro_trans(doro, ans[index - 1])
      end
      table.insert(ans, next_function)
    end
  end
  return ans[#functions]
end

local doro_transformations = {
  change_doro_name,
  change_doro_duration,
  start_doro_timer,
  change_doro_outcome,
  record_doro,
}

local create_doro = function(opts)
  local ans = {}
  for key, value in pairs(default_doro) do
    ans[key] = value
  end
  for key, value in pairs(opts) do
    ans[key] = value
  end
  ans = update_doro_notification(ans)
  return ans
end

local do_doro = function()
  local doro = create_doro {}
  local transformations = compose_doro_tranformations(doro_transformations)
  doro = transformations(doro)
end

local show_doros = function()
  local names = {}
  local all_doros = _get_all_doros()
  for index, _ in ipairs(all_doros) do
    local info = describe_doro(all_doros[#all_doros - index + 1])
    table.insert(names, info)
  end
  local opts = { prompt = "Past Doros" }
  vim.ui.select(names, opts, function(choice) end)
end

local toggle_doro = function()
  IS_HIDDEN = not IS_HIDDEN
end

nremap("<leader>dd", do_doro, "Do a doro")
nremap("<leader>dr", show_doros, "Do a doro")
nremap("<leader>dh", toggle_doro, "Hide a doro")
