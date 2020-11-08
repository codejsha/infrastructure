# Directory commands

## List directory contents (ls)

some options:

```txt
  -a, --all                  do not ignore entries starting with .
  -A, --almost-all           do not list implied . and ..
      --block-size=SIZE      scale sizes by SIZE before printing them; e.g.,
                               '--block-size=M' prints sizes in units of
                               1,048,576 bytes; see SIZE format belowls
      --file-type            likewise, except do not append '*'
  -h, --human-readable       with -l, print sizes in human readable format
                               (e.g., 1K 234M 2G)
      --hide=PATTERN         do not list implied entries matching shell PATTERN
                               (overridden by -a or -A)
  -I, --ignore=PATTERN       do not list implied entries matching shell PATTERN
  -l                         use a long listing format
  -r, --reverse              reverse order while sorting
  -R, --recursive            list subdirectories recursively
  -S                         sort by file size
  -t                         sort by modification time, newest first

  -Z, --context              Display security context so it fits on most
                             displays.  Displays only mode, user, group,
                             security context and file name.
```

## Make links between files (ln)

```txt
Usage: ln [OPTION]... [-T] TARGET LINK_NAME   (1st form)
  or:  ln [OPTION]... TARGET                  (2nd form)
  or:  ln [OPTION]... TARGET... DIRECTORY     (3rd form)
  or:  ln [OPTION]... -t DIRECTORY TARGET...  (4th form)
In the 1st form, create a link to TARGET with the name LINK_NAME.
In the 2nd form, create a link to TARGET in the current directory.
In the 3rd and 4th forms, create links to each TARGET in DIRECTORY.
```

some options:

```bash
  -s, --symbolic              make symbolic links instead of hard links
```

examples:

```bash
ln -s ${ORACLE_HOME}/${DOMAIN_NAME} ${DOMAIN_HOME}
```

## Removal via unlink(2) (unlink)

examples:

```bash
unlink ${DOMAIN_HOME}
```
