local lualine_require = require("lualine_require")
local modules = lualine_require.lazy_require {
    config = "lualine.components.linediag.config",
    highlight = "lualine.highlight",
    utils = "lualine.utils.utils",
}

local M = lualine_require.require('lualine.component'):extend()

function neovim_lualine_severity(severity)
    local map = {
        [vim.diagnostic.severity.ERROR] = "error",
        [vim.diagnostic.severity.WARN] = "warn",
        [vim.diagnostic.severity.INFO] = "info",
        [vim.diagnostic.severity.HINT] = "hint"
    }
    return map[severity]
end

function M:init(options)
    M.super.init(self, options)

    -- Apply default configuration
    self.options = vim.tbl_deep_extend("keep",
        self.options or {},
        modules.config.options
    )
    
    if self.options.colored then
        -- Extract colors from diagnostics_color highlight groups
        local colors = {
            normal = modules.utils.extract_color_from_hllist(
                {"fg", "sp"},
                {"Normal"}
            )
        }
        for name, highlight in pairs(self.options.diagnostics_color) do
            colors[name] = modules.utils.extract_color_from_hllist(
                {"fg", "sp"},
                {self.options.diagnostics_color[name]}
            )
        end
        -- Create highlight groups from the colors
        self.highlight_groups = {
            normal = modules.highlight.create_component_highlight_group(
                {fg = colors.normal},
                "linediag_message",
                self.options
            )
        }
        for name, color in pairs(colors) do
            self.highlight_groups[name] = modules.highlight.create_component_highlight_group(
                {fg = colors[name]},
                "linediag_icon_" .. name,
                self.options
            )
        end
    end
end

function M:update_status(is_focused)
    local line, _ = unpack(vim.api.nvim_win_get_cursor(0))
    local diagnostics = vim.diagnostic.get(0, {lnum = line - 1})
    
    if #diagnostics > 0 then
        local best_diagnostic = diagnostics[1]
        
        for _, diagnostic in ipairs(diagnostics) do
            if diagnostic.severity < best_diagnostic.severity then
                best_diagnostic = diagnostic
            end
        end

        local message = best_diagnostic.message
        if #message > self.options.max_length then
            message = string.sub(message, 1, self.options.max_length) .. '…'
        end

        local result = 
               self.options.symbols[neovim_lualine_severity(best_diagnostic.severity)]
            .. modules.highlight.component_format_highlight(self.highlight_groups.normal)
            .. modules.utils.stl_escape(message)
        if self.options.colored then
            result =
                   modules.highlight.component_format_highlight(self.highlight_groups[neovim_lualine_severity(best_diagnostic.severity)])
                .. result
        end
        return result

    else
        return ""
    end
end

return M
