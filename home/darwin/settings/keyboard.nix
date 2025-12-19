{
  targets.darwin.defaults.NSGlobalDomain = {
    AppleKeyboardUIMode = 3;
    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticDashSubstitutionEnabled = false;
    NSAutomaticPeriodSubstitutionEnabled = false;
    NSAutomaticQuoteSubstitutionEnabled = false;
    NSAutomaticSpellingCorrectionEnabled = false;
  };
  xdg.configFile."karabiner/karabiner.json".source = ./karabiner.json;

}
