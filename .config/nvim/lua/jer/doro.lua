local keymap = require "jer.keymaps"
local nremap = keymap.nremap

local notify = require("notify").notify

local get_current_time = function()
  return vim.fn.systemlist("date +%Y-%m-%dT%H:%M:%S%Z")[1]
end

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

local _csv_filepath = string.format("%s/doros.csv", vim.fn.stdpath "data")

-- timer

local format_time = function(time)
  local seconds_in_a_minute = 60
  local seconds = math.fmod(time, seconds_in_a_minute)
  local minutes = (time - seconds) / seconds_in_a_minute
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

-- local text = string.format("bool is %s", mod)
-- text = string.format(text .. "bool is %s", minutes)
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

local timer_length_opts = range(0, 600, 1)

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

-- doros

local default_doro = {
  name = "doro",
  duration = 10,
  remaining = 10,
  unit = "seconds",
  outcome = { name = "TBD", icon = "⏲️" },
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
  local msg = {
    start = "Timer set for \n" .. doro.duration .. " " .. doro.unit,
    ongoing = get_status_bar(doro)
      .. " \n"
      .. time.format_time(doro.remaining),
    finish = "Congrats, " .. doro.duration .. " second timer complete",
  }
  local titles = {
    start = "Doro " .. doro.name,
    ongoing = "Doro " .. doro.name,
    finish = doro.name .. " Complete",
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
  doro.notification_window = notify(cont.msg, cont.status, opts)
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
  vim.ui.select(
    time.length_ops,
    { prompt = "Doro Duration: " },
    function(duration)
      doro = _set_doro_value(doro, "duration", duration)
      doro = _set_doro_value(doro, "remaining", duration)
      callback(doro)
    end
  )
end

local change_doro_outcome = function(doro, callback)
  local opts = {
    prompt = "Rate experience of " .. doro.name,
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
  local cmd = 'echo "' .. row_string .. '" >> ' .. _csv_filepath
  vim.fn.system(cmd)
end

local _get_all_doros = function()
  local ans = {}
  local raw_results = vim.fn.systemlist("cat " .. _csv_filepath)
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
  for _, doro in ipairs(all_doros) do
    local info = describe_doro(doro)
    table.insert(names, info)
  end
  local opts = { prompt = "Past Doros" }
  vim.ui.select(names, opts, function(choice) end)
end

nremap("<leader>dd", do_doro, "Do a doro")
nremap("<leader>dr", show_doros, "Do a doro")
