#!/bin/bash
#lang=fr

#Script pour Pacman ( car il y a trop de commandes a retenir )
#Cree par Dylage durant son temps libre
#Sous licence GPL, amusez vous avec
 
#N'oubliez pas de le rendre executable et d'etre root / sudo
#TODO: Ajouter un sudo / su automatique si un normal user le lance
#Et une traduction anglaise

#Vous pouvez egalement le mettre dans /usr/local/bin/ pour qu'il soit dans le PATH du shell
 
#Conseil :
#Perso j'ai mis un alias pour l'utiliser en marquant juste pm
#Pour celà, ajoutez dans votre ~/.bashrc :
#alias pm='sudo pacmenu.sh'
#Meme chose en root mais sans le sudo
 
#Affichage du menu
echo -e
echo "1-Synchroniser la liste des paquets"
echo "2-Mettre a jour suite a la synchronisation"
echo "3-Synchroniser puis mettre a jour"
echo "4-Telecharger puis installer un paquet"
echo "5-Installer un paquet via disque ou lien"
echo "6-Supprimer un paquet"
echo "7-Supprimer un paquet puis ses dependances"
echo "8-Supprimer un paquet et ses dependances et ses configs"
echo "9-Rechercher un paquet sur le systeme"
echo "10-Rechercher un paquet dans les depots"
 
echo "Votre choix :"
read choix #Lecture de la variable de choix
 
case $choix in #case depend donc de la variable choix
    1) pacman -Sy;;
    2) pacman -Su;;
    3) pacman -Syu;;
    4) echo "Quel paquet telecharger puis installer ?"
        read paq
        pacman -S $paq;;
    5) echo "Ou est le paquet a installer ?"
        read chemin
        pacman -U $chemin;;
    6)echo "Quel paquet supprimer ?"
        read nom
        pacman -R $nom;;
    7)echo "Quel paquet supprimer (avec dependances)"
        read nom1
        pacman -Rs $nom1;;
    8)echo "Quel paquet supprimer (avec dependances et config)"
        read nom2
        pacman -Rsn $nom2;;
    9)echo "Quel paquet rechercher dans le systeme ?"
        read nom3
        pacman -Qs $nom3 | more;; #pipe avec more pour la lecture
    10)echo "Quel paquet rechercher dans les depots ?"
        read nom4
        pacman -Ss $nom4 | more;;
    *) echo "erreur saisie";; #Si choix n'est pas entre 1 et 10
esac
