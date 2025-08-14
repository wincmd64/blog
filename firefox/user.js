// Tested on Firefox 140x ESR
// Used https://searchfox.org/ 


// ---------- HIDEN
// возможность использовать кастомные userChrome.css и userContent.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
// правильное копирование юникодных ссылок, к примеру, из Википедии
user_pref("browser.urlbar.decodeURLsOnCopy", true);
// Backspase
user_pref("browser.backspace_action", 0);
// скрыть кнопку "список всех вкладок"
user_pref("browser.tabs.tabmanager.enabled", false);
// закладки открываются в фоне
user_pref("browser.tabs.loadBookmarksInBackground", true);
// has-selector
user_pref("layout.css.has-selector.enabled", true);
// font fix -- https://bugzilla.mozilla.org/show_bug.cgi?id=1924346
user_pref("gfx.font_rendering.cleartype_params.force_gdi_classic_for_families", "Arial,Consolas,Courier New,Microsoft Sans Serif,Segoe UI,Tahoma,Trebuchet MS,Verdana");
user_pref("gfx.font_rendering.cleartype_params.force_gdi_classic_max_size", 15); 
// подтверждение открытия >5 закладок сразу
user_pref("browser.tabs.maxOpenBeforeWarn", 5); 
// youtube fix
// user_pref("gfx.crash-guard.status.wmfvpxvideo", 2);

// ---------- GUI
// убрать предупреждение при переходе в about:config
user_pref("browser.aboutConfig.showWarning", false);
// ON Открывать предыдущие окна и вкладки
user_pref("browser.startup.page", 3);
// OFF Запрашивать сохранение логинов и паролей
user_pref("signon.rememberSignons", false);
// скрыть кнопку pocket
user_pref("browser.pocket.enabled", false);
// скрыть ярлыки
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
// панель закладок - всегда отображать
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
