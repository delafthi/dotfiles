{
  programs.iamb = {
    enable = true;
    settings = {
      profiles.user.user_id = "@delafthi:matrix.org";
      layout.style = "restore";
      settings = {
        notifications.enabled = true;
        image_preview.protocol = {
          type = "kitty";
          size = {
            height = 10;
            width = 66;
          };
        };
      };
    };
  };
}
