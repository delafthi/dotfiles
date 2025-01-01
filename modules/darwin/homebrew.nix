{
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    casks = [
      "alfred"
      "blender"
      "chatgpt"
      "ghostty"
      "godot"
      "iina"
      "jordanbaird-ice"
      "pika"
      "proton-drive"
      "proton-mail"
      "protonvpn"
      "rectangle"
      "zotero"
    ];
    masApps = {
      "AdGuard for Safari" = 1440147259;
      "Apple Delevoper" = 640199958;
      Testflight = 899247664;
      XCode = 497799835;
      Bear = 1091189122;
      Habits = 1514915737;
      Hush = 1544743900;
      Keynote = 409203825;
      Numbers = 409203825;
      Pages = 409201541;
      PDFgear = 6469021132;
      Photomator = 1444636541;
      "Proton Pass" = 6443490629;
      Shazam = 897118787;
      Things = 904280696;
      "Toggl Track" = 1291898086;
      WhatsApp = 310633997;
    };
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
  };
}
