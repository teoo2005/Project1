#!/bin/bash
set +m # e o comanda sa nu mai arate in terminal cand se face fiecare instructiune in fundal
echo "Numele utilizator pentru raport:"
read nume

linie=$(grep ",$nume," utilizatori.csv)

if [ -z "$linie" ]; then
    echo "Eroare: Utilizatorul $nume nu este inregistrat.Inregistrati va mai intai."
    return
fi

# extragem id-ul  folosind sed , primul camp pana la prima virgula
id=$(echo "$linie" | sed 's/,.*//')

# raportul asincron (in fundal cum e pe gitbook )
raport="/home/$id/raport.txt"             # pt putty ./$id
{
     #echo "Se genereaza raportul pentru utilizatorul $nume " afiseaza prost 
    nrFis=$(find "/home/$id" -type f | wc -l) # pt putty ./$id
    nrDir=$(find "/home/$id" -type d | wc -l)
    dimensiune=$(du -sh "/home/$id" | sed 's/\s.*//')

    echo "Raport pentru utilizatorul $nume" > "$raport"
    echo "Numar de fisiere este de $nrFis" >> "$raport"
    echo "Numar de directoare este de $nrDir" >> "$raport"
    echo "Dimensiune totala pe disc este de $dimensiune" >> "$raport"

    
} &
echo "S-a  generat  raportull in: $raport"


