{
  lib,
  buildGoModule,
  fetchFromGitHub,
  versionCheckHook,
  versionCheckHomeHook,
}:

buildGoModule rec {
  pname = "treehouse";
  version = "3.1.2";

  src = fetchFromGitHub {
    owner = "kunchenguid";
    repo = "treehouse";
    tag = "v${version}";
    hash = "sha256-hXPpMgcPNlZM77VDOBjASCE2Sb3hwz0xNhmqpn6WqCQ=";
  };

  vendorHash = "sha256-z8IndcHcZ6nLqhLtAYul3ppddpOA4AHGQWIlfYY/pfI=";

  subPackages = [ "." ];

  ldflags = [
    "-s"
    "-w"
    "-X main.version=v${version}"
  ];

  # Upstream disables sandboxed tests: the end-to-end suite spawns VCS
  # processes and requires network and unrestricted filesystem access.
  doCheck = false;

  doInstallCheck = true;
  nativeInstallCheckInputs = [
    versionCheckHook
    versionCheckHomeHook
  ];

  passthru.category = "Workflow & Project Management";

  meta = with lib; {
    description = "Reusable isolated worktree manager for AI agent sessions";
    homepage = "https://github.com/kunchenguid/treehouse";
    changelog = "https://github.com/kunchenguid/treehouse/releases/tag/v${version}";
    license = licenses.mit;
    sourceProvenance = with sourceTypes; [ fromSource ];
    maintainers = with lib.maintainers; [ azd325 ];
    mainProgram = "treehouse";
    platforms = platforms.linux ++ platforms.darwin;
  };
}
