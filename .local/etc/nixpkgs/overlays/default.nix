self: super: {
  dwm = super.dwm.overrideAttrs (oldAttrs: rec {
    src = super.fetchgit {
      url = "https://github.com/monokrome/dwm";
      rev = "5fea8371b64aa1cdb493a9087a00ba09523a52a4";
    };
  });
}
