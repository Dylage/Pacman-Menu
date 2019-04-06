#!/bin/bash
#lang=fr

#Script pour Yaourt ( car il y a trop de commandes a retenir )
#Cree par Dylage durant son temps libre, adapté de mon autre menu pour Pacman
#Sous licence GPL, amusez vous avec

#TODO : Ajouter une traduction anglaise
#Ainsi qu'une option --help

#N'oubliez pas de le rendre executable et d'etre root / sudo

#Vous pouvez egalement le mettre dans /usr/local/bin/ pour qu'il soit dans le PATH du shell

#Conseil :
#Perso j'ai mis un alias pour l'utiliser en marquant juste ym
#Pour celà, ajoutez dans votre ~/.bashrc :
#alias ym='yaourtmenu.sh' #adapter au chemin (PATH)



choix=0

#Options rapides
if [ $# -ne 0 ];then

	#Pour n'afficher que le MENU
	if [ $1 == "a" ]; then
		choix=-1
	fi

    #Synchronisation avec les dépots
    #Pour mettre à jour le systeme (et la liste des paquets)
    if [ $1 == "upgrade" ] || [ $1 == "u" ] || [ $1 == "Syua" ]; then
        choix=1
    fi

    #Recherche interactive de paquets
    if [ $1 == "install" ] || [ $1 == "i" ] || [ $1 == "a" ] || [ $1 == "search" ] || [ $1 == "s" ]; then
        choix=4
    fi

fi

#On affiche le menu seulement en l'absence d'arguments
if [ $choix == -1 ] || [ $# -eq 0 ]; then
    #Affichage du menu
    echo -e "\033[31mCertaines options demanderont un 'sudo'\033[0m"
    echo -e "##################--MENU--##################"
    echo -e "En vert et entre crochet \033[32m[exemple]\033[0m, les options rapides"
    echo -e "1-\033[32m[u]\033[0m MAJ des logiciels de la base, des paquets des dépôts plus ceux de AUR."
    echo -e "2-\033[32m[s]\033[0m Recherche interactive d'un paquet"
    echo -e "3-Recherche des dépendances orphelines"
    echo -e "4-Gestion des fichiers de configuration"

	if (( $choix != "-1" )); then
		echo "Votre choix :"
		read choix #Lecture de la variable de choix
	else
		echo -e "############################################"
		echo -e
	fi
fi

case $choix in #case depend donc de la variable choix
	1) yaourt -Syua;;
	2)	if [[ $# -eq 0 ]]; then #Si on est passé par l'option rapide, inutile de demander
			echo "Quel paquet rechercher puis installer ?"
			read rech
		else
			rech=$2
			echo "Installation de $rech"
		fi

        yaourt -a $rech;;
	3) echo "Recherche des dépendances orphelines"
        yaourt -Qdt;;
	4) yaourt -C;;
	0) echo -e "\033[31mErreur saisie, cette option rapide n'existe pas !\033[0m";;
	-1) ;;
	*) echo -e "\033[31mErreur saisie\033[0m";; #Si choix n'est pas entre 1 et 10
esac
