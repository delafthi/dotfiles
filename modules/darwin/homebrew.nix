{
  homebrew = {
    enable = true;
    caskArgs.no_quarantine = true;
    casks = [
      "alacritty"
      "alfred"
      "gtkwave"
      "iina"
      "jordanbaird-ice"
      "onlyoffice"
      "proton-drive"
      "proton-mail"
      "proton-pass"
      "zed"
      "zotero"
    ];
    masApps = {
      "Apple Delevoper" = 640199958;
      Testflight = 899247664;
      XCode = 497799835;
      Bear = 1091189122;
      Hush = 1544743900;
      Notability = 360593530;
      Omnivore = 1564031042;
      Photomator = 1444636541;
      "ProtonPass for Safari" = 6502835663;
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
