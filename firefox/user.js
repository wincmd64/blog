// Tested on Firefox 128x ESR
// Used https://searchfox.org/ 


// ---------- HIDEN
// ����������� ������������ ��������� userChrome.css � userContent.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
// ���������� ����������� ��������� ������, � �������, �� ���������
user_pref("browser.urlbar.decodeURLsOnCopy", true);
// Backspase
user_pref("browser.backspace_action", 0);
// ������ ������ "������ ���� �������"
user_pref("browser.tabs.tabmanager.enabled", false);
// �������� ����������� � ����
user_pref("browser.tabs.loadBookmarksInBackground", true);
// has-selector
user_pref("layout.css.has-selector.enabled", true);
// youtube fix
// user_pref("gfx.crash-guard.status.wmfvpxvideo", 2);

// ---------- GUI
// ������ �������������� ��� �������� � about:config
user_pref("browser.aboutConfig.showWarning", false);
// ON ��������� ���������� ���� � �������
user_pref("browser.startup.page", 3);
// OFF ����������� ���������� ������� � �������
user_pref("signon.rememberSignons", false);
// ������ ������ pocket
user_pref("browser.pocket.enabled", false);
// ������ ������
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
// ������ �������� - ������ ����������
user_pref("browser.toolbars.bookmarks.visibility", "always");

// ---------- TELEMETRY - from https://github.com/yokoffing/Betterfox
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", true);
user_pref("toolkit.coverage.opt-out", true);
user_pref("toolkit.coverage.endpoint.base", "");
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
