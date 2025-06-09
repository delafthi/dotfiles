final: prev:
prev.lgogdownloader.overrideAttrs (oldAttrs: {
  meta.platforms = oldAttrs.meta.platforms ++ prev.lib.platforms.darwin;
})
