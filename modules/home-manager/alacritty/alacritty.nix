{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.alacritty;
in {
  config = {
    ##################################################################
    # Files
    ##################################################################

    home.file."./.config/alacritty/alacritty.toml" = {
      text = ''
        [general]
        import = [
          "~/.config/alacritty/cyberpunk.toml"
        ]
        live_config_reload = true

        [env]
        TERM = "xterm-256color"

        [window]
        padding.x = 10
        padding.y = 10

        opacity = 0.7

        [font]
        size = ${builtins.toString cfg.fontSize}
        normal = { family = "Mononoki Nerd Font", style = "Regular" }
        bold = { family = "Mononoki Nerd Font", style = "Bold" }
        italic = { family = "Mononoki Nerd Font", style = "Italic" }
        bold_italic = { family = "Mononoki Nerd Font", style = "BoldItalic" }
        offset = ${cfg.fontOffset}

        [keyboard]
        bindings = [
            { key = "U", mods = "Command|Super|Shift", command = { program = "${pkgs.alacritty}/bin/alacritty", args = ["msg", "config", 'window.opacity=1.0'] } },
            { key = "U", mods = "Command|Super", command = { program = "${pkgs.alacritty}/bin/alacritty", args = ["msg", "config", 'window.opacity=0.7'] } }
        ]
      '';
    };

    home.file."./.config/alacritty/cyberpunk.toml" = {
      text = ''
        [colors]
        draw_bold_text_with_bright_colors = true
        transparent_background_colors = true

        # Cyberpunk-Neon colours
        [colors.primary]
        background = '0x000b1e'
        foreground = '0x0abdc6'

        [colors.cursor]
        text = '0x2e2e2d'
        cursor = '0xffffff'

        [colors.normal]
        black = '0x123e7c'
        red = '0xff0000'
        green = '0xd300c4'
        yellow = '0xf57800'
        blue = '0x123e7c'
        magenta = '0x711c91'
        cyan = '0x0abdc6'
        white = '0xd7d7d5'

        [colors.bright]
        black = '0x1c61c2'
        red = '0xff0000'
        green = '0xd300c4'
        yellow = '0xf57800'
        blue = '0x00ff00'
        magenta = '0x711c91'
        cyan = '0x0abdc6'
        white = '0xd7d7d5'

        [colors.dim]
        black = '0x1c61c2'
        red = '0xff0000'
        green = '0xd300c4'
        yellow = '0xf57800'
        blue = '0x123e7c'
        magenta = '0x711c91'
        cyan = '0x0abdc6'
        white = '0xd7d7d5'
      '';
    };
  };

  ##################################################################
  # Options
  ##################################################################

  options.programs.alacritty = {
    fontSize = lib.mkOption {
      type = lib.types.number;
      default = 11.25;
      description = "the font size to render";
    };

    fontOffset = lib.mkOption {
      type = lib.types.str;
      default = "{ x = 0, y = 0 }";
      description = ''
        the font spacing offsets provided as '{ x = <int>, y = <int> }'
      '';
    };
  };

  ##################################################################
  # Config
  ##################################################################

  config.programs.alacritty = lib.mkIf cfg.enable {};
}
