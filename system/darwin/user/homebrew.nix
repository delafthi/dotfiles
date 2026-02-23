{
  config,
  lib,
  ...
}:
{
  environment.systemPath = [ "/opt/homebrew/bin" ];
  homebrew = {
    enable = true;
    caskArgs = {
      no_quarantine = true;
      require_sha = true;
    };
    casks =
      map
        (cask: {
          name = cask;
          greedy = true;
        })
        (
          lib.optionals config.system.gui.enable [
            "blender" # broken on darwin
            "gog-galaxy" # not in nixpkgs
            "karabiner-elements" # broken see https://github.com/nix-darwin/nix-darwin/issues/1041
            "kicad" # broken on darwin
            "proton-drive" # not in nixpkgs
            "protonvpn" # only linux (protonvpn-gui)
            "steam" # only as a nixos module
            "wacom-tablet" # only for linux as (wacomtablet)
          ]
        );
    masApps = {
      Amphetamine = 937984704;
      Developer = 640199958;
      "Hand Mirror" = 1502839586;
      Keynote = 409183694;
      Numbers = 409203825;
      Pages = 409201541;
      PDFgear = 6469021132;
      Photomator = 1444636541;
      Shazam = 897118787;
      stoic = 1312926037;
      Testflight = 899247664;
      Things = 904280696;
      "Wipr 2" = 1662217862;
      XCode = 497799835;
      # Apps designed for iPad. Not supported by MAS (see
      # https://github.com/mas-cli/mas/issues/321)
      # AnyConnect = 1135064690;
      # MeteoSwiss = 589772015;
      # "Organic Maps" = 1567437057;
      # "Proton Pass" = 6443490629;
      # "SAC-CAS" = 1592646841;
      # Swisstopo = 1505986543;
    };
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
  };
}
