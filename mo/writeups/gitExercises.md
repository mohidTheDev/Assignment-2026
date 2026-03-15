# Git Exercises
1.  ## master
 * Start this exercise. This completes it.
 * Start the next exercise.
```
git start master
git start next
```

2. ## commit-one-file
* Add A.txt to staging area.
* Commit changes.
```
git add A.txt
git commit -m "commit A"
```

3. ## commit-one-file-staged
* Commit just A.txt
```
git commit A.txt -m "commit A"
```

4. ## ignore-them
* Create a .gitignore file
* Inside it, add "/libraries", "\*.exe", "\*.o" and "\*.jar" 
* Stage and commit.
```
touch .gitignore
nano .gitignore
git add .
git commit
```

5. ## chase-branch
* Force chase-branch to point to the commit pointed to by escaped. 
```
git reset --hard escaped
```

6. ## merge-conflict
* The two branches "merge-conflict" and "another-piece-of-work" had differences in the file "equation.txt" and so trying to merge them results in a merge conflict. 
* In one branch the file had "2 + ? = 5" and the other had "? + 3 = 5". 
* By changing the text to "2+3=5", the merge conflict is resolved. 
* Add equation.txt and commit to resolve the merge conflict.
```
nano equation.txt
git add equation.txt
git commit
```
7. ## saving-your-work
* The command used here is "stash". 
* "git stash" saves all changes and removes them from the working area. 
* The bug in the bug.txt was just a line of text. After removing that and committing the changes, "git stash pop" is used to bring back the changes. 
* After updating bug.txt, changes are staged and committed.
```
git stash
nano bug.txt
git add bug.txt
git commit
git stash pop
nano bug.txt
git add .
git commit
```

8. ## change-branch-history
* Move the commit in the branch "change-branch-history: to the branch "hot-bugfix"
```
git rebase hot-bugfix
```

9.  ## remove-ignored
* Remove the file.
* Stage and commit changes.
```
rm ignored.txt
git add .
git commit
```
10. ## case-sensitive-filename
* Rename the file.
* Stage and commit the changes.
```
mv File.txt file.txt
git add .
git commit
```

11. ## fix-typo
First use "nano file.txt" to fix the typo. Use `git log` to look at last commit and the commit message, which also has the same typo. Use `git commit --amend -m "Add Hello world"` to modify the previous commit instead of making a new one.
* Edit the file to fix the typo
* Look at the log to see the commit message of the previous commit, which also has a typo.
* Modify the previous commit using the `--amend` option of the `git commit` command.
```
nano file.txt
git log
git commit --amend -m "Add Hello world"
```

12. ## forge-date
* The previous commit can be overwritten with a new one in which we manually set the date. 
```
git commit --amend --date "1987-01-01 00:00:00"
```

13. ## fix-old-typo
* Start interactive rebase.
* Choose to modify the second newest commit ("Add Hello wordl") by changing "pick" to edit".
* Fix the typo in the file.
* Stage the change.
* Continue rebase.
* It asks for changes in commit message. Fix the typo there too.
* A merge conflict is encountered. Edit the file to fix it.
* Stage the file once merge conflict is fixed.
* Continue rebase.
* Leave the next commit message unchanged.
* The rebase is now complete.
```
git rebase -i
nano file.txt
git add file.txt
git rebase --continue
nano file.txt
git add file.txt
git rebase --continue
```
