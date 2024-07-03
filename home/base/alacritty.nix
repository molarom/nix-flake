{pkgs, ...}: {
  # Alacritty configs
  home.packages = with pkgs; [
    alacritty
  ];

  home.file."./.config/alacritty/alacritty.toml" = {
    text = ''
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
      normal = { family = "Mononoki Nerd Font", style = "Regular" }
      bold = { family = "Mononoki Nerd Font", style = "Bold" }
      italic = { family = "Mononoki Nerd Font", style = "Italic" }
      bold_italic = { family = "Mononoki Nerd Font", style = "BoldItalic" }
      offset = { x = 2, y = 2 }

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
}
