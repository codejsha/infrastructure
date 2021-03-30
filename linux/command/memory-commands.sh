######################################################################

### get free memory

free -t
free --total

### human-readable
free -th
free --total --human

### low high statistics
free -thl
free --total --human --lohi

### repeatly
free -th -s ${SECONDS} -c ${COUNT}
free --total --human --seconds ${SECONDS} --count ${COUNT}
