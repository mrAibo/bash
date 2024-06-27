# Linux Dateiverwaltungsskripte

Dieses Repository enthält zwei leistungsstarke Bash-Skripte zur Verwaltung von Dateiberechtigungen und zum sicheren Tauschen von Dateien auf einem Linux-basierten System.

## Skripte

### 1. cpperm - Berechtigungen kopieren

`cpperm` ist ein Skript, das das Kopieren von Berechtigungen, Eigentümern und Gruppeninformationen von einer Quelldatei oder einem Quellordner zu einem Ziel ermöglicht.

#### Funktionsweise

Es verwendet die Befehle `stat`, `chmod` und `chown`, um Berechtigungen sowie Besitzer- und Gruppeninformationen zu extrahieren und auf ein anderes Objekt zu übertragen.

#### Voraussetzungen

Benutzer müssen Zugriff auf einen Linux-basierten Computer haben und die nötigen Berechtigungen besitzen, um `chmod` und `chown` ausführen zu können.

#### Verwendung

```bash
cpperm /pfad/zur/quelle /pfad/zum/ziel


### 2. swapfiles - Dateien sicher tauschen
swapfiles ermöglicht es, zwei Dateien sicher zu tauschen, indem temporäre Dateien und ein temporäres Verzeichnis verwendet werden, um Datenverluste zu vermeiden.

##### Funktionsweise
Das Skript ist besonders nützlich in Szenarien, wo Dateien kritische Informationen enthalten oder sehr groß sind.

#### Verwendung

```bash
swapfiles /pfad/zur/datei1 /pfad/zur/datei2
