return {
    'chaoren/vim-wordmotion',
    lazy = false,
    commit = "81d9bd298376ab0dc465c85d55afa4cb8d5f47a1",
    init = function() vim.g.wordmotion_spaces = { '-', '_', '\\/', '\\.' } end
}
