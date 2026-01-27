{ osConfig, ... }:
{
  programs.zathura = {
    inherit (osConfig.system.gui) enable;
    options = {
      font = "IosevkaTermSlab Nerd Font Mono";
      selection-clipboard = "clipboard";
    };
  };
}
