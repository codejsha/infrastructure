######################################################################

docker container run --rm -it k8s.gcr.io/descheduler/descheduler:v0.19.0 descheduler version
docker container run --rm -it k8s.gcr.io/descheduler/descheduler:v0.19.0 descheduler --help

######################################################################

function descheduler() { echo "+ descheduler ${@}">&2; command descheduler ${@}; }
alias descheduler="docker container run --rm -it k8s.gcr.io/descheduler/descheduler:v0.19.0 descheduler"
