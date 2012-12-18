## Inhalt
Dieses Repository enthält die Freifunk-Firmware, so wie sie im KBU-Netz verwendet wird. Es ist wie lff ein Fork der Lübecker Firmware.

## Branches
Die Branches im Upstream werden im gitweb aufgeführt: https://git.metameute.de/lff/firmware/ . In diesem Repository sind verfügbar:
+ master (README.md)
+ v0.3.x (TP Link 741nd)  
+ v0.3.x-tl-wr1043nd (TP Link 1043nd).

Andere Branches im Upstream sind nicht für die Verwendung für Freifunk-KBU angepasst (d.h. es gibt hierzu keine Kopie mit patches für abweichende Konfigurationen).

## Checkout / Clone
Für einen build, reicht ein checkout des Repositories aus. Hierzu muss ein passender branch gewählt werden. Der Master-Branch enthält ausschließlich diese Readme-Datei.
Für die Entwicklung ist es sinnvoll, den Lübecker upstram lokal nach dem clone hinzufügen:
`git remote add upstream https://git.metameute.de/lff/firmware/`


## Build
Zum Build der Firmware muss make im passenden Branch aufgerufen werden.


## Hinweis
Im Gegensatz zu lff bezieht sich dieses Repository auf die Upstream-Struktur, so wie sie Stand 2012-12-18 in Lübeck vorliegt. (lff bezieht sich auf den Stand vor Neoraiders refactoring).

