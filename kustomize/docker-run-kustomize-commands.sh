######################################################################

alias kustomize="docker container run k8s.gcr.io/kustomize/kustomize:v3.8.7"
function kustomize() { echo "+ kustomize ${@}">&2; command kustomize ${@}; }

######################################################################

docker container run k8s.gcr.io/kustomize/kustomize:v3.8.7 version
