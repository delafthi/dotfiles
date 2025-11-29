default:
    @just --list

[group('main')]
[linux]
apply hostname=`hostname` *args:
    @sudo nixos-rebuild switch --flake .#{{ hostname }} {{ args }}

[group('main')]
[macos]
apply hostname=`hostname` *args:
    @sudo darwin-rebuild switch --flake .#{{ hostname }} {{ args }}

[group('main')]
update *args:
    @nix flake update {{ args }}

[group('dev')]
fmt *args:
    @nix fmt {{ args }}

[group('dev')]
check *args:
    @nix flake check {{ args }}
