self: super: {
  dwm = super.dwm.overrideAttrs (oldAttrs: rec {
    src = super.fetchgit {
      url = "https://github.com/monokrome/dwm";
      rev = "db970f83d9ed94a8df27595cbad3315f52b1751c";
    };
  });

  discord = super.discord.overrideAttrs (oldAttrs: rec {
    pname = "discord";
    version = "0.0.5";
    name = "${pname}-${version}";
  });
}
