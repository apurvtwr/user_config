neogen = require('neogen')

neogen.setup({
    enabled = true,
      languages = {
        python = {
          template = {
            annotation_convention = "reST", -- Options: "reST", "google", "numpy"
          },
        },
        cpp = {
          template = {
            annotation_convention = "doxygen", -- Best for C++ projects
          },
        },
      },
})

