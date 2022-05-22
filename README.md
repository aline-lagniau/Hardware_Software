# Servo Reader with DE0-Nano-SoC

-> Membres du groupe 3 : BENOMRAN Victor, DUPONT Chloé & LAGNIAU Aline

Ce projet est réalisé dans le cadre du cours de Hardware/Software, prenant place dans le cursus de première Master en Electrical Engineering à la Faculté Polytechnique de Mons. Le but de ce projet est de lire les informations reçues par un Servo Moteur, à l'aide du kit de développement DE0-Nano-SoC. Ce dernier présente une plateforme de conception matérielle robuste architecturée sur le FPGA SoC Altera. Les informations à lire seront de deux types : un compteur et un lecteur de fréquence.

Le tuto suivant permet d'introduire aux lecteurs des bases en VHDL, un langage de programmation. L'outil utilisé pour créer ce programme est 'Quartus'.

Ce tuto est divisé en 2 parties principales : Software & Hardware.

La partie Hardware est responsable des I/O choisies et implémentées via 'Platform Designer' dans 'Quartus'. Le membre responsable du Hardware doit également compléter le 'ghrd' du programme afin d'y ajouter le bloc relatif à notre projet (contenant les I/O, clk, rst... utilisés). Il doit également créer un programme (ServoIn dans le cas présent) dont le but est d'établir un 'count' et un compteur de fréquence. Le 'count' compte le nombre de battements d'horloge entre deux états S1. La fréquence est déterminée à l'aide de ce 'count'. Finalement, le membre Hardware crée un TestBench dont l'objectif est de simuler le comportement du programme ServoIn avant de le lier à la partie Software et au processeur.

La partie Software doit quant-à-elle modifier le Main.c directement envoyé sur le processeur, permettant d'afficher les informations reçues et décodée à l'aide du programme ServoIn venant du Hardware. Le membre Software est également responsable de connecter le processeur à l'ordinateur, d'y envoyer les programmes nécessaires et de le faire fonctionner. Finalement, il doit être capable de lire à l'oscilloscope les signaux reçus et lu via le processeur.

Afin de tester le programme final, le comportement d'un Servo Moteur sera simulé par une carte PIC envoyant les informations nécessaires à la détermination du 'count' et de la fréquence. 

L'ensemble des membres de l'équipe vous souhaite un bon visionnage et espère que le VHDL n'aura plus de secret pour vous après ce tuto !


