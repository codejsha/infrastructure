######################################################################

choco install --confirm $package

choco uninstall --confirm $package

choco list --local-only

choco upgrade --confirm all
