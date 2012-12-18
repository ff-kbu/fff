## Inhalt
Dieses Repository enthält die Freifunk-Firmware, so wie sie im KBU-Netz verwendet wird. Es ist wie lff ein Fork der Lübecker Firmware.

## Hinweis
Im Gegensatz zu lff bezieht es sich auf den Upstream, so wie er Stand 2012-12-18 in Lübeck vorliegt. (lff bezieht sich auf den Stand vor Neoraiders refactoring).

## Checkout / Clone
Für einen build, reicht ein checkout des Repositories aus. Für die Entwicklung ist es sinnvoll, den Lübecker upstram lokal hinzufügen:
git remote add upstream https://git.metameute.de/lff/firmware/

## Branches
Die Branches im Upstream werden im gitweb aufgeführt: https://git.metameute.de/lff/firmware/ . In diesem Repository sind die Branches v0.3.x (TP 741nd) und v0.3.x-tl-wr1043nd (TP Link 1043nd) verfügbar.
Andere Branches im Upstream sind nicht für die Verwendung für Freifunk-KBU angepasst (d.h. es gibt hierzu keine Kopie mit patches für abweichende Konfigurationen).

## Build
Zum Build der Firmware muss make im passenden Branch aufgerufen werden.


