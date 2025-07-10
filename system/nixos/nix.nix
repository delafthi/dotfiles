{
  nix = {
    daemonCPUSchedPolicy = "batch";
    daemonIOSchedClass = "idle";
    daemonIOSchedPriority = 7;
    gc.dates = [ "03:15" ];
    optimise.dates = [ "04:15" ];
  };
}
