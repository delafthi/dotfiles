{
  lib,
  osConfig,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  targets.darwin.defaults."com.apple.mail".DisableInlineAttachmentViewing = true;
}
