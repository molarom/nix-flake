{...}: {
  system.defaults = {
    # Save screeshots here.
    screencapture.location = "~/Pictures/screeshots";

    SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;

    # Enable dark mode
    NSGlobalDomain.AppleInterfaceStyle = "Dark";

    finder = {
      # Always show file extensions;
      AppleShowAllExtensions = true;

      # Default list view in finder.
      FXPreferredViewStyle = "Nlsv";

      # Remove items in trash older than 30d.
      FXRemoveOldTrashItems = true;

      # Default search scope is current folder.
      FXDefaultSearchScope = "SCcf";

      # Allow finder process to be exited.
      QuitMenuItem = true;

      # Show path breadcrumbs.
      ShowPathbar = true;

      # Show disk space stats.
      ShowStatusBar = true;

      # Folders placed on top when sorting by name.
      _FXSortFoldersFirst = true;
      _FXSortFoldersFirstOnDesktop = true;
    };
  };
}
