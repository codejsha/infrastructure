#!/bin/bash

PluginHome="$env:SystemDrive/lib/weblogic-plugin"

strings64.exe $PluginHome\lib\iisproxy.dll | Select-String "WLSPLUGINS" -SimpleMatch
