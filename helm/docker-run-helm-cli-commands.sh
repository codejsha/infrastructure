######################################################################

docker container run --rm -it -v $(pwd):/apps -v ~/.kube:/root/.kube -v ~/.helm:/root/.helm alpine/helm version
docker container run --rm -it -v $(pwd):/apps -v ~/.kube:/root/.kube -v ~/.helm:/root/.helm alpine/helm --help

######################################################################

function helm() { echo "+ helm ${@}">&2; command helm ${@}; }
alias helm="docker container run --rm -it -v $(pwd):/apps -v ~/.kube:/root/.kube -v ~/.helm:/root/.helm alpine/helm"
