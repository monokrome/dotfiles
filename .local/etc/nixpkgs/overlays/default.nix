self: super: {
  dwm = super.dwm.overrideAttrs (oldAttrs: rec {
    src = super.fetchgit {
      url = "https://github.com/monokrome/dwm";
      rev = "16ea3c1ecfcd26756fec99b273aab42adc289efe";
      sha256 = "0kkrs5bsdynwjwdya2cad3xs0aqv9jivqdmxi1a0rq4xnmhc8am3";
    };
  });
}
