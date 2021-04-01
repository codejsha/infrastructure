######################################################################

choco install --confirm $package

choco uninstall --confirm

choco list --local-only

choco upgrade --confirm all
