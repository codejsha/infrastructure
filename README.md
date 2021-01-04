# Infrastructure as Code

## Getting Started

### Clone repository

```bash
git clone https://github.com/codejsha/infrastructure.git
### with GitHub CLI
gh repo clone codejsha/infrastructure
```

### Pull master branch

```bash
git pull origin master
```

### Overwrite master branch

```bash
git stash
git fetch --all
git reset --hard origin/master
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
