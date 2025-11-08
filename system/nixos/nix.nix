{
  nix = {
    daemonCPUSchedPolicy = "batch";
    daemonIOSchedClass = "idle";
    daemonIOSchedPriority = 7;
    gc = {
      automatic = true;
      dates = [ "03:45" ];
    };
    optimise = {
      automatic = true;
      dates = [ "04:45" ];
    };
  };
}
