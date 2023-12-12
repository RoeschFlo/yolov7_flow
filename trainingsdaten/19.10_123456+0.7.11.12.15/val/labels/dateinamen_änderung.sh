#!/bin/bash

# Liste der PNG-Bilder im Ordner
image_list=(*.txt)

# Startnummer für die Nummerierung
start_number=2001

# Schleife, um durch die Bilder in der Liste zu iterieren
for image_path in "${image_list[@]}"; do
    # Überprüfe, ob es sich um eine Datei handelt
    if [ -f "$image_path" ]; then
        # Überprüfe, ob das Bild bereits das gewünschte Format hat
        #if [[ ! "$image_path" =~ ^[0-9]{6}\.png$ ]]; then
            # Erzeuge eine Nullvoranstellung der Nummer
            padded_number=$(printf "%06d" "$start_number")

            # Extrahiere die Dateierweiterung
            extension="${image_path##*.}"

            # Ziel-Pfad für das nummerierte Bild
            new_image_path="${padded_number}.${extension}"

            # Benenne das Bild um
            mv "$image_path" "$new_image_path"

            # Erhöhe die Nummer für das nächste Bild
            ((start_number++))
            
            # Überprüfe, ob die maximale Nummer erreicht ist
            if [ $start_number -gt 999999 ]; then
                echo "Maximale Nummer erreicht."
                break
            fi
        #fi
    fi
done

echo "Nummerierung abgeschlossen."
