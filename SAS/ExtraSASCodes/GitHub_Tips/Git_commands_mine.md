**Example – Git cloning**

Pradip Muhuri\@Lenovo-PC MINGW64 \~ (master)

\$ git clone <https://github.com/SAS-Class/LearnSAS.git>

The following is the output.

Cloning into 'LearnSAS'...

**Example – Renaming a file**

\$ git mv Ex_put_putlog.sas Ex_put_putlog34.sas

**Example – Deleting a file**

\$ git rm Git_Examples_RubyGarage.docx

\$ git rm -f SASPy_test.sas

rm 'Week2/SASPy_test.sas'

[Removing files/folders in
Git](https://www.jquery-az.com/remove-file-directory-git/)

git rm --cached file1.txt

git commit -m "remove file1.txt"

And to push changes to remote repo

git push origin branch_name

**Example Remove a directory from the local repo and the remote rep**

-   git rm -r Week12

-   git commit -m "Removed"

-   git push

**Deleting multiple files example**

Suppose, we have a folder name “del-demo” that contains five text files
(tst1.txt, tst2.txt tst3.txt tst4.txt tst5.txt). We want to remove three files
by the single command and upload the changes. This is how it can be done:

\$ git rm del-demo/tst2.txt del-demo/tst3.txt del-demo/tst4.txt

**The output should be:**

rm ‘del-demo/tst2.txt’

rm ‘del-demo/tst3.txt’

rm ‘del-demo/tst4.txt’

Now run the commit command:

\$ git commit -m “Removed three text files”

Now you are good to go for making a push and making changes online.

How to remove the file from the Git repository **and the local drive?**

PMuhuri\@CCASTA-HWJP0G2 MINGW64 /c/AnalyzeMEPS (master)

\$ git rm Untitled.ipynb

rm 'Untitled.ipynb'

[How to remove a file from the remote repo
(GitHub)?](https://stackoverflow.com/questions/2047465/how-can-i-delete-a-file-from-git-repo)

If you deleted a file from the working tree, then commit the deletion:

git commit -a -m "A file was deleted"

And push your commit upstream:

git push

PMuhuri\@CCASTA-HWJP0G2 MINGW64 /c/sascourse (master)

\$ git branch -m backup_folders SASCourse_rev

PMuhuri\@CCASTA-HWJP0G2 MINGW64 /c/sascourse (master)

\$ git push origin :backup_folders

PMuhuri\@CCASTA-HWJP0G2 MINGW64 /c/sascourse (master)

\$ git push --set-upstream origin SASCourse_rev

Remove a file from index with git rm --cached before commit
===========================================================

The cached option specifies that the removal should happen only on the staging
index. Working directory files will be left alone.

![](media/888f271433ea585e8f91e3b252c3a248.png)

PMuhuri\@CCASTA-HWJP0G2 MINGW64 /c/AnalyzeMEPS (master)

\$ git config --local core.autocrlf false

git config --global core.autocrlf false

But if your user and email is not yet setup, the above might ask to set those
up. In that case you run:

To know more, read here:  
<https://stackoverflow.com/questions/17628305/windows-git-warning-lf-will-be-replaced-by-crlf-is-that-warning-tail-backwar/38112001> 

PMuhuri\@CCASTA-HWJP0G2 MINGW64 /c/AnalyzeMEPS (master)

\$ git config --global core.autocrlf false

PMuhuri\@CCASTA-HWJP0G2 MINGW64 /c/AnalyzeMEPS (master)

\$ git remote set-url origin <https://github.com/pkmedu/AnalyzeMEPS>
