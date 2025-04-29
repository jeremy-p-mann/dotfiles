local api = vim.api

-- Content

local function get_window()
    for _, win_id in ipairs(api.nvim_list_wins()) do
        local is_marked, marked =
            pcall(api.nvim_win_get_var, win_id, "is_my_sql_win")
        if is_marked and marked then
            return win_id
        end
    end
    return nil
end

local Job = require "plenary.job"

local function read_sql_file()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local lines_wo_comments = {}
    for _, line in ipairs(lines) do
        if string.find(line, [[%-%-]]) == nil then
            table.insert(lines_wo_comments, line)
        end
    end
    return lines_wo_comments
end

local function get_opts(lines)
    local max_line_length = 0
    for _, line in ipairs(lines) do
        max_line_length = math.max(max_line_length, #line)
    end
    local screen_width = vim.api.nvim_get_option "columns"
    local win_width = math.min(screen_width, max_line_length + 1)
    local win_height = math.ceil(vim.api.nvim_get_option "lines" * 0.4)
    local row = vim.api.nvim_get_option "lines" - win_height - 1
    local col = screen_width - win_width - 1
    return {
        style = "minimal",
        relative = "editor",
        width = win_width,
        height = win_height,
        row = row,
        col = col,
    }
end

local format_array = function(t)
    local columns = vim.split(t[1], "|")

    local terms = {}
    local max_key_length = {}
    for _, entry in ipairs(t) do
        entry = vim.split(entry, "|")
        table.insert(terms, entry)
        for i, _ in ipairs(columns) do
            local value = entry[i]
            if value then
                max_key_length[i] = math.max(max_key_length[i] or 0, #tostring(value))
            end
        end
    end

    local result_table = {}
    for _, entry in ipairs(terms) do
        local formatted = {}
        for i, value in ipairs(entry) do
            print(max_key_length[i])
            -- local to_format = "%-" .. tostring(max_key_length[i] or "") .. "s"
            local length = max_key_length[i]
            if  length > 99 then length = 99 end
            local to_format = "%-" .. tostring(length or "") .. "s"
            local to_insert = string.format(to_format, tostring(value or ""))
            table.insert(formatted, to_insert)
        end
        local formatted_string = table.concat(formatted, "|")
        table.insert(result_table, formatted_string)
    end
    return result_table
end

local function display_results_in_floating_window(results)
    local lines = vim.split(results, "\n")
    lines = format_array(lines)

    local win_id = get_window()

    local bufnr
    if win_id then
        bufnr = vim.api.nvim_win_get_buf(win_id)
    else
        bufnr = vim.api.nvim_create_buf(false, true)
        win_id = vim.api.nvim_open_win(bufnr, false, get_opts(lines))
        api.nvim_win_set_var(win_id, "is_my_sql_win", true)
    end
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end

local function display_error_in_floating_window(error_message)
    local lines = vim.split(error_message, "\n")

    local win_id = get_window()

    local bufnr
    if win_id then
        bufnr = vim.api.nvim_win_get_buf(win_id)
    else
        bufnr = vim.api.nvim_create_buf(false, true)
        win_id = vim.api.nvim_open_win(bufnr, false, get_opts(lines))
        api.nvim_win_set_var(win_id, "is_my_sql_win", true)
    end
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end

local M = {}
M.execute_sql_query_from_file = function()
    local db_path = os.getenv "CODEDIR" .. "/jer_health/bar.db"
    local sql_query = table.concat(read_sql_file(), " ")
    Job:new({
        command = "sqlite3",
        args = { "--header", db_path, sql_query },

        on_exit = function(j, return_val)
            vim.schedule(function()
                if return_val == 0 then
                    display_results_in_floating_window(table.concat(j:result(), "\n"))
                else
                    local error_msg = "Failed to execute query:\n"
                        .. table.concat(j:stderr_result(), "\n")
                    display_error_in_floating_window(error_msg)
                end
            end)
        end,
    }):start()
end
return M
