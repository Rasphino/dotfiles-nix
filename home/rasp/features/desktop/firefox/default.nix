{ config, lib, inputs, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package =
      if pkgs.stdenv.isDarwin then
        (pkgs.runCommand "firefox-0.0.0" { } "mkdir $out") else pkgs.firefox;

    # Install extensions from NUR
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      decentraleyes
      ublock-origin
      darkreader
      df-youtube
      onetab
      bitwarden
      single-file
      grammarly
      tampermonkey
      vimium
      lovely-forks
      auto-tab-discard
    ];

    # Privacy about:config settings
    profiles.notus = {
      # ref: https://github.com/arkenfox/user.js/blob/master/user.js
      settings = {
        "app.update.auto" = false;
        "browser.startup.homepage" = "https://lobste.rs";
        "browser.search.region" = "SG";
        "browser.search.countryCode" = "SG";
        "browser.search.isUS" = false;
        "general.useragent.locale" = "en-SG";

        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.trackingprotection.socialtracking.annotate.enabled" = true;

        # UI
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "signon.rememberSignons" = false;

        # Disable Pocket
        "browser.newtabpage.activity-stream.feeds.discoverystreamfeed" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "extensions.pocket.enabled" = false;

        # Extra
        "media.autoplay.enabled" = false;

        "services.sync.declinedEngines" = "addons,passwords,prefs";
        "services.sync.engine.addons" = false;
        "services.sync.engineStatusChanged.addons" = true;
        "services.sync.engine.passwords" = false;
        "services.sync.engine.prefs" = false;
        "services.sync.engineStatusChanged.prefs" = true;
      };

      # userChome.css to make it look better
      # https://github.com/andreasgrafen/cascade with uglifycss
      userChrome = (builtins.readFile ./userChrome.css);
    };
  };
}
