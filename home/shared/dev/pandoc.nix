{
  programs.pandoc = {
    enable = true;
    defaults = {
      citeproc = true;
      metadata.author = "Thierry Delafontaine";
      standalone = true;
    };
  };
}
