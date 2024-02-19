{
  programs.firefox = {
    enable = true;
    policies = {
      DefaultDownloadDirectory = "\${home}/0-inbox/downloads";
    };
  };
}
