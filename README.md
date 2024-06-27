# Shell Utility Functions

Dieses Repository enthält nützliche Shell-Funktionen, die Sie in Ihrer täglichen Arbeit verwenden können, um bestimmte Aufgaben zu vereinfachen. Jede Funktion ist darauf ausgelegt, spezifische Probleme auf effiziente Weise zu lösen.

## Funktionen

### 1. `cpperm`

Die `cpperm`-Funktion kopiert Berechtigungen, Besitzer und Gruppeninformationen von einer Vorlagedatei oder einem Vorlagenordner auf ein anderes Ziel.

#### Verwendung:

```bash
cpperm <source> <destination>
Parameter:
<source>: Pfad zur Quelldatei oder zum Quellordner, von dem die Berechtigungen kopiert werden.
<destination>: Pfad zur Zieldatei oder zum Zielordner, auf den die Berechtigungen angewendet werden sollen.
Beispiel:
bash
Code kopieren
cpperm /path/to/source/file /path/to/destination/file
Dies wird die Berechtigungen, den Besitzer und die Gruppe von /path/to/source/file auf /path/to/destination/file kopieren.

2. swapfiles
Die swapfiles-Funktion tauscht zwei Dateien, indem sie ihre Namen vertauscht.

Verwendung:
bash
Code kopieren
swapfiles <file1> <file2>
Parameter:
<file1>: Pfad zur ersten Datei, die getauscht werden soll.
<file2>: Pfad zur zweiten Datei, die getauscht werden soll.
Beispiel:
bash
Code kopieren
swapfiles /path/to/file1 /path/to/file2
Dies wird file1 und file2 austauschen, indem die Dateien umbenannt werden.

Installation
Um diese Funktionen zu verwenden, fügen Sie sie einfach in Ihre .bashrc oder .bash_profile Datei ein. Dies ermöglicht Ihnen den Zugriff auf die Funktionen direkt aus Ihrem Terminal.

Lizenz
Dieses Projekt ist unter der MIT-Lizenz lizenziert. Weitere Informationen finden Sie in der LICENSE-Datei.

Beiträge
Beiträge sind willkommen! Bitte erstellen Sie ein Issue oder einen Pull-Request, wenn Sie verbesserte Funktionalitäten hinzufügen oder Fehler beheben möchten.

markdown
Code kopieren

### Anleitung zur Anpassung:
- **Repository-spezifische Informationen:** Sie sollten spezifische Details wie den Lizenztyp und die Beitragsrichtlinien entsprechend Ihrem Projekt anpassen.
- **Beispiele:** Passen Sie die Beispiel-Dateipfade an, um realistischere oder spezifische Beispiele für Ihre Zielgruppe zu bieten.
- **Installation und Nutzung:** Stellen Sie sicher, dass die Anweisungen klar und für alle potenziellen Nutzer Ihres Repositories verständlich sind.

Sie können diese `README.md`-Datei direkt in Ihr GitHub-Repository hochladen, um Ihre Shell-Funktionen z
