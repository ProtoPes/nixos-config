{ config, pkgs, ... }:

{
        home.username = "protopes";
        home.homeDirectory = "/home/protopes";
        home.stateVersion = "25.05";
	programs.git = {
		enable = true;
		userName  = "ProtoPes";
		userEmail = "protopes-git@proton.me";
	};
	programs.bash = {
		enable = true;
	};
}
