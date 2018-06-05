self: super: {
  dwm = super.dwm.overrideAttrs (oldAttrs: rec {
    src = super.fetchgit {
      url = "https://github.com/monokrome/dwm";
      rev = "476349296bbcf0fd4bd8361ff1216a0410d955c2";
      sha256 = "0f9ydn5hl74irxpb1gbrk4gcjgcs4302lxfqxl3ac1scv06bw2m8";
    };
  });
}
