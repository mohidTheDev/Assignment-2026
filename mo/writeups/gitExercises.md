Git Exercises
1.  master
`git start master` and then `git start next` to go to the next exercise

2. commit-one-file
first added A.txt to staging area using `git add A.txt` then committed changes using `git commit -m "commit A"`

3. commit-one-file-staged
committed just A.txt using `git commit A.txt -m "commit A"`

4. ignore-them
created a .gitignore file using the touch program
added "/libraries", "*.exe", "*.o", "*.jar" in the file using `nano .gitignore`
and then staged and committed .gitignore

5. chase-branch
forced chase-branch to point to the commit pointed to by escaped using `git reset --hard escaped`

6. merge-conflict
The two branches "merge-conflict" and "another-piece-of-work" had differences in the file "equation.txt" and so trying to merge them results in a merge conflict. In one branch the file had "2 + ? = 5" and the other had "? + 3 = 5". By changing the text to "2+3=5", the merge conflict is resolved. Add equation.txt and commit to resolve the merge conflict.

7. saving-your-work
The command used here is "stash". "git stash" saves all changes and removes them from the working area. The bug in the bug.txt was just a line of text. After removing that and committing the changes, "git stash pop" is used to bring back the changes. After updating bug.txt, changes are staged and committed.

8. change-branch-history
`git rebase hot-bugfix` makes it so the commit in the branch "change-branch-history" is moved to the branch "hot-bugfix"

9. remove-ignored
the file can be removed simply using `rm ignored.txt` and then staging and committing the changes.

10. case-sensitive-filename
The mv command is used to rename files. `mv File.txt file.txt`. Then stage and commit the changes.

11. fix-typo
First use "nano file.txt" to fix the typo. Use `git log` to look at last commit and the commit message, which also has the same typo. Use `git commit --amend -m "Add Hello world"` to modify the previous commit instead of making a new one.

12. forge-date
The previous commit can be overwritten with a new one in which we manually set the date using `git commit --amend --date "1987-01-01 00:00:00"`

13. fix-old-typo
Do `git rebase -i` to use interactive rebase. Modify the second newest commit (Add Hello wordl) by changing "pick" to "edit". Fix the typo in the file and stage it. Do `git rebase --continue` to continue rebasing. It then asks for changes in the commit message. Fix the typo there too. Then, a merge conflict is encountered since the next commit changes the file too. Fix that and stage the file again. Continue the rebase and leave the next commit message unchanged. The rebase is now complete.
