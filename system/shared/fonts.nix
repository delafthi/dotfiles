{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      iosevka
      nerd-fonts.fira-code
      nerd-fonts.iosevka-term-slab
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-color-emoji
    ];
  };
}
