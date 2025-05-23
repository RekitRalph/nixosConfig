{ config, pkgs, ... }:

{

programs.oh-my-posh = {
enable = true;
enableBashIntegration = true;

settings = {
  console_title_template = "{{ .Shell }} in {{ .Folder }}";
  final_space = true;
  shell_integration = true;
  disable_notice = true;
  secondary_prompt = {
    background = "transparent";
    foreground = "magenta";
    template = "❯❯ ";
  };
  transient_prompt = {
    background = "transparent";
    foreground_templates = [ "{{if gt .Code 0}}red{{end}}" "{{if eq .Code 0}}magenta{{end}}" ];
    template = "❯ ";
  };
  version = 2;
  blocks = [
    {
      alignment = "left";
      newline = true;
      segments = [

        {
          background = "transparent";
          foreground = "blue";
          properties = { style = "full"; };
          style = "plain";
          template = "{{ .Path }}";
          type = "path";
        }
        {
          background = "transparent";
          foreground = "p:grey";
          properties = {
            branch_icon = "";
            commit_icon = "@";
            fetch_status = true;
          };
          style = "plain";
          template = " {{ .HEAD }}{{ if or (.Working.Changed) (.Staging.Changed) }}*{{ end }} <cyan>{{ if gt .Behind 0 }}⇣{{ end }}{{ if gt .Ahead 0 }}⇡{{ end }}</>";
          type = "git";
        }
      ];
      type = "prompt";
    }
    {
      overflow = "hidden";
      segments = [{
        background = "transparent";
        foreground = "yellow";
        properties = { threshold = 500; };
        style = "plain";
        template = "{{ .FormattedMs }}";
        type = "executiontime";
      }];
      type = "rprompt";
    }
      {
      alignment = "left";
      newline = true;
      segments = [{
        background = "transparent";
        foreground_templates = [ "{{if gt .Code 0}}red{{end}}" "{{if eq .Code 0}}magenta{{end}}" ];
        style = "plain";
        template = "❯";
        type = "text";
      }];
      type = "prompt";
      }
    ];
  };
};
}