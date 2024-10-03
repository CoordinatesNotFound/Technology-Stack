# Linux Command Line



## Getting help

- [whatis](https://manpages.ubuntu.com/manpages/precise/en/man1/whatis.1.html) - Display a brief description of a command.
- [man](https://manpages.ubuntu.com/manpages/focal/en/man1/man.1posix.html)  Open the manual.
- `<command> -h`; `<command> --help` - The help parameters for most commands.

 

## Navigation

- [File System Hierarchy (FHS)](https://www.pathname.com/fhs/pub/fhs-2.3.pdf)
- [cd](https://manpages.ubuntu.com/manpages/focal/en/man1/cd.1posix.html) - Change directory.
- [ls](https://manpages.ubuntu.com/manpages/focal/man1/ls.1.html) - List contents.
- [pwd](https://manpages.ubuntu.com/manpages/focal/en/man1/pwd.1posix.html) - Print current path.
- [find](https://www.geeksforgeeks.org/find-command-in-linux-with-examples/) - Search through the system.
- [clear](https://manpages.ubuntu.com/manpages/focal/en/man1/clear.1.html) - Clears the screen. Ctrl + L
- `pushd`, `popd` - Temporary relocation to a directory and return.

 

## Viewing data

- [cat](https://manpages.ubuntu.com/manpages/focal/en/man1/cat.1plan9.html) - Dump content to terminal.
- [head](https://manpages.ubuntu.com/manpages/focal/en/man1/head.1posix.html) - Read start.
- [tail](https://manpages.ubuntu.com/manpages/focal/en/man1/tail.1posix.html) - Read end.
- [less](https://manpages.ubuntu.com/manpages/focal/en/man1/less.1.html) - Progressively read contents.
- [grep](https://en.wikipedia.org/wiki/Grep) - Text search.

 

## File handling

- [touch](https://manpages.ubuntu.com/manpages/focal/en/man1/touch.1posix.html) - Often used for, but not limited to, file creation.
- [mkdir](https://manpages.ubuntu.com/manpages/precise/man2/mkdir.2.html) - Create directory.
- [file](https://manpages.ubuntu.com/manpages/focal/en/man1/file.1.html) - Check file type.
- [cp](https://manpages.ubuntu.com/manpages/focal/en/man1/cp.1.html) - Copy.
- [mv](https://manpages.ubuntu.com/manpages/focal/en/man1/mv.1.html) - Move and rename.
- [rm](https://manpages.ubuntu.com/manpages/trusty/man1/rm.1.html) - Delete files and directories. Handle with care.
- [rmdir](https://manpages.ubuntu.com/manpages/trusty/man1/rmdir.1posix.html) - Delete directories.
- [shred](https://manpages.ubuntu.com/manpages/trusty/man1/shred.1.html) - Overwrite file and optionally delete it.

 

## File compression

- [zip](https://manpages.ubuntu.com/manpages/focal/en/man1/zip.1.html), [unzip](https://manpages.ubuntu.com/manpages/focal/en/man1/unzip.1.html) - Zip archives.
- [gzip](https://manpages.ubuntu.com/manpages/focal/en/man1/gzip.1.html), [gunzip](https://manpages.ubuntu.com/manpages/focal/en/man1/gunzip.1.html) - Gzip archives.
- [tar](https://manpages.ubuntu.com/manpages/focal/en/man1/tar.1.html) - Tar archives or tarballs. Extract: `-xzf`. Compress: `-czf`.

 

## Identities and permissions

- [File permissions and chmod](https://www.computerhope.com/unix/uchmod.htm), [chown](https://www.computerhope.com/unix/uchown.htm) - Modify right and ownership.
- [adduser](https://www.digitalocean.com/community/tutorials/how-to-add-and-delete-users-on-an-ubuntu-14-04-vps) - Adding user
- [sudo](https://en.wikipedia.org/wiki/Sudo) - "SuperUser DO"
- [su](https://manpages.ubuntu.com/manpages/focal/en/man1/su.1.html) - Switch to, or run command as, another user. Combine with sudo for root user.
- [Passwords](https://www.computernetworkingnotes.com/linux-tutorials/etc-shadow-file-in-linux-explained-with-examples.html) - /etc/passwd 
- [whoami](https://manpages.ubuntu.com/manpages/focal/en/man1/whoami.1.html) - Print current user.
- [id](https://manpages.ubuntu.com/manpages/focal/en/man1/id.1.html) - Detailed user information.

 

## Shell variables

- [Shell variables](https://www.tutorialspoint.com/unix/unix-using-variables.htm)
- [Environment variables](https://www.redhat.com/sysadmin/linux-environment-variables)

 

## Command chaining

- [Input/Output redirection](https://www.tutorialspoint.com/unix/unix-io-redirections.htm) - Control input and output from commands (>, >>, <, <<)
- [Pipe (|)](https://www.howtogeek.com/438882/how-to-use-pipes-on-linux/) - Redirect output from one command as input to next.

 

## Processes

- [ps](https://manpages.ubuntu.com/manpages/focal/en/man1/ps.1posix.html) - Show running processes.
  - [aux on ps](https://unix.stackexchange.com/questions/106847/what-does-aux-mean-in-ps-aux)
- [top](https://manpages.ubuntu.com/manpages/focal/en/man1/top.1.html), [htop](https://manpages.ubuntu.com/manpages/focal/en/man1/htop.1.html) - Process viewers.
- [Signals](https://www.tutorialspoint.com/unix/unix-signals-traps.htm) - Send various software interrupts. Ctrl + c = interrupt.
- [kill](https://manpages.ubuntu.com/manpages/focal/en/man1/kill.1.html) - Send signals to processes. Uses PID.
- [pgrep/pkill](https://manpages.ubuntu.com/manpages/focal/en/man1/pkill.1.html) - Find and signal based on process names.



## Service management

- [Systemd](https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units) - System manager
  - [systemctl](https://manpages.ubuntu.com/manpages/focal/en/man1/systemctl.1.html) - Services management. 
- [Cron and Crontab](https://linuxhandbook.com/crontab/) - Schedule tasks on a system

 

## Multi-tasking

- [jobs](https://manpages.ubuntu.com/manpages/focal/en/man1/jobs.1posix.html) - Display suspended or backgrounded processes.
- [fg](https://manpages.ubuntu.com/manpages/focal/en/man1/fg.1posix.html) - Run jobs in the foreground
- [bg](https://manpages.ubuntu.com/manpages/focal/en/man1/bg.1posix.html) - Run jobs in the background
- [tmux](https://manpages.ubuntu.com/manpages/focal/en/man1/tmux.1.html)- Run multiple terminals in one window, among other things.
  -  [tmux cheat sheet](https://tmuxcheatsheet.com/) 

 

## Package management

- [which](https://manpages.ubuntu.com/manpages/focal/en/man1/which.1.html) - Where a "command" is installed.
- [whereis](https://manpages.ubuntu.com/manpages/focal/en/man1/whereis.1.html) - More detailed package search.
- [APT](https://itsfoss.com/apt-command-guide/) - Managing and installing software.
- [DPKG](https://manpages.ubuntu.com/manpages/focal/en/man1/dpkg.1.html) - Debian Package Manager.
- [Package management cheat sheet](https://wiki.archlinux.org/title/Pacman/Rosetta) - Many commands + translations across distributions. Kali uses *apt*.

 

## Text editors

- [Nano](https://manpages.ubuntu.com/manpages/focal/en/man1/nano.1.html) - Simple and straightforward.
- [Vi/Vim](https://www.tutorialspoint.com/unix/unix-vi-editor.htm) - Default text editers.