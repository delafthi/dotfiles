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

[group('setup')]
[linux]
setup-yubico-pam:
    @mkdir -p "$XDG_CONFIG_HOME/Yubico"
    @pamu2fcfg > "$XDG_CONFIG_HOME/u2f_keys"

[group('setup')]
[linux]
test-yubico-pam:
    @echo -n "Testing login... " && pamtester login $(whoami) authenticate | sed 's/^pamtester: //'
    @echo -n "Testing sudo... " && pamtester sudo $(whoami) authenticate | sed 's/^pamtester: //'

[group('dev')]
fmt *args:
    @nix fmt {{ args }}

[group('dev')]
check *args:
    @nix flake check {{ args }}
