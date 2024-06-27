# cpperm - Berechtigungen kopieren

Das Skript `cpperm` ermöglicht das Kopieren von Berechtigungen, Eigentümer und Gruppeninformationen von einer Quelldatei oder einem Quellordner zu einem Zieldatei oder Zielordner unter Linux.

## Funktionsweise

`cpperm` nutzt die Linux-Befehle `stat`, `chmod` und `chown`, um die Berechtigungen sowie die Besitzer- und Gruppeninformationen von einem Objekt (Datei oder Verzeichnis) zu extrahieren und diese auf ein anderes Objekt zu übertragen.

## Voraussetzungen

Um `cpperm` nutzen zu können, müssen Sie Zugriff auf einen Linux-basierten Computer haben und Berechtigungen besitzen, die es Ihnen erlauben, `chmod` und `chown` auszuführen.

## Installation

Fügen Sie die `cpperm` Funktion zu Ihrer Bash-Konfigurationsdatei hinzu (`~/.bashrc`, `~/.bash_profile` oder `~/.profile`)


# Verwendung
Um cpperm zu verwenden, rufen Sie das Skript aus Ihrem Terminal wie folgt auf:

```bash
cpperm /pfad/zur/quelle /pfad/zum/ziel


# swapfiles - Dateien sicher tauschen

Das Bash-Skript `swapfiles` ermöglicht das sichere Tauschen von zwei Dateien auf einem Linux-basierten System. Dieses Skript stellt sicher, dass keine Daten während des Tauschvorgangs verloren gehen.

## Funktionsweise

`swapfiles` nutzt temporäre Dateien und ein temporäres Verzeichnis, um sicherzustellen, dass die Dateien effektiv und sicher getauscht werden, ohne dass Datenverluste entstehen. Dies ist besonders nützlich in Szenarien, wo Dateien kritische Informationen enthalten oder sehr groß sind.

# Verwendung
Um swapfiles zu verwenden, rufen Sie das Skript aus Ihrem Terminal wie folgt auf:

```bash
swapfiles /pfad/zur/datei1 /pfad/zur/datei2

Ersetzen Sie /pfad/zur/datei1 und /pfad/zur/datei2 durch die tatsächlichen Pfade der Dateien, die Sie tauschen möchten.
