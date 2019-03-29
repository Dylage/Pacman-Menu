#!/bin/bash
#lang=fr

#Script pour Pacman ( car il y a trop de commandes a retenir )
#Cree par Dylage durant son temps libre
#Sous licence GPL, amusez vous avec

#TODO: Ajouter un sudo / su automatique si un normal user le lance
#Et une traduction anglaise
#Ainsi qu'une option --help

#N'oubliez pas de le rendre executable et d'etre root / sudo

#Vous pouvez egalement le mettre dans /usr/local/bin/ pour qu'il soit dans le PATH du shell

#Conseil :
#Perso j'ai mis un alias pour l'utiliser en marquant juste pm
#Pour celà, ajoutez dans votre ~/.bashrc :
#alias pm='sudo pacmenu.sh'
#Meme chose en root mais sans le sudo


#Verification root
if [ $(id -u) -ne 0 ]; then
	echo -e "\033[31mCertaines options nécessitent d'être en root\033[0m"
	rt='sudo' #demander un sudo pour les commandes importantes
else
	rt=" "
fi


choix=0

#Options rapides
if [ $# -ne 0 ];then
	
	#Pour n'afficher que le MENU
	if [ $1 == "a" ]; then
		choix=-1
	fi

    #Synchronisation avec les dépots
    #"j" pour mettre à jour
    if [ $1 == "synchro" ] || [ $1 == "j" ] || [ $1 == "Sy" ]; then
        choix=1
    fi

    #Pour mettre à jour le systeme (et la liste des paquets)
    if [ $1 == "upgrade" ] || [ $1 == "u" ] || [ $1 == "Syu" ]; then
        choix=3
    fi

    #Installation depuis les dépots
    if [ $1 == "install" ] || [ $1 == "i" ] || [ $1 == "S" ]; then
        choix=4
    fi

    #Recherche d'un paquet dans les dépots
    if [ $1 == "search" ] || [ $1 == "s" ] || [ $1 == "Ss" ]; then
        choix=10
    fi

    #Attention, ici j'ai mis celle qui supprime avec les dépendances car elle est, à mes yeux, la plus utile
    #Il ne s'agit que de mon avis, modifiez l'option à souhait
    if [ $1 == "remove" ] || [ $1 == "r" ] || [ $1 == "R" ]; then
        choix=7
    fi
fi

#On affiche le menu seulement en l'absence d'arguments
if [ $choix == -1 ] || [ $# -eq 0 ]; then
    #Affichage du menu
    echo -e "##################--MENU--##################"
    echo -e "En vert et entre crochet \033[32m[exemple]\033[0m, les options rapides"
    echo -e "1-\033[32m[j]\033[0m Synchroniser la liste des paquets"
    echo -e "2-Mettre a jour suite a la synchronisation"
    echo -e "3-\033[32m[u]\033[0m Synchroniser puis mettre a jour"
    echo -e "4-Telecharger puis installer un paquet"
    echo -e "5-\033[32m[i]\033[0m Installer un paquet via disque ou lien"
    echo -e "6-Supprimer un paquet"
    echo -e "7-\033[32m[r]\033[0m Supprimer un paquet puis ses dependances"
    echo -e "8-Supprimer un paquet et ses dependances et ses configs"
    echo -e "9-Rechercher un paquet sur le systeme"
    echo -e "10-\033[32m[s]\033[0m Rechercher un paquet dans les depots"

	if (( $choix != "-1" )); then
		echo "Votre choix :"
		read choix #Lecture de la variable de choix
	else
		echo -e "############################################"
		echo -e
	fi
fi

case $choix in #case depend donc de la variable choix
	1) pacman -Sy;;
	2) pacman -Su;;
	3) $rt pacman -Syu;;
	4)	if [[ $# -eq 0 ]]; then #Si on est passé par l'option rapide, inutile de demander
			echo "Quel paquet telecharger puis installer ?"
			read paq
		else
			paq=$2
		fi

		$rt pacman -S $paq;;
	5) echo "Ou est le paquet a installer ?"
		read chemin
		$rt pacman -U $chemin;;
	6) echo "Quel paquet supprimer ?"
		read nom
		$rt pacman -R $nom;;
	7)	if [[ $# -eq 0 ]]; then #Si on est passé par l'option rapide, inutile de demander
			echo "Quel paquet supprimer (avec dependances)"
			read nom1
		else
			nom1=$2
		fi

		$rt pacman -Rs $nom1;;
	8) echo "Quel paquet supprimer (avec dependances et config)"
		read nom2
		$rt pacman -Rsn $nom2;;
	9) echo "Quel paquet rechercher dans le systeme ?"
		read nom3
		pacman -Qs $nom3 | more;; #pipe avec more pour la lecture
	10) if [[ $# -eq 0 ]]; then #Si on est passé par l'option rapide, inutile de demander
			echo "Quel paquet rechercher dans les depots ?"
			read nom4
		else
			nom4=$2
		fi

		pacman -Ss $nom4 | more;;
	0) echo -e "\033[31mErreur saisie, cette option rapide n'existe pas !\033[0m";;
	-1) ;;
	*) echo -e "\033[31mErreur saisie\033[0m";; #Si choix n'est pas entre 1 et 10
esac
