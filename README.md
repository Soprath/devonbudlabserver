# Setting up my development environment

This git repository was created with the aim of providing to each member of the BUDLAB collective all keys to being able to configure their own work environment in order to develop new projects in a professional manner while collaborating with the team, sharing sources, versioning the code and finally exploiting remote resources (dedicated server) to execute the processing inherent in the algorithms developed.

The aim of this tutorial is to set up a development environment that allows each developer to edit and test source code remotely on the development server dedicated to the team. The idea is to be able to work on the server while sparing the developer's own machine. By working on the server and exploiting its power (resources), the personal workstation is not blocked by processes that can consume a lot of energy. Here's an illustration that perfectly illustrates what we're aiming for:

![overview development architecture](/figures/architecture-ssh.png "Achitecture overview")
*source : https://code.visualstudio.com/docs/remote/remote-overview*

Of course, the personal workstation can also be configured to work directly on it. This will mean not using the right-hand side of the previous illustration.

## Additional note
Information specific to the development server is given in the following chapters. In order to guarantee a certain level of confidentiality, the following parameters :
- IP address;
- Host name;

are fictitious. The IP address in the following examples is **10.10.10.10** and the server name is **HEGBUDLAB**. The real information can be requested directly from the team manager:


**Varone Sacha**\
sacha.varone(at)hesge.ch | +41 22 558 65 32

It should also be noted that most of the examples given were carried out in the **macOS Sonoma Version 14.1.1** environment. If the reader is working with Microsoft Windows or any Linux distribution, it is recommended that they find the equivalent commands using a forum or AI such as ChatGPT, to name but one.

## Prerequisites
In order to be able to follow this tutorial, the following items must be installed on the personal machine:

- Git
- Microsoft Visual Studio Code with Remote - SSH extension \
(Extension ID: **ms-vscode-remote.remote-ssh**)

Once these two tools have been correctly installed, the developper needs to configure the access to the git platform (GitHub, GitLab or c4science) using the SSH protocol. This protocol is used to access sources via Git and also to work remotely on the development server available to the team.

## Dedicated development server
The server available to the team is a VMWare virtual machine. The resources it uses are allocated and managed by the IT department of the Haute École de Gestion de Genève.

Information on the hardware can be obtained via the following instruction:

```
lscpu
```

You can find out more about the operating system in the following instruction:

```
lsb_release -a
```

To access the server and its file system, developers must use a username/password pair that they receive as soon as they join the team.

The ssh protocol is used to connect to the server. Here's how to connect to the server via a terminal:

```
ssh my_username@10.10.10.10
```

Once the command has been placed, the server asks for the password associated with *my_username*.

Once the connection has been established, all Linux commands can be used to manage the system.

## GitHub
For the purposes of this example, GitHub.com is the platform used.

To get started, you need to create an account on the GitHub.com platform.

After that, to be able to clone repositories through SSH without having to use a username and password pair (via HTTPS), you need to start by creating a private/public key pair. For that purpose, GitHub.com offers tutorials for Windows, Linux and Mac.

Here's what needs to be done in chronological order on the team member's machine:

1. Generate a private/public key pair;\
more details [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent) on GitHub.com
2. Add it to the SSH agent;\
more details [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent) on GitHub.com
3. Link the new keys to the GitHub.com account;\
more details [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) on GitHub.com
4. Testing the connection;\
more details [here](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/testing-your-ssh-connection) on GitHub.com

Once these steps have been completed and the connection test is conclusive, it will be possible to clone repositories and work with them according to Git best practice ([get Git Cheat Sheet](https://wac-cdn.atlassian.com/dam/jcr:e7e22f25-bba2-4ef1-a197-53f46b6df4a5/SWTM-2088_Atlassian-Git-Cheatsheet.pdf?cdnVersion=1326)).

To clone the sources in this Git directory, follow these steps on the developer's personal machine:

```
cd path_where_clone_it
git clone git@github.com:Soprath/devonbudlabserver.git
cd devonbudlabserver
``````

By executing the *ls* command, you will be able to see the contents (the sources) of the entire directory.

When the developer initiates a new connection with the dedicated server, it is a great advantage to be able to use the ssh parameters on his machine rather than having to reconfigure ssh and regenerate the private/public keys on the server. For security reasons, it's not ideal to have keys stored in different places. To achieve this, you need to configure the transfer of the ssh agent. GitHub.com offers a [how to proceed](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/using-ssh-agent-forwarding) for it.

## Remote development
To be able to develop code on the dedicated server, you first need to ensure that the ssh agent transfer is active and that the key pair is added to the agent. To do this, open the terminal and :
```
ssh-add -L
```
The command should return something like :\
*ssh-ed25519 9sjd0ifje03Qaifj04jfbXkfj9i8j votre_courriel(a)mon_domaine.ch*\
If this is not the case, you need to link your key pair to the agent using the following command :
```
ssh-add ~/.ssh/id_ed25519
```
This will allow the remote ssh session to use your local settings to connect to GitHub (clone) and manage your code versions (pull, commit, push, etc.).

First of all, you need to launch the Microsoft VS Code IDE and ensure that the required extensions (*Julia, Remote - SSH and Remote - SSH: Editing Configuration Files*) are installed, as follows:

![VS Code home](/figures/VSCode-1.png "IDE Microsoft Visual Studio Code")

The bottom-left connection button lets you use the **Remote - SSH** extension to initiate a connection with a remote installation:

![remote-ssh extension](/figures/remote-ssh.png "SSH connection button")

When the button is pressed, the main bar appears and you need to enter the IP address of the machine you wish to connect to:

![remote-ssh extension](/figures/VSCode-2.png "Set the IP address of the target")

When the input is validated, VS Code asks for the authentication information. Simply enter them and validate again.

Once the connection has been established, the **Remote - SSH** field (connection button) indicates the status of the SSH connection **"SSH: 10.10.10.10"**. To work on the source code of a project, you need to use the explorer and use the **"Open Folder "** button if the sources are already on the machine or **"Clone Repository "** if you need to clone a git repository. In the latter case, you need to add the SSH connection string to the main bar and choose the local destination folder.

![explorer](/figures/VSCode-3.png "Open working folder")

Once the working folder is open, the various project files can be edited as if you were on your own local machine.

Execution and debugging also work in the same way. **Important to note** that if the connection is interrupted or the VS Code window is closed, any processing in progress is lost. For example, if you want to run long processes and be able to shut down your workstation without losing execution, you need to do things differently. The solution is to open a remote terminal (ssh connection) and run the processes from this terminal, taking care to detach the process from the window so that the window can be closed without killing the associated processes.

The next chapter explains how to proceed in this scenario.

## Remote execution
When you want to run scripts/programmes that are potentially going to run for a long time, it is essential to be able to leave your workstation without the processing stopping.

When working remotely with VS Code or when you connect to the dedicated development server with a terminal window and a process is launched, the process is attached to the caller (VS Code or Terminal). The impact of this is that if the calling program is closed, the linked process is also exited. In practice, the developer should remain connected throughout the execution time. This is sometimes not possible. For example, when a process is launched at the end of the day to run overnight.

The solution is to detach the process from the caller. This can only be done when the process is launched from a terminal window. Here's how to do it.

First, open Terminal and connect to the remote server via ssh :

```
user@laptop ~ % ssh my_username@10.10.10.10
```

Next, you need to go to the directory where the git repostory is cloned using the *ls* command. Once there, run the **batch.jl** script as follows:

```
...$ julia ./examples/batch.jl "test.txt" 1 10 12
```

This command launches the execution of the Julia code. The file "test.txt" will be created and the numbers 1 to 10 will be inserted into the file every 12 seconds.

When you confirm the instruction by pressing ENTER, the script is launched and the window is no longer available, as the code is running. If you close the window and return to the server, logging in as before, you will notice that the file has not continued to fill up from 1 to 10 as it should have done. This is because the **batch.jl** process was linked to the window that was closed, so the process did not succeed and was terminated on the way.

In order to be able to close the window and retrieve the complete result of the process by connecting to the remote host again, you need to run the command like this:

```
...$ nohup julia ./examples/batch.jl "test.txt" 1 10 12 &
```

By prefixing with the **nohup** keyword and sufixing with **&**. This modification affects the **batch.jl** process by dissociating it from the calling window. As a result, when the window closes, the process continues to run.

Once the command has been issued, the window is now free and not blocked by the process call. To identify the process and its identification number, the following command is useful: 

```
...$ ps aux | grep julia
```

Julia processes currently running are returned. It is also possible to replace the term "julia" with "batch.jl" to obtain only the process of interest.

When the instruction is passed as before, a file called **nohup.out** is created and filled with the **stdout** stream. It is also possible to process the **stderr** error stream and log everything in a file whose name and extension is defined directly by the user: 

```
...$ nohup julia ./examples/batch.jl "test.txt" 1 10 12 > myFile.myExtension 2>&1 &
```

This means that standard output (stdout) and error output (stderr) go directly into the myFile.myExtension file, which is written at the end of the process. This makes it possible to obtain feedback on the execution afterwards.

## Docker OSRM server

// Still to do... coming soon.

## Ressources complémentaires

Mettre éventuellement quelques liens complémentaires, à voir...