{
  programs.firefox = {
    enable = true;
    policies = {
      DefaultDownloadDirectory = "\${home}/0 Inbox/Download";
    };
  };
}
