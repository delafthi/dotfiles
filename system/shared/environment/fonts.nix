{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      iosevka-bin
      (iosevka-bin.override { variant = "Aile"; })
      (iosevka-bin.override { variant = "Etoile"; })
      nerd-fonts.fira-code
      nerd-fonts.iosevka-term-slab
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-color-emoji
    ];
  };
}
