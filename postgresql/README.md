# PostgreSQL

## Install

### Docker

```bash
bash ./docker-run-postgresql.sh
```

```powershell
### powershell
.\docker-run-postgresql.ps1
```

### Kubernetes

```bash
bash ./helm-install-postgresql.sh
```

#### Grafana dashboard

- https://grafana.com/grafana/dashboards/9628

### Local

- https://www.postgresql.org/download/linux/redhat/

```bash
bash ./install-postgresql.sh
```

## Example Commands

- `postgres-commands.sh`

## Sample Database

DVD Rental database (https://www.postgresqltutorial.com/postgresql-sample-database/)

```bash
### load the sample database
bash ./load-sample-db.sh
```

DVD Rental ER Model:

![dvd-rental-erd](/contents/images/dvd-rental-sample-database-diagram.png)
