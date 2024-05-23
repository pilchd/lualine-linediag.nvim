lualine-linediag
================

*[lualine][1] component for displaying the current line's most-severe diagnostic message*

Why?
----

I was a fan of Visual Studio Code's `problems.showCurrentInStatus` setting, I couldn't find a native replacement, and I
needed an afternoon project to begin understanding the Neovim/Lua/plugin system.

Usage
-----

Install with your favorite plugin manager and add `linediag` as a component in a lualine section.

The component obeys a subset of the component-specific options for the [diagnostics][2] component, namely
`diagnostics_color`, `symbols`, and `colored`. It should eventually obey all of them (in addition to the relevant
global component settings).  
Setting `max_length` to an integer truncates the message at that many characters.

Credits
-------

This component is adapted from discussion [#911][3] in the lualine repository and based on the bundled [diagnostics][4]
component implementation.  
It was originally implemented in [lualine-diagnostic-message][5].

[1]: https://github.com/nvim-lualine/lualine.nvim
[2]: https://github.com/nvim-lualine/lualine.nvim#diagnostics-component-options
[3]: https://github.com/nvim-lualine/lualine.nvim/discussions/911
[4]: https://github.com/nvim-lualine/lualine.nvim/tree/master/lua/lualine/components/diagnostics
[5]: https://github.com/Isrothy/lualine-diagnostic-message
