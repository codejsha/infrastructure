# iPlanet - WebLogic

## Configuration

### 1. `magnus.conf`

```conf
Init fn="load-modules" shlib="${PLUGIN_HOME}/lib/mod_wl.so"
```

### 2. LD_LIBRARY_PATH

```bash
export LD_LIBRARY_PATH="${PLUGIN_HOME}/lib:${LD_LIBRARY_PATH}"
```

### 3. virtual-server-obj.conf

```bash
<Object name="weblogic" ppath="/test">
Service fn="wl-proxy" WebLogicCluster <wls-host>:<wls-port>
DebugConfigInfo="ON"
</Object>
```

### 4. startserv

```bash
${IPLANET_SERVER}/bin/startserv
```
