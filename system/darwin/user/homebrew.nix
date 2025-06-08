{
  environment.systemPath = [ "/opt/homebrew/bin" ];
  homebrew = {
    enable = true;
    caskArgs = {
      no_quarantine = true;
      # require_sha = true;
    };
    casks =
      builtins.map
        (cask: {
          name = cask;
          greedy = true;
        })
        [
          "affinity-designer"
          "affinity-photo"
          "affinity-publisher"
          "alcove"
          "element"
          "karabiner-elements"
          "krita"
          "lunar"
          "meetingbar"
          "monodraw"
          "obsidian"
          "proton-drive"
          "proton-mail"
          "protonvpn"
          "shottr"
          "steam"
          "subler"
          "transmission"
          "wacom-tablet"
          "zen"
        ];
    # masApps = {
    #   Amphetamine = 937984704;
    #   AnyConnect = 1135064690;
    #   Developer = 640199958;
    #   Deepstash = 1445023295;
    #   Delta = 1048524688;
    #   "Hand Mirror" = 1502839586;
    #   Keynote = 409183694;
    #   MeteoSwiss = 589772015;
    #   Numbers = 409203825;
    #   "Organic Maps" = 1567437057;
    #   Pages = 409201541;
    #   PDFgear = 6469021132;
    #   Photomator = 1444636541;
    #   "Proton Pass" = 6443490629;
    #   "Proton Wallet" = 479609548;
    #   "SAC-CAS" = 1592646841;
    #   Shazam = 897118787;
    #   stoic = 1312926037;
    #   Swisstopo = 1505986543;
    #   Testflight = 899247664;
    #   Things = 904280696;
    #   WhatsApp = 310633997;
    #   XCode = 497799835;
    # };
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
  };
}
