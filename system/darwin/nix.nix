{
  nix = {
    gc = {
      automatic = true;
      interval = [
        {
          Hour = 3;
          Minute = 45;
        }
      ];
    };
    optimise = {
      automatic = true;
      interval = [
        {
          Hour = 4;
          Minute = 45;
        }
      ];
    };
  };
}
