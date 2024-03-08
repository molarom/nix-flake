{ config, pkgs, ... }:
{
	programs.zsh = {
		enable = true;
		ohMyZsh = {
			enable = true;
			plugins = [
				"colorize"
				"colored-man-pages"
				"cp"
				"docker"
				"git"
				"github"
				"history-substring-search"
				"jump"
				"rsync"
			];
		  theme = "sorin";
		};
	};
}
