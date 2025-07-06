<div align="center">

  ![PYXIS](https://raw.githubusercontent.com/mentalblank/PYXIS/refs/heads/main/image/banner.png)

  # All-in-One (AIO) Package for Nintendo Switch

  PYXIS is an all-in-one (AIO) custom firmware (CFW) package for the Nintendo Switch, bringing together various essential tools and applications for a complete custom firmware experience. Sigpatch and prod.key files are **NOT** included.

</div>

## Features

- **Comprehensive Toolset:** Bundles essential applications for a complete Switch experience.
- **User-Friendly:** Designed for easy drag-and-drop functionality.
- **Customizable:** Modify the package to suit your needs.
- **Background FTP Server:** Enable file transfers.
- **Install NSP & XCI Files:** Transfer and install games from your hard drive, PC, or smartphone, using either Wi-Fi or wired connections.
- **Update OFW & CFW:** Utilize homebrew applications to keep your firmware updated.
- **Save Game Management:** Organize and manage your game saves.
- **Emulate Amiibo:** Access Amiibo functionality without the actual figures.
- **Overclocking and Underclocking:** Adjust performance settings for optimal gameplay.
- **Game Cheating:** Use cheats in single-player games.
- **Dynamic Themes:** Apply custom themes and visual modifications to the Switch UI.
- **In-Game Cheat Activation:** Activate cheats on-the-fly without needing to exit the game.
- **Mod Management:** Download, organize, and manage game mods for easier installation and uninstallation.
- **Background FTP Server:** Enable file transfers.
- **Discover New Homebrew:** Explore the App Store for the latest homebrew applications.
- **Support for Third-Party Controllers:** Use various third-party controllers for enhanced gameplay.
- **Online LAN Play:** Set up remote local multiplayer over the Internet.
- **Custom User Icons:** Change your user icons with custom images.
- **Adjust Display Colors:** Change your screen colors to be more vibrant or change based on the time of day.
- **Overlays:** Access and control some of these features using an easy shortcut (press L1 + D-Pad Down + Right Stick).

## Installation Guide

1. [Download the latest .zip release here](https://github.com/MentalBlank/PYXIS/releases/latest).
2. Unzip the contents of the compressed folder to the root directory of your Switch SD card.
3. In RCM mode, send the Hekate payload to your Switch and start the custom firmware (CFW).

## Notes

- A modded Nintendo Switch is required. For more information, consult this [FAQ & CFW Guide](https://switch.hacks.guide/).
- You can download Amiibo .bin and .nfc files through AmiiboGenerator, or from the [Amiibo Database](https://github.com/AmiiboDB/Amiibo) repository, and load them using the Emuiibo homebrew application.
- As a result of changes made by Nintendo to firmware version 20.0.0, there is less memory available for custom system modules. It is recommended that you don't upgrade your device beyond version 18.1.0 unless necessary as versions 19.0.0 and above also have reduced memory available, although not as severe. Additionally, not all homebrew and sys-modules are compatible with these newer OFW versions; an example of this is sys-tweak.
- The PYXIS repository will automatically check for homebrew updates weekly, and releases a new AIO package **ONLY** if an update is found or I have manually run the build workflow.

## Credits

This project utilizes and credits the following repositories:

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
| [ITotalJustice/sphaira](https://github.com/ITotalJustice/sphaira) | hbmenu alternative |
| [ITotalJustice/untitled](https://github.com/ITotalJustice/untitled) | Batch title uninstaller |
| [impeeza/sys-patch](https://github.com/impeeza/sys-patch) | patches fs, es, ldr, nifm and nim on boot |
| [J-D-K/JKSV](https://github.com/J-D-K/JKSV) | Save manager for Switch |
| [joel16/NX-Shell](https://github.com/joel16/NX-Shell) | File manager |
| [Kofysh/Lockpick_RCM](https://github.com/Kofysh/Lockpick_RCM) | Payload to extract encryption keys |
| [masagrator/Status-Monitor-Overlay](https://github.com/masagrator/Status-Monitor-Overlay) | Status monitor overlay |
| [mentalblank/switch-sys-tweak](https://github.com/mentalblank/switch-sys-tweak) | Automatic builds of [p-sam/switch-sys-tweak](https://github.com/p-sam/switch-sys-tweak) |
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

## License

This project is licensed under the GNU General Public License v3. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please fork this repository and submit a pull request for any changes or improvements.

