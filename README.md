# Setting up my development environment

This git repository was created with the aim of providing to each member of the BUDLAB collective all keys to being able to configure their own work environment in order to develop new projects in a professional manner while collaborating with the team, sharing sources, versioning the code and finally exploiting remote resources (dedicated server) to execute the processing inherent in the algorithms developed.

Le but de ce tutoriel est d'aboutir sur la mise en place d'un environnement de développement qui permet à chaque développeur d'éditer et tester du code source à distance sur le serveur de développement dédié à l'équipe. L'idée est de pouvoir travailler sur le serveur en épargnant la propre machine du développeur. En travaillant sur le serveur et en exploitant sa puissance (ressources), le poste de travail personnel n'est pas bloqué par des processus pouvant être très gourmants en énergie. Voici une illustration qui présente à merveille ce vers quoi tendre :

![overview development architecture](/figures/architecture-ssh.png "Text to show on mouseover")
*source : https://code.visualstudio.com/docs/remote/remote-overview*

Bien évidemment, le poste de travail personnel peut également être configuré afin de travailler directement dessus. Ce qui aura pour effet de ne pas utiliser la partie droite de l'illustration précédente.

## Note additionnelle
Des informations spécifiques au serveur de développement sont données dans les chapitres suivants. Afin de garantir une certaine confidentialité, les paramètres suivants :
- Adresse IP;
- Nom de l'hôte;

sont données à titre factice. L'adresse IP dans les exemples suivants est la **10.10.10.10** et le nom du serveur le **HEGBUDLAB**. Les informations réelles peuvent être demandée directement au responsable de l'équipe :

**Monsieur**\
Varone Sacha\
sacha.varone(at)hesge.ch | +41 22 558 65 32

À noter également que la plupart des exemples données ont été réalisés dans l'environnement **macOS Sonoma Version 14.1.1**. Dans le cas où le lecteur travaille avec Microsoft Windows ou une distribution Linux quelconque, il est recommandé de trouver les commandes équivalentes à l'aide de forum ou d'IA comme ChatGPT pour ne citer qu'elle.

## Prerequisites
In order to be able to follow this tutorial, the following items must be installed on the personal machine:

- Git
- Microsoft Visual Studio Code with Remote - SSH extension \
(Extension ID: **ms-vscode-remote.remote-ssh**)

Once these two tools have been correctly installed, the developper needs to configure the access to the git platform (GitHub, GitLab or c4science) using the SSH protocol. This protocol is used to access sources via Git and also to work remotely on the development server available to the team.

## Serveur de développement dédié
Le serveur à disposition de l'équipe est une machine virtuelle VMWare. Les ressources qu'il exploite sont attribuées et gérées par le service informatique de la Haute École de Gestion de Genève.

Les informations sur le matériel peuvent être obtenues via l'instruction suivante :

```
lscpu
```

À propos du système d'exploitaiton, l'instruction suivante permet d'en savoir davantage :

```
lsb_release -a
```

Pour accéder au serveur et son système de fichiers, le développeur doit utiliser un couple utiliseteur/mot de passe qu'il reçoit dès son entrée dans l'équipe.

Pour se connecter au serveur, le protocole ssh est utilisé. Voici la marche à suivre, via un terminal, pour se connecter au serveur :

```
ssh my_username@10.10.10.10
```

Une fois que la commande est passée, le serveur demande de renseigner le mot de passe associé à *my_username*.

Dès que la connexion est établie, toutes les commandes Linux peuvent être passée pour gérer le système.

## GitHub


For the purposes of this example, GitHub.com is the platform used.

Pour commencer, il faut créer un compte sur la plateforme GitHub.com.

After that, to be able to clone repositories through SSH without having to use a username and password pair (via HTTPS), you need to start by creating a private/public key pair. Pour cela, GitHub.com propose des tutoriels pour Windows, Linux et Mac.

Voici ce qu'il faut faire par ordre chronologique sur la machine du membre de l'équipe :

1. Générer une pair de clefs privé/publique;\
more details [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) on GitHub.com
2. L'ajouter à l'agent SSH;\
more details [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent) on GitHub.com
3. Lier les nouvelles clefs au compte GitHub.com;\
more details [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) on GitHub.com
4. Tester la connexion;\
more details [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection) on GitHub.com

Dès que ces étapes sont réalisées et que le test de connexion est concluant, il sera possible de cloner des repository et de travailler avec selon les bonnes pratiques Git ([get Git Cheat Sheet](https://wac-cdn.atlassian.com/dam/jcr:e7e22f25-bba2-4ef1-a197-53f46b6df4a5/SWTM-2088_Atlassian-Git-Cheatsheet.pdf?cdnVersion=1326)).

Afin de cloner les sources de ce répertoire Git, voici les étapes à effectuer sur la machine personnelle du développeur :

```
cd path_where_clone_it
git clone git@github.com:Soprath/devonbudlabserver.git
cd devonbudlabserver
``````

En exécutant la commande *ls*, vous pourrez apercevoir le contenu (les sources) de tout le répertoire.

Lorsque le développeur initie une nouvelle connexion avec le serveur dédié, il est très appréciable de pouvoir utiliser les paramètres ssh de sa machine plutôt que d'avoir à reconfigurer ssh et regénérer les clés privé/publique sur le serveur. En effet, pour des raisons de sécurité, ce n'est pas idéal d'avoir des clés stockées à divers endroits. Pour y parvenir, il faut configurer le transfert de l'agent ssh. GitHub.com propose une [marche à suivre](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/using-ssh-agent-forwarding) pour cela.

## Développement distant
Pour être capable de développer du code sur le serveur dédié, il faut tout d'abord s'assurer que le transfert d'agent ssh est actif et que la pair de clés est ajoutée à l'agent, pour se faire ouvrez le terminal et  :
```
ssh-add -L
```
La commande doit retourner quelque chose qui ressemble à :\
*ssh-ed25519 9sjd0ifje03Qaifj04jfbXkfj9i8j votre_courriel@mon_domaine.ch*\
Dans le cas contraire, il faut lier votre pair de clés à l'agent avec la commande suivante :
```
ssh-add ~/.ssh/id_ed25519
```
Cela permettra à la session ssh distante d'utiliser vos paramétres locaux pour vous connecter sur GitHub (clone) et gérer vos versions de code (pull, commit, push, etc.).


## Exécution distante

## Docker OSRM server

## Ressources complémentaires