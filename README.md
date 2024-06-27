# cpperm - Berechtigungen kopieren

Das Skript `cpperm` ermöglicht das Kopieren von Berechtigungen, Eigentümer und Gruppeninformationen von einer Quelldatei oder einem Quellordner zu einem Zieldatei oder Zielordner unter Linux.

## Funktionsweise

`cpperm` nutzt die Linux-Befehle `stat`, `chmod` und `chown`, um die Berechtigungen sowie die Besitzer- und Gruppeninformationen von einem Objekt (Datei oder Verzeichnis) zu extrahieren und diese auf ein anderes Objekt zu übertragen.

## Voraussetzungen

Um `cpperm` nutzen zu können, müssen Sie Zugriff auf einen Linux-basierten Computer haben und Berechtigungen besitzen, die es Ihnen erlauben, `chmod` und `chown` auszuführen.

## Installation

Fügen Sie die `cpperm` Funktion zu Ihrer Bash-Konfigurationsdatei hinzu (`~/.bashrc`, `~/.bash_profile` oder `~/.profile`).

## Verwendung

Um `cpperm` zu verwenden, rufen Sie das Skript aus Ihrem Terminal wie folgt auf:

```bash
cpperm /pfad/zur/quelle /pfad/zum/ziel
swapfiles - Dateien sicher tauschen
Das Bash-Skript swapfiles ermöglicht das sichere Tauschen von zwei Dateien auf einem Linux-basierten System. Dieses Skript stellt sicher, dass keine Daten während des Tauschvorgangs verloren gehen.

Funktionsweise
swapfiles nutzt temporäre Dateien und ein temporäres Verzeichnis, um sicherzustellen, dass die Dateien effektiv und sicher getauscht werden, ohne dass Datenverluste entstehen. Dies ist besonders nützlich in Szenarien, wo Dateien kritische Informationen enthalten oder sehr groß sind.

Verwendung
Um swapfiles zu verwenden, rufen Sie das Skript aus Ihrem Terminal wie folgt auf:

bash
Code kopieren
swapfiles /pfad/zur/datei1 /pfad/zur/datei2
Ersetzen Sie /pfad/zur/datei1 und `/pfad

warum trennst du das?
ChatGPT
Entschuldigung für die Verwirrung. Die Trennung der beiden Skriptbeschreibungen im README.md-Dokument erfolgte, um Klarheit und Struktur zu schaffen. Jedes Skript hat seinen eigenen Abschnitt mit Erklärungen und Anweisungen. Dies hilft, die Informationen übersichtlich und leicht verständlich zu präsentieren, sodass Nutzer schnell finden können, was sie für jedes spezifische Skript benötigen.

Wenn Sie bevorzugen, dass die Informationen zusammenhängender präsentiert werden oder eine spezifische Struktur wünschen, kann ich das Dokument entsprechend anpassen. Ihre Rückmeldung hierzu ist sehr willkommen!

Erstelle ein readme+
ChatGPT
Ein README.md-Dokument, das Informationen zu beiden Skripten (cpperm und swapfiles) in einer zusammenhängenden und integrierten Weise darstellt, kann so aussehen:

markdown
Code kopieren
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
2. swapfiles - Dateien sicher tauschen
swapfiles ermöglicht es, zwei Dateien sicher zu tauschen, indem temporäre Dateien und ein temporäres Verzeichnis verwendet werden, um Datenverluste zu vermeiden.

Funktionsweise
Das Skript ist besonders nützlich in Szenarien, wo Dateien kritische Informationen enthalten oder sehr groß sind.

Verwendung
bash
Code kopieren
swapfiles /pfad/zur/datei1 /pfad/zur/datei2
Allgemeine Installation
Fügen Sie die jeweilige Funktion zu Ihrer Bash-Konfigurationsdatei hinzu (~/.bashrc, ~/.bash_profile oder ~/.profile). Nach dem Hinzufügen führen Sie den Befehl source ~/.bashrc aus, um die Funktion sofort verfügbar zu machen.

Lizenz
Diese Skripte sind als freie Software unter den Bedingungen der MIT Lizenz verfügbar und können weiterverbreitet und/oder modifiziert werden.

Unterstützung
Für Fragen und Unterstützung zu den Skripten können Sie hier ein Issue erstellen.

markdown
Code kopieren

### Erläuterungen

- **Übersicht**: Eine einführende Beschreibung gibt einen Überblick über den Zweck und den Inhalt des Repositories.
- **Details zu den Skripten**: Jedes Skript wird einzeln erläutert, mit Details zu seiner Funktionsweise und Anwendung.
- **Installation**: Allgemeine Installationsanweisungen, die für beide Skripte gelten.
- **Lizenz und Unterstützung**: Informationen zur Lizenzierung und wie Nutzer Unterstützung erhalten können.

Diese Struktur stellt sicher, dass alle relevanten Informationen klar und effizient präsentiert werden, wobei
