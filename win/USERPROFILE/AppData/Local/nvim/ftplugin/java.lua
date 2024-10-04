-- JDK location
local jdk17_location = 'C:\\Users\\ssalyer\\.jdks\\liberica-17.0.10'

-- eclipe.jdt.ls location
local jdtls_location = 'C:\\java\\eclipse.jdt.ls\\org.eclipse.jdt.ls.product\\target\\repository\\'
local jdtls_jar = 'plugins\\org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar'
local jdtls_config = 'config_win'

-- Set a project-specific workspace directory
-- See: https://github.com/mfussenegger/nvim-jdtls?tab=readme-ov-file#data-directory-configuration
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = 'C:\\dev\\code\\nvim-jdtls\\' .. project_name

-- completions
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {

        -- 💀
        jdk17_location .. '\\bin\\java.exe',         -- or '/path/to/java17_or_newer/bin/java'
        -- depends on if `java` is in your $PATH env variable and if it points to the right version.

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        -- 💀
        '-jar', jdtls_location .. jdtls_jar,
        --'-jar', '/path/to/jdtls_install_location/plugins/org.eclipse.equinox.launcher_VERSION_NUMBER.jar',
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
        -- Must point to the                                                     Change this to
        -- eclipse.jdt.ls installation                                           the actual version


        -- 💀
        '-configuration', jdtls_location .. jdtls_config,
        --'-configuration', '/path/to/jdtls_install_location/config_SYSTEM',
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
        -- Must point to the                      Change to one of `linux`, `win` or `mac`
        -- eclipse.jdt.ls installation            Depending on your system.


        -- 💀
        '-data', workspace_dir
        -- See `data directory configuration` section in the README
        --'-data', '/path/to/unique/per/project/workspace/folder'
    },

    -- autostart = true,
    -- filetypes = { 'java', 'jsp' },

    -- 💀
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    --
    -- vim.fs.root requires Neovim 0.10.
    -- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
    -- root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew"}),
    root_dir = vim.fs.root(0, { "pom.xml", "build.xml", "build.gradle" }),
    -- root_dir = vim.fs.dirname(vim.fs.find({"pom.xml", "build.xml", 'build.gradle'}, { upward = true })[1]),

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-1.8",
                        path = "C:\\java\\jdk",
                    },
                    {
                        name = "JavaSE-17",
                        path = jdk17_location,
                    }
                },
            },
           -- project = {
           --     -- outputPath = "deploy_target\\MUM_WEB",
           --     sourcePaths = {
           --         "src",
           --         "WebContent"
           --     },
           --     referencedLibraries = {
           --         vim.fn.getcwd() .. "\\lib\\**\\*.jar",
           --         vim.fn.getcwd() .. "\\WebContent\\WEB-INF\\lib\\*.jar",
           --         "c:\\dev\\IA_COMMON\\IA_COMMON\\lib\\**\\*.jar",
           --         "c:\\dev\\code\\MUM\\sharedLib\\*.jar"
           --     }
           -- }
        }
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = {
            --  vim.fn.glob("path/to/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1)
        }
    },

    -- compleitions
    capabilities = capabilities,
}         -- end config()


--[[
			Advanced keymaps....

			nnoremap <A-o> <Cmd>lua require'jdtls'.organize_imports()<CR>
			nnoremap crv <Cmd>lua require('jdtls').extract_variable()<CR>
			vnoremap crv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
			nnoremap crc <Cmd>lua require('jdtls').extract_constant()<CR>
			vnoremap crc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
			vnoremap crm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>


			" If using nvim-dap
			" This requires java-debug and vscode-java-test bundles, see install steps in this README further below.
			nnoremap <leader>df <Cmd>lua require'jdtls'.test_class()<CR>
			nnoremap <leader>dn <Cmd>lua require'jdtls'.test_nearest_method()<CR>

          local opts = { silent = true, buffer = bufnr }
          vim.keymap.set('n', "<A-o>", jdtls.organize_imports, opts)
          vim.keymap.set('n', "<leader>df", jdtls.test_class, opts)
          vim.keymap.set('n', "<leader>dn", jdtls.test_nearest_method, opts)
          vim.keymap.set('n', "crv", jdtls.extract_variable, opts)
          vim.keymap.set('n', "crc", jdtls.extract_constant, opts)
          local create_command = vim.api.nvim_buf_create_user_command
          create_command(bufnr, 'W', require('me.lsp.ext').remove_unused_imports, {
            nargs = 0,
          })

--]]
-- vim.keymap.set('v', 'crm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], opts)

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
