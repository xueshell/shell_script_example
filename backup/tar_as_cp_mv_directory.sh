
Copy files and directories recursively with tar
Posted September 28, 2003 by Quinn McHenry in UNIX 
Copying a directory tree and its contents to another filesystem using tar will preserve ownership, permissions, and timestamps. A neat trick allows using tar to perform a recursive copy without creating an intermediate tar file.

To copy all of the files and subdirectories in the current working directory to the directory /target, use:
tar cf - * | ( cd /target; tar xfp -)
The first part of the command before the pipe instruct tar to create an archive of everything in the current directory and write it to standard output (the – in place of a filename frequently indicates stdout). The commands within parentheses cause the shell to change directory to the target directory and untar data from standard input. Since the cd and tar commands are contained within parentheses, their actions are performed together.
The -p option in the tar extraction command directs tar to preserve permission and ownership information, if possible given the user executing the command. If you are running the command as superuser, this option is turned on by default and can be omitted.

 

The Conversation
Follow the reactions below and share your own thoughts.
x 
Better is
tar cf – . | tar -C /target -xpf –
Mikel Stous 
I’ve usually seen it with B for reassembling short reads into full records (reading 4.2BSD pipes). In other words, rightsize the blocks for the filesystem.
tar cf – * | ( cd /target; tar xfBp -)
Soumen78 
I have some link in my src area and these links _could_ be broken under certain circumstances and I want to ignore such error and proceed. How do I pass “–ignore-failed-read” in “tar cfhi – . | ( tar -C ~/releases/tmp_new xpf – )”?
Karen 
Except -C is not a very standard option on tar. The ‘tar’ command in Solaris does not accept this, and I doubt it would be accepted on AIX or HP-UX either. 
Janis 
Beware, don’t use this approach in a script!
It could fail and if you just check return codes
you won’t even notice.
tar cf – * | ( cd /target; tar xfp -)
What if cd /target; fails? (maybe because it does not exist)
Tar will try to copy the files on themselves. That fails but
nevertheless I get a return code of 0 in my test.
Better use this (and you will get return code 1):
tar cf – * | ( cd /target && tar xfp -)
Or use the -C option as an alternative.