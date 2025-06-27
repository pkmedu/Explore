**…or create a new repository on the command line**

echo "\# Workshop" \>\> README.md

git init

git add README.md

git commit -m "first commit"

git remote add origin https://github.com/pkmedu/Workshop.git

git push -u origin master

### …or push an existing repository from the command line

git remote add origin https://github.com/pkmedu/Workshop.git

git push -u origin master

If you're using Windows it will not let you create a file without a filename in
Windows Explorer. It will give you the error "*You must type a file name*" if
you try to rename a text file as **.gitignore**

To get around this I used the following steps

1.  Create the text file gitignore.txt

2.  Open it in a text editor and add your rules, then save and close

3.  Hold SHIFT, right-click the folder you're in, then select **Open command
    window here**

4.  Then rename the file in the command line, with ren gitignore.txt .gitignore

There are 3 files with an extension .SAS that were being tracked by git, but now
the files with that extension (.SAS) are on the .gitignore list.

However, these files keep showing up in git status after the .gitignore list is
edited. How do you force git to completely forget about them without being
deleted from the local repo but are are removed from the remote repo?

To stop tracking a file you need to remove it from the index. This can be
achieved with this command.

git rm --cached \<file\>

If you want to remove a whole folder, you need to remove all files in it
recursively.

git rm -r --cached \<folder\>

The removal of the file from the head revision will happen on the next commit.

How to undo git rm
------------------

Executing git rm is not a permanent update. The command will update the staging
index and the working directory. These changes will not be persisted until a new
commit is created and the changes are added to the commit history. This means
that the changes here can be "undone" using common Git commands.

git reset HEAD

A Quick Guide for Making a Git Ignore (.gitignore) File for Jupyter Notebook Based Projects/Repositories
========================================================================================================

<https://medium.com/@cruble/a-quick-guide-for-making-a-git-ignore-gitignore-e645d70676b2>

\# Clone the GithHub repository  
C:\\ git vs github \\\> git clone http://github.com/abc/rps.git

\# Create a new file  
C:\\ git vs github \\\> touch what-is-git-and-github.txt

\# Add the file to the Git tracking mechanism  
C:\\ git vs github \\\> git add what-is-git-and-github.txt

\# Commit the changes to Git locally  
C:\\ git vs github \\\> git commit -m "Git and GitHub tutorial"

\# Push local Git commits back to the GitHub server  
C:\\ git vs github \\\> git push origin

git config --global core.autocrlf false

But if your user and email is not yet setup, the above might ask to set those
up. In that case you run:

git config --local core.autocrlf false

Although the issue with --local is that you have to do it for each repo but
global will take care of all the repos.

To know more, read here:  
<https://stackoverflow.com/questions/17628305/windows-git-warning-lf-will-be-replaced-by-crlf-is-that-warning-tail-backwar/38112001> 

If you set it for --global you won't have it do it for every session. Local
configs are mostly overwritten by remote.  
To setup you profile correctly follow the instructions from here:  
<https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup> 

For github:  
<https://kbroman.org/github_tutorial/pages/first_time.html> 
