{
  additions = final: prev: import ../pkgs final.pkgs;
  modifications = final: prev: {
    lgogdownloader = prev.lgogdownloader.overrideAttrs (oldAttrs: {
      meta.platforms = oldAttrs.meta.platforms ++ prev.lib.platforms.darwin;
    });
  };
}
