# Standard output commands

## Output the first part of files (head)

some options:

```txt
  -n, --lines=[-]K         print the first K lines instead of the first 10;
                             with the leading '-', print all but the last
                             K lines of each file
  -v, --verbose            always print headers giving file names
```

## Output the last part of files (tail)

some options:

```txt
  -n, --lines=K            output the last K lines, instead of the last 10;
                             or use -n +K to output starting with the Kth
  -v, --verbose            always output headers giving file names
```

## Number lines and write files (nl)

```bash
nl .bash_profile
#  1  # .bash_profile
#  
#  2  # Get the aliases and functions
#  3  if [ -f ~/.bashrc ]; then
#  4          . ~/.bashrc
#  5  fi
#  
#  6  # User specific environment and startup programs
#  
#  7  PATH=$PATH:$HOME/.local/bin:$HOME/bin
#  
#  8  export PATH
```

## Sort text files (sort)

```txt
Usage: sort [OPTION]... [FILE]...
  or:  sort [OPTION]... --files0-from=F
Write sorted concatenation of all FILE(s) to standard output.
```

some options:

```txt
Ordering options:
  -r, --reverse               reverse the result of comparisons
  -V, --version-sort          natural sort of (version) numbers within text
```

## Line, word, and byte counts (wc)

```txt
Usage: wc [OPTION]... [FILE]...
  or:  wc [OPTION]... --files0-from=F
Print newline, word, and byte counts for each FILE, and a total line if
more than one FILE is specified.  With no FILE, or when FILE is -,
read standard input.  A word is a non-zero-length sequence of characters
delimited by white space.
```

some options:

```txt
  -c, --bytes            print the byte counts
  -m, --chars            print the character counts
  -l, --lines            print the newline counts
  -w, --words            print the word counts
```

## Reverse files (tac)

```txt
Usage: tac [OPTION]... [FILE]...
Write each FILE to standard output, last line first.
With no FILE, or when FILE is -, read standard input.
```

## Convert tabs to spaces (expand)

```txt
Usage: expand [OPTION]... [FILE]...
Convert tabs in each FILE to spaces, writing to standard output.
With no FILE, or when FILE is -, read standard input.
```
