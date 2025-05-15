final: prev: {
  lgogdownloader = prev.lgogdownloader.overrideAttrs (oldAttrs: {
    meta.platforms = oldAttrs.platforms ++ prev.lib.platforms.darwin;
  });
}
