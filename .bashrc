cpperm() {
    if [ $# -ne 2 ]; then
        echo "Usage: cpperm <source> <destination>"
        return 1
    fi

    local src=$1
    local dest=$2

    # Sicherstellen, dass die Quelle existiert
    if [ ! -e "$src" ]; then
        echo "Source file or directory does not exist."
        return 1
    fi

    # Sicherstellen, dass das Ziel existiert
    if [ ! -e "$dest" ]; then
        echo "Destination file or directory does not exist."
        return 1
    fi

    # Holen der Berechtigungen, Besitzer und Gruppe von der Quelle
    local permissions=$(stat -c %a "$src")
    local owner=$(stat -c %U "$src")
    local group=$(stat -c %G "$src")

    # Übertragen der Berechtigungen, Besitzer und Gruppe auf das Ziel
    chmod $permissions "$dest"
    chown $owner:$group "$dest"

    echo "Permissions, owner, and group have been copied from $src to $dest."
}

swapfiles() {
    if [ $# -ne 2 ]; then
        echo "Usage: swapfiles <file1> <file2>"
        return 1
    fi

    local file1=$1
    local file2=$2

    # Überprüfen, ob beide Dateien existieren
    if [ ! -e "$file1" ]; then
        echo "File $file1 does not exist."
        return 1
    fi

    if [ ! -e "$file2" ]; then
        echo "File $file2 does not exist."
        return 1
    fi

    # Temporäre Datei zum sicheren Austauschen verwenden
    local tmpfile=$(mktemp)

    # Dateien umtauschen
    mv "$file1" "$tmpfile"
    mv "$file2" "$file1"
    mv "$tmpfile" "$file2"

    echo "Files $file1 and $file2 have been swapped."
}
