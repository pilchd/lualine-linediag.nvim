local M = {}

M.options = {
    -- sources = {"nvim_lsp", "nvim_diagnostic", "nvim_workspace_diagnostic", "coc", "ale", "vim_lsp"},
    -- sections = {"error", "warn", "info", "hint"},
    diagnostics_color = {
        error = "DiagnosticError",
        warn = "DiagnosticWarn",
        info = "DiagnosticInfo",
        hint = "DiagnosticHint"
    },
    symbols = {
        error = "error ",
        warn = "warn ",
        info = "info ",
        hint = "hint "
    },
     colored = true,
    -- update_in_insert = true,
    -- always_visible = false,

    max_length = 72
}

return M
