# config-nixos
nixos configuration for {laptop, desktop, server}

# how to use

- Copy the config-nixos/hosts/example.nix file to config-nixos/hosts/whatever_you_want_to_call_this_machine.nix.
- Edit the new file to your liking.
- Symlink it to config-nixos/configuration.nix.
- Symlink the config-nixos folder to /etc/nixos.
- Run `nixos-rebuild switch`.

Example: 

    $ git clone git@github.com:robertseaton/config-nixos.git
    $ cd config-nixos
    $ cp hosts/example.nix hosts/my_new_machine.nix
    $ mg hosts/my_new_machine.nix
    $ ln -s hosts/my_new_machine.nix 
