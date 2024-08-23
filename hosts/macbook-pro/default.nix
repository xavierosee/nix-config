{ config, pkgs, ... }:

{
  imports = [
    ../../modules/darwin
    ../../modules/shared
  ];

  networking.hostName = "macbook-pro";
}