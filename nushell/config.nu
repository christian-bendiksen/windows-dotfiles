# config.nu
#
# Installed by:
# version = "0.104.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.
# 
## Starship Config
$env.STARSHIP_CONFIG = ($nu.home-path | path join ".config/starship/starship.toml")
$env.config.buffer_editor = "hx"
$env.config.show_banner = false
