{config, pkgs, ... }:

{

programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    themeFile = "Tomorrow_Night_Blue";
    font = {
      name = "Atkinson Hyperlegible Mono";
    };
    settings = {
      confirm_os_window_close = 0; 
      copy_on_select = "clipboard";
      clear_all_shortcuts = true;
      input_delay = 0;
      kitty_mod = "ctrl+shift";
      # background_opacity = .9;
    };

    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+s" = "paste_from_selection";
      "ctrl+shift+e" = "open_url";
      "ctrl+shift+=" = "increase_font_size";
      "ctrl+shift+-" = "decrease_font_size";
      "ctrl+shift+backspace" = "restore_font_size";
      "ctrl+shift+up" = "scroll_line_up";
      "ctrl+shift+k" = "scroll_line_up";
      "ctrl+shift+down" = "scroll_line_down";
      "ctrl+shift+j" = "scroll_line_down";
      "ctrl+shift+home" = "scroll_home";
      "ctrl+shift+n" = "new_os_window";
      "ctrl+shift+]" = "next_window";
      "ctrl+shift+[" = "previous_window";
      "ctrl+shift+right" = "next_tab";
      "ctrl+tab" = "next_tab";
      "ctrl+shift+tab" = "previous_tab";
      "ctrl+shift+left" = "previous_tab";
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+q" = "close_tab";
    };
  };
}
