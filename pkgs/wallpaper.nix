{
  stdenvNoCC,
  fetchurl,
}:
stdenvNoCC.mkDerivation (_finalAttrs: {
  name = "wallpaper";
  version = "unstable";
  src = fetchurl {
    url = "https://unsplash.com/photos/1527pjeb6jg/download?force=true";
    sha256 = "sha256-OZTUlNTFrVD7R+R9n3sTGXZ2sGorqumiGm6po8xRdGc=";
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/backgrounds/
    ln -s $src $out/share/backgrounds/wallpaper

    runHook postInstall
  '';
})
