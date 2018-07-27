self: super: {
  dwm = super.dwm.overrideAttrs (oldAttrs: rec {
    src = super.fetchgit {
      url = "https://github.com/monokrome/dwm";
      rev = "f9909ab56b731d464e28a859943028199debee31";
      sha256 = "179j94hq1q5v9763mh7hfl652xhaqfnrv032g1asb0c27j6vykhx";
    };
  });
}
