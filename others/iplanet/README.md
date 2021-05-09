# iPlanet

## Install

```bash
bash ./install-iplanet.sh
bash ./create-links.sh admin-server
```

## Server

```bash
bash ./create-server.sh
bash ./create-links.sh ${IPLANET_SERVER}
bash ./delete-server.sh
```

## Listener

```bash
bash ./create-http-listener.sh
bash ./delete-http-listener.sh
```

## Virtual Server

```bash
bash ./create-virtual-server.sh
bash ./delete-virtual-server.sh
```

## Others

- `get-version.sh`
- `create-links.sh`
- `disable-java.sh`
- `set-self-signed-cert.sh`

## Log Rotation

- https://docs.oracle.com/cd/E19146-01/821-1828/gbrqz/index.html
