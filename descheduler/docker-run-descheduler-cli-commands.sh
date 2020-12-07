######################################################################

docker run --rm -it k8s.gcr.io/descheduler/descheduler:v0.19.0 descheduler version
docker run --rm -it k8s.gcr.io/descheduler/descheduler:v0.19.0 descheduler --help

######################################################################

function descheduler() { echo "+ descheduler ${@}">&2; command descheduler ${@}; }
alias descheduler="docker run --rm -it k8s.gcr.io/descheduler/descheduler:v0.19.0 descheduler"
