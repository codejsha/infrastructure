# firewall-cmd

## Status Options

```txt
Status Options
  --state              Return and print firewalld state
  --reload             Reload firewall and keep state information
```

## Permanent Options

```txt
Permanent Options
  --permanent          Set an option permanently
                       Usable for options marked with [P]
```

## Zone Options

some options:

```txt
Zone Options
  --get-default-zone   Print default zone for connections and interfaces
  --set-default-zone=<zone>
                       Set default zone
  --get-active-zones   Print currently active zones
  --get-zones          Print predefined zones [P]
  --get-services       Print predefined services [P]
  --list-all-zones     List everything added for or enabled in all zones [P]
  --new-zone=<zone>    Add a new zone [P only]
  --delete-zone=<zone> Delete an existing zone [P only]
  --info-zone=<zone>   Print information about a zone
```

exmaples:

```bash
firewall-cmd --get-default-zone
# public

firewall-cmd --get-active-zones
# public
#   interfaces: eth0

firewall-cmd --get-zones
# block dmz drop external home internal public trusted work
```

```bash
firewall-cmd --get-services
```

```bash
firewall-cmd --list-all-zones
# ...
# public (active)
#   target: default
#   icmp-block-inversion: no
#   interfaces: eth0
#   sources:
#   services: cockpit dhcpv6-client ssh
#   ports:
#   protocols:
#   masquerade: no
#   forward-ports:
#   source-ports:
#   icmp-blocks:
#   rich rules:
# ...
```

```bash
firewall-cmd --permanent --new-zone=webserver
firewall-cmd --reload

firewall-cmd --permanent --delete-zone=webserver
firewall-cmd --reload
```

```bash
firewall-cmd --info-zone=public
```

## Service Options

```txt
Service Options
  --new-service=<service>
                       Add a new service [P only]
  --delete-service=<service>
                       Delete an existing service [P only]
```

exmaples:

```bash
firewall-cmd --info-service=cockpit
# cockpit
#   ports: 9090/tcp
#   protocols:
#   source-ports:
#   modules:
#   destination:
```

## Options to Adapt and Query Zones

some options:

```txt
Options to Adapt and Query Zones
  --list-all           List everything added for or enabled in a zone [P] [Z]
  --list-services      List services added for a zone [P] [Z]
  --add-service=<service>
                       Add a service for a zone [P] [Z] [T]
  --remove-service=<service>
                       Remove a service from a zone [P] [Z]
  --add-port=<portid>[-<portid>]/<protocol>
                       Add the port for a zone [P] [Z] [T]
  --remove-port=<portid>[-<portid>]/<protocol>
                       Remove the port from a zone [P] [Z]
```

exmaples:

```bash
firewall-cmd --permanent --zone=public --add-port=7001/tcp
firewall-cmd --permanent --zone=public --add-port=7000-7999/tcp
firewall-cmd --reload

firewall-cmd --permanent --zone=public --remove-port=7001/tcp
firewall-cmd --permanent --zone=public --remove-port=7000-7999/tcp
firewall-cmd --reload
```

```bash
firewall-cmd --permanent --zone=public --add-service=cockpit.socket
firewall-cmd --reload

firewall-cmd --permanent --zone=public --remove-service=cockpit.socket
firewall-cmd --reload
```

```bash
firewall-cmd --list-all
# public (active)
#   target: default
#   icmp-block-inversion: no
#   interfaces: eth0
#   sources:
#   services: cockpit dhcpv6-client ssh
#   ports:
#   protocols:
#   masquerade: no
#   forward-ports:
#   source-ports:
#   icmp-blocks:
#   rich rules:
```

```bash
firewall-cmd --list-services
# cockpit dhcpv6-client ssh
```

## Options to Handle Bindings of Interfaces

```txt
Options to Handle Bindings of Interfaces
  --list-interfaces    List interfaces that are bound to a zone [P] [Z]
```

exmaples:

```bash
firewall-cmd --list-interfaces
# eth0
```
