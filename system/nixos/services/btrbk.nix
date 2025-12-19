{ target }:
{
  services = {
    btrbk.instances.local = {
      onCalendar = "hourly";
      settings = {
        timestamp_format = "long";
        snapshot_preserve_min = "2d";
        snapshot_preserve = "14d";
        target_preserve_min = "no";
        target_preserve = "20d 10w *m";
        volume."/".subvolume."home" = {
          inherit target;
          snapshot_dir = "home/.snapshots";
        };
      };
    };
  };
}
