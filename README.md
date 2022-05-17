# ExpandStar.nvim
Use star(*) command for multiple highlights  
[![asciicast](https://asciinema.org/a/494391.svg)](https://asciinema.org/a/494391)
## Usage
* \* toggle highlitght
* \# show highlight
* d* delete all highlights
## Feature
* remember last highlights result
## Requirements
* neovim >= 0.7
## Installation
```lua
-- packer
use {
    'wasden/ExpandStar.nvim'
    config = function ()
      require("expandstar").setup()
    end
  },
```
