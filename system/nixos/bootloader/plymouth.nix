{
  boot = {
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "boot.shell_on_fail"
      "quiet"
      "rd.systemd.show_status=auto"
      "splash"
      "udev.log_priority=3"
    ];
    loader = {
      timeout = 0;
    };
    plymouth.enable = true;
  };
  catppuccin = {
    enable = true;
    flavor = "mocha";
  };
}
