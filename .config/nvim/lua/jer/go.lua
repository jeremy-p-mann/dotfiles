local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local previewers = require "telescope.previewers"
local previewer_utils = require "telescope.previewers.utils"
-- TODO: do smth if doesn't have
local has_plenary, Job = pcall(require, "plenary.job")

local packages = {
  "archive/tar",
  "archive/zip",
  "bufio",
  "bytes",
  "compress/bzip2",
  "compress/flate",
  "compress/gzip",
  "compress/lzw",
  "compress/zlib",
  "container/heap",
  "container/list",
  "container/ring",
  "context",
  "crypto",
  "crypto/aes",
  "crypto/cipher",
  "crypto/des",
  "crypto/dsa",
  "crypto/ecdh",
  "crypto/ecdsa",
  "crypto/ed25519",
  "crypto/elliptic",
  "crypto/hmac",
  "crypto/md5",
  "crypto/rand",
  "crypto/rc4",
  "crypto/rsa",
  "crypto/sha1",
  "crypto/sha256",
  "crypto/sha512",
  "crypto/subtle",
  "crypto/tls",
  "crypto/x509",
  "crypto/x509/pkix",
  "database/sql",
  "database/sql/driver",
  "debug/buildinfo",
  "debug/dwarf",
  "debug/elf",
  "debug/gosym",
  "debug/macho",
  "debug/pe",
  "debug/plan9obj",
  "embed",
  "encoding",
  "encoding/ascii85",
  "encoding/asn1",
  "encoding/base32",
  "encoding/base64",
  "encoding/binary",
  "encoding/csv",
  "encoding/gob",
  "encoding/hex",
  "encoding/json",
  "encoding/pem",
  "encoding/xml",
  "errors",
  "expvar",
  "flag",
  "fmt",
  "go/ast",
  "go/build",
  "go/build/constraint",
  "go/constant",
  "go/doc",
  "go/doc/comment",
  "go/format",
  "go/importer",
  "go/parser",
  "go/printer",
  "go/scanner",
  "go/token",
  "go/types",
  "hash",
  "hash/adler32",
  "hash/crc32",
  "hash/crc64",
  "hash/fnv",
  "hash/maphash",
  "html",
  "html/template",
  "image",
  "image/color",
  "image/color/palette",
  "image/draw",
  "image/gif",
  "image/jpeg",
  "image/png",
  "index/suffixarray",
  "io",
  "io/fs",
  "io/ioutil",
  "log",
  "log/syslog",
  "math",
  "math/big",
  "math/bits",
  "math/cmplx",
  "math/rand",
  "mime",
  "mime/multipart",
  "mime/quotedprintable",
  "net",
  "net/http",
  "net/http/cgi",
  "net/http/cookiejar",
  "net/http/fcgi",
  "net/http/httptest",
  "net/http/httptrace",
  "net/http/httputil",
  "net/http/pprof",
  "net/mail",
  "net/netip",
  "net/rpc",
  "net/rpc/jsonrpc",
  "net/smtp",
  "net/textproto",
  "net/url",
  "os",
  "os/exec",
  "os/signal",
  "os/user",
  "path",
  "path/filepath",
  "plugin",
  "reflect",
  "regexp",
  "regexp/syntax",
  "runtime",
  "runtime/cgo",
  "runtime/coverage",
  "runtime/debug",
  "runtime/metrics",
  "runtime/pprof",
  "runtime/race",
  "runtime/trace",
  "sort",
  "strconv",
  "strings",
  "sync",
  "sync/atomic",
  "syscall",
  "testing",
  "testing/fstest",
  "testing/iotest",
  "testing/quick",
  "text/scanner",
  "text/tabwriter",
  "text/template",
  "text/template/parse",
  "time",
  "time/tzdata",
  "unicode",
  "unicode/utf16",
  "unicode/utf8",
  "unsafe",
}

local show_preview = function(entry, buf, callback)
  Job:new({
    command = "go",
    args = { "doc", "--all", entry.value },
    on_exit = function(job, exit_code)
      vim.schedule(function()
        if exit_code ~= 0 then
          vim.notify("failed to preview go document", vim.log.levels.ERROR)
          return
        end
        local result = job:result()
        if result then
          vim.api.nvim_buf_set_lines(buf, 0, -1, true, result)
          previewer_utils.highlighter(buf, "go")
          vim.api.nvim_buf_call(buf, function()
            local win = vim.fn.win_findbuf(buf)[1]
            vim.wo[win].conceallevel = 2
            vim.wo[win].wrap = true
            vim.wo[win].linebreak = true
            vim.bo[buf].textwidth = 80
          end)
        end

        if callback then
          callback()
        end
      end)
    end,
  }):start()
end

local picker_factory = function(opts)
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = "Golang Documentation",
      finder = finders.new_table {
        results = packages,
        entry_maker = function(entry)
          return {
            value = entry,
            display = entry,
            ordinal = entry,
            preview_command = show_preview,
          }
        end,
      },
      sorter = conf.generic_sorter(opts),
      previewer = previewers.display_content.new(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local entry = action_state.get_selected_entry()
          local buf = vim.api.nvim_create_buf(false, true)
          show_preview(entry, buf, function()
            vim.api.nvim_buf_set_option(buf, "modifiable", false)
            vim.api.nvim_buf_set_option(buf, "filetype", "go")

            vim.api.nvim_command "new"
            vim.api.nvim_win_set_buf(0, buf)
          end)
        end)
        return true
      end,
    })
    :find()
end

-- AutoCommands
local group = vim.api.nvim_create_augroup("GoAutoImport", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  pattern = "*.go",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local offset_encoding = "utf-16" -- Hardcoded for gopls
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result =
      vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)
    for _, res in pairs(result or {}) do
      for _, action in pairs(res.result or {}) do
        if action.edit then
          vim.lsp.util.apply_workspace_edit(action.edit, offset_encoding)
        end
      end
    end
  end,
})

local group = vim.api.nvim_create_augroup("GoAutoFormat", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format {
      timeout_ms = 1000,
      bufnr = vim.api.nvim_get_current_buf(),
    }
  end,
})

-- Keymaps
vim.keymap.set("n", "<leader>ks", picker_factory)
