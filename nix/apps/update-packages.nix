{
  pkgs,
}:
let
  name = "update-packages";
  description = "Update packages that have an updateScript defined";
in
{
  type = "app";
  program = "${
    pkgs.writeShellApplication {
      inherit name;
      runtimeInputs = with pkgs; [
        nix-update
        git
        python3
      ];
      text = ''
        exec python3 ${./update_packages.py} "$@"
      '';
    }
  }/bin/${name}";
  meta = {
    inherit description;
    mainProgram = name;
  };
}
