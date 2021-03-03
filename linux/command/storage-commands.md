# Storage commands

## Report file system disk usage (df)

some options:

```txt
  -a, --all             include pseudo, duplicate, inaccessible file systems
  -B, --block-size=SIZE  scale sizes by SIZE before printing them; e.g.,
                           '-BM' prints sizes in units of 1,048,576 bytes;
                           see SIZE format below
  -h, --human-readable  print sizes in human readable format (e.g., 1K 234M 2G)
```


## Report on disk usage (du)

some options:

```txt
  -d, --max-depth=N     print the total for a directory (or file, with --all)
                          only if it is N or fewer levels below the command
                          line argument;  --max-depth=0 is the same as
                          --summarize
  -h, --human-readable  print sizes in human readable format (e.g., 1K 234M 2G)
  -k                    like --block-size=1K
  -m                    like --block-size=1M
  -s, --summarize       display only a total for each argument
  -X, --exclude-from=FILE  exclude files that match any pattern in FILE
      --exclude=PATTERN    exclude files that match PATTERN
```
