self: super: {
  dwm = super.dwm.overrideAttrs (oldAttrs: rec {
    src = super.fetchgit {
      url = "https://github.com/monokrome/dwm";
      rev = "f9909ab56b731d464e28a859943028199debee31";
      sha256 = "179j94hq1q5v9763mh7hfl652xhaqfnrv032g1asb0c27j6vykhx";
    };
  });

  iam-aws-authenticator = super.buildGoPackage (rec {
    name = "iam-aws-authenticator";

    goPackagePath = "github.com/kubernetes-sigs/aws-iam-authenticator";

    src = super.fetchFromGitHub {
      owner = "kubernetes-sigs";
      rev = "01dd27d77ec1e2ec640a010970f00b2f8074b0b5";
      repo = "aws-iam-authenticator";
      sha256 = "1203mqvjya3fm8lfhsgc200bb017qcm9g7z26n826jdhpv516y4q";
    };
  });

  kubernetes = super.kubernetes.overrideAttrs (oldAttrs: rec {
    version = "1.11.1";

    src = super.fetchFromGitHub {
      owner = "kubernetes";
      repo = "kubernetes";
      rev = "v${version}";
      sha256 = "00abs626rhgz5l2ij8jbyws4g3lnb9ipima1q83q0nlj7ksaqz7d";
    };
  });
}
