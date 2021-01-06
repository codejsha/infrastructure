# Logging

## logrotate

- https://www.redhat.com/sysadmin/setting-logrotate
- https://access.redhat.com/solutions/1294

`/etc/logrotate.d/weblogic_base_domain.conf`:

```conf
daily
rotate 4
create
dateext
notifempty
missingok

/usr/local/weblogic/user_projects/domains/base_domain/logs/*.out {
}

/usr/local/weblogic/user_projects/domains/base_domain/logs/*.log {
}
```

## Rotating log file in Windows service

- https://docs.oracle.com/middleware/12213/wls/START/winservice.htm
- https://docs.oracle.com/en/middleware/standalone/weblogic-server/14.1.1.0/start/winservice.html

### Edit argument

At the end of the wlsvc command, append the following command option:

```cmd
-log:%LOG_PATH%
```

### Edit stdout log file

by time:

```log
# ROTATION_TYPE = TIME
# TIME_START_DATE = MONTH DAY YEAR HOUR:MINUTES:SECONDS
# TIME_INTERVAL_MINS = NUMBER_OF_MINUTES
```

by size:

```log
# ROTATION_TYPE = SIZE
# SIZE_KB = FILE_SIZE_IN_KILOBYTES
# SIZE_TRIGGER_INTERVAL_MINS = NUMBER_OF_MINUTES
```
