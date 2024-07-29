# Git



## 1 Intro



### 1.1 What is Git

- Git
  - A version control system that stores reference points of snapshots of your codes
  - Creates linear timeline of all changes of codes



### 1.2 Installation

- [Git - Installing Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)



## 2 Git Basic



### 2.1 Git Init

- Git Init

  - Command
    ```bash
    git init
    ```

  - Usage

    - Initializes git inside the current directory
    - Genrate a `.git` and set to `master`branch





### 2.2 Git Add

- Three States

  - Working Directory
    - where all of the files and changes are living all the time
  - Staging Area
    - where files and directories we explicitly add to (tracking)
  - `.git` Directory (Repository)
    - where all snapshots are stored

- Git Status

  - Command
    ```bash
    git status
    ```

  - Usage

    - show the states/status of the files
      - red: untracked, need to be git add
      - green: tracked, ready to be git commit

- Git Add

  - Command
    ```
    git add <file>
    ```

  - Usage

    - Adds files to staging area

- Adding Multiple Files 

  - Command
    ```bash
    # of one type
    git add *.html
    
    # all in the directory
    git add .
    git add -A
    ```

    



### 2.3 Git Commit

- Git Commit

  - Command
    ```bash
    git commit -m "<message>"
    ```

  - Usage
    - Creates a snapshot of changes and store in git repository

- Git Log
  - Command
    ```bash
    git log
    ```

  - Usage

    - See the history of the snapshots created so far

  

### 2.4 Removing & Ignoring

- Git Reset

  - Command
    ```bash
    git reset HEAD <file>
    ```

  - Usage

    - Remove file from staging area

- `.gitignore`

  - Usage

    - List all the files that will be ignored when git add / git status

    



## 3 Git Branches



### 3.1 Intro

- Git Branches
  - Reference points to changes of codes



### 3.2 List All Branches

- List All Branches

  - Command
    ```bash
    git branch
    ```

  - Usage

    - List all branch



### 3.3 Adding a Branch

- Adding a Branch

  - Command
    ```bash
    git checkout -b <branch>
    ```

  - Usage

    - Adding a branch and move to it



### 3.4 Checking Out a Branch

- Checkout a Branch

  - Command
    ```bash
    git checkout <branch>
    ```

  - Usage

    - Change to a branch

  > You can also checkout a commit:
  > ```bash
  > git checkout <commit_id>
  > ```



### 3.5 Merging a Branch

- Merging a Branch

  - Command
    ```bash
    # on branch1
    git merge <branch2>
    ```

  - Usage 

    - Have a full history of changes and commits of both two branches 



### 3.6 Removing a Branch

- Removing a Branch

  - Command
    ```bash
    git branch -d <branch2>
    ```

    

## 4 GitHub



### 4.1 GitHub Basic

- [Hello World - GitHub Docs](https://docs.github.com/en/get-started/start-your-journey/hello-world)
- [GitHub flow - GitHub Docs](https://docs.github.com/en/get-started/using-github/github-flow)



### 4.2 Using Git with GitHub

- [Using Git - GitHub Docs](https://docs.github.com/en/get-started/using-git)