{
  home.file.".ssh/allowed_signers".source = ./allowed-signers;
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_github.com.pub";
        identitiesOnly = true;
      };
      "github.zhaw.ch" = {
        hostname = "github.zhaw.ch";
        user = "git";
        identityFile = "~/.ssh/id_github.zhaw.ch.pub";
        identitiesOnly = true;
      };
      "*" = {
        addKeysToAgent = "no";
        compression = false;
        controlMaster = "no";
        controlPath = "~/.ssh/master-%r@%n:%p";
        controlPersist = "no";
        forwardAgent = false;
        hashKnownHosts = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        userKnownHostsFile = "~/.ssh/known_hosts";
      };
    };
  };
}
