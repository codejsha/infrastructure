# Infrastructure as Code

## Getting Started

### Clone repository

```bash
git clone https://github.com/codejsha/infrastructure.git
### with GitHub CLI
gh repo clone codejsha/infrastructure
```

### Pull main branch

```bash
git pull origin main
```

### Overwrite main branch

```bash
git stash
git fetch --all
git reset --hard origin/main
```

### Stash

```bash
git stash list
git stash show
git restore -s stash@{0} -- ${FILENAME}
```

## Directory Structure

```txt
├─── ...            # s/w
│
├───contents
│   ├───images      # image files
│   └───svg         # svg files
│
└───others
    └─── ...        # other s/w
```
