<div align="center">

  ![PYXIS](https://raw.githubusercontent.com/mentalblank/PYXIS/refs/heads/main/image/banner.png)

  # PYXIS AIO
  ### All-in-One Custom Firmware Package for Nintendo Switch

  PYXIS is an automated all-in-one (AIO) custom firmware (CFW) package for the Nintendo Switch that packages various tools, system modules, and homebrew applications for a complete custom firmware experience.

  [![Release Build](https://github.com/MentalBlank/PYXIS/actions/workflows/build.yml/badge.svg)](https://github.com/MentalBlank/PYXIS/actions/workflows/build.yml)
  [![Latest Release](https://img.shields.io/github/v/release/MentalBlank/PYXIS?include_prereleases&label=Latest%20Build)](https://github.com/MentalBlank/PYXIS/releases/latest)
  [![License](https://img.shields.io/github/license/MentalBlank/PYXIS)](LICENSE)

</div>

---

## Features

*   **Automated Updates**: Powered by scripts that checks for upstream updates weekly.
*   **Curated Tools**: Bundles Atmosphere, Hekate, and a curated selection of 40+ essential homebrew tools.
*   **Optimized Configuration**: Pre-configured for best performance, including telemetry blocking.
*   **Easy Installation**: Designed for simple drag-and-drop SD card management.
*   **Background FTP Server:** Enable file transfers.
*   **Install NSP & XCI Files:** Transfer and install games from your hard drive, PC, or smartphone, using either Wi-Fi or wired connections.
*   **Update OFW & CFW:** Utilize homebrew applications to keep your firmware updated.
*   **Save Game Management:** Organize and manage your game saves.
*   **Emulate Amiibo:** Access Amiibo functionality without the actual figures.
*   **Overclocking and Underclocking:** Adjust performance settings for optimal gameplay.
*   **Game Cheating:** Use cheats in single-player games.
*   **Dynamic Themes:** Apply custom themes and visual modifications to the Switch UI.
*   **In-Game Cheat Activation:** Activate cheats on-the-fly without needing to exit the game.
*   **Mod Management:** Download, organize, and manage game mods for easier installation and uninstallation.
*   **Background FTP Server:** Enable file transfers.
*   **Discover New Homebrew:** Explore the App Store for the latest homebrew applications.
*   **Support for Third-Party Controllers:** Use various third-party controllers for enhanced gameplay.
*   **Online LAN Play:** Set up remote local multiplayer over the Internet.
*   **Custom User Icons:** Change your user icons with custom images.
*   **Adjust Display Colors:** Change your screen colors to be more vibrant or change based on the time of day.
*   **Overlays:** Access and control some of these features using an easy shortcut (press L1 + D-Pad Down + Right Stick).

## Installation

1.  **Download**: Grab the latest [`PYXIS_SwitchAIO.zip`](https://github.com/MentalBlank/PYXIS/releases/latest) from the [Releases Page](https://github.com/MentalBlank/PYXIS/releases/latest).
2.  **Prepare SD**: Extract the contents to the root of your FAT32-formatted SD card.
3.  **Boot**: Inject the Hekate payload and launch your preferred environment.

## Notes

*   A modded Nintendo Switch (V1, V2, Lite, or OLED) is required. For more information, consult this [FAQ & CFW Guide](https://switch.hacks.guide/).
*   You can download Amiibo .bin and .nfc files through AmiiboGenerator, or from the [Amiibo Database](https://github.com/AmiiboDB/Amiibo) repository, and load them using the Emuiibo homebrew application.
*   As a result of changes made by Nintendo to firmware version 20.0.0, there is less memory available for custom system modules. It is recommended that you don't upgrade your device beyond version 18.1.0 unless necessary as versions 19.0.0 and above also have reduced memory available, although not as severe. Additionally, not all homebrew and sys-modules are compatible with these newer OFW versions; an example of this is [switch-sys-tweak](https://github.com/p-sam/switch-sys-tweak).
*   If updating past FW 18.1.0 and using [masagrator/sys-ticon](https://github.com/masagrator/sys-ticon) to replace icons, titles, publishers or display versions, please check the [README.md](https://github.com/masagrator/sys-ticon/blob/develop/README.md) for details on limitations and instructions.
*   Sigpatches and `prod.keys` are **not** included in this package.

## Credits & Components

PYXIS is built upon the incredible work of the Switch homebrew community and includes components from:

| Repository | Description |
|------------|-------------|
| [Atmosphere-NX/Atmosphere](https://github.com/Atmosphere-NX/Atmosphere) | Custom firmware |
| [averne/Fizeau](https://github.com/averne/Fizeau) | Screen color adjuster |
| [BernardoGiordano/Checkpoint](https://github.com/BernardoGiordano/Checkpoint) | Save game manager |
| [cathery/sys-con](https://github.com/cathery/sys-con) | 3rd party controller usage |
| [cathery/sys-ftpd](https://github.com/cathery/sys-ftpd) | FTP server system module |
| [Chrscool8/Homebrew-Details](https://github.com/Chrscool8/Homebrew-Details) | Homebrew app manager |
| [CTCaer/hekate](https://github.com/CTCaer/hekate) | Custom bootloader |
| [DarkMatterCore/nxdumptool](https://github.com/DarkMatterCore/nxdumptool) | Game dumping tool |
| [DefenderOfHyrule/Gamecard-Installer-NX](https://github.com/DefenderOfHyrule/Gamecard-Installer-NX) | Gamecard installer |
| [dslatt/nso-icon-tool](https://github.com/dslatt/nso-icon-tool) | Tool for creating user icons |
| [exelix11/SwitchThemeInjector](https://github.com/exelix11/SwitchThemeInjector) | Theme injector |
| [fortheusers/hb-appstore](https://github.com/fortheusers/hb-appstore) | Homebrew app store |
| [HamletDuFromage/aio-switch-updater](https://github.com/HamletDuFromage/aio-switch-updater) | Updater for various things |
| [HamletDuFromage/nx-locale-switcher](https://github.com/HamletDuFromage/nx-locale-switcher) | Change the language and region of your games |
| [ITotalJustice/sphaira](https://github.com/ITotalJustice/sphaira) | hbmenu alternative |
| [ITotalJustice/untitled](https://github.com/ITotalJustice/untitled) | Batch title uninstaller |
| [impeeza/sys-patch](https://github.com/impeeza/sys-patch) | patches fs, es, ldr, nifm and nim on boot |
| [J-D-K/JKSV](https://github.com/J-D-K/JKSV) | Save manager for Switch |
| [joel16/NX-Shell](https://github.com/joel16/NX-Shell) | File manager |
| [Kofysh/Lockpick_RCM](https://github.com/Kofysh/Lockpick_RCM) | Payload to extract encryption keys |
| [masagrator/Status-Monitor-Overlay](https://github.com/masagrator/Status-Monitor-Overlay) | Status monitor overlay |
| [masagrator/sys-ticon](https://github.com/masagrator/sys-ticon) | Stripped and updated [switch-sys-tweak](https://github.com/p-sam/switch-sys-tweak) |
| [nadrino/SimpleModManager](https://github.com/nadrino/SimpleModManager) | Simple game mod manager |
| [ndeadly/MissionControl](https://github.com/ndeadly/MissionControl) | Alternative Controller support |
| [nedex/QuickNTP](https://github.com/nedex/QuickNTP) | Update clock from NTP server |
| [PoloNX/SimpleModDownloader](https://github.com/PoloNX/SimpleModDownloader) | Simple game mod downloader |
| [ppkantorski/Ultrahand-Overlay](https://github.com/ppkantorski/Ultrahand-Overlay) | Overlay menu for the Switch |
| [proferabg/EdiZon-Overlay](https://github.com/proferabg/EdiZon-Overlay) | Overlay for EdiZon cheat manager |
| [retronx-team/sys-clk](https://github.com/retronx-team/sys-clk) | Overclocking/underclocking system module |
| [Slluxx/AmiiboGenerator](https://github.com/Slluxx/AmiiboGenerator) | Generates Amiibo images for Emuiibo |
| [Slluxx/IconGrabber](https://github.com/Slluxx/IconGrabber) | Game icon grabber |
| [spacemeowx2/ldn_mitm](https://github.com/spacemeowx2/ldn_mitm) | Play local wireless supported games online |
| [sthetix/DowngradeFixer](https://github.com/sthetix/DowngradeFixer) | Fix issues when downgrading OFW from 21.0.0 to 20.5.0 |
| [suchmememanyskill/themezer-nx](https://github.com/suchmememanyskill/themezer-nx) | Custom themes downloader |
| [Team-Neptune/CommonProblemResolver](https://github.com/Team-Neptune/CommonProblemResolver) | Common problem resolver |
| [tomvita/Breeze-Beta](https://github.com/tomvita/Breeze-Beta) | Cheat manager for Switch |
| [tomvita/EdiZon-SE](https://github.com/tomvita/EdiZon-SE) | Cheat and Save editor / manager |
| [WerWolv/Hekate-Toolbox](https://github.com/WerWolv/Hekate-Toolbox) | Toolkit for hekate bootloader |
| [WerWolv/nx-ovlloader](https://github.com/WerWolv/nx-ovlloader) | Host process for loading overlays |
| [WerWolv/ovl-sysmodules](https://github.com/WerWolv/ovl-sysmodules) | A sysmodule selector for Tesla |
| [XorTroll/emuiibo](https://github.com/XorTroll/emuiibo) | Emulates amiibo |
| [XorTroll/Goldleaf](https://github.com/XorTroll/Goldleaf) | Title installer and manager |
| [zdm65477730/NX-Activity-Log](https://github.com/zdm65477730/NX-Activity-Log) | Improved Activity Log |

*For a full list of all integrated repositories, please refer to the [`manifest.json`](manifest.json).*

---

<div align="center">
  Released under the GNU General Public License v3. Contributions and Pull Requests are welcome.
</div>
