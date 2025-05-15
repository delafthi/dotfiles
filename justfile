default:
  @just --list

[group('Main')]
[linux]
apply hostname=`hostname` *args:
  @sudo nixos-rebuild switch --flake .#{{hostname}} {{args}}

[group('Main')]
[macos]
apply hostname=`hostname` *args:
  @darwin-rebuild switch --flake .#{{hostname}} {{args}}

[group('Main')]
update *args:
  @nix flake update {{args}}

[group('dev')]
fmt *args:
  @nix fmt {{args}}

[group('dev')]
check *args:
  @nix flake check {{args}}
