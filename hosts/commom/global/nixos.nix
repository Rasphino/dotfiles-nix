{ pkgs, lib, ... }:
{
  system.configurationRevision = lib.mkIf (self ? rev) self.rev;
}
