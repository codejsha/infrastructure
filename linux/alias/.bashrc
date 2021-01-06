# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# shell
function ssh() { echo "+ ssh ${@}">&2; command ssh ${@}; }
function sudo() { echo "+ sudo ${@}">&2; command sudo ${@}; }
function xargs() { echo "+ xargs ${@}">&2; command xargs ${@}; }
alias ll='ls -l -h --color=auto'
alias sshctrl1="ssh root@controlplane1"
alias sshctrl2="ssh root@controlplane2"
alias sshctrl3="ssh root@controlplane3"
alias sshnode1="ssh root@node1"
alias sshnode2="ssh root@node2"
alias sshnode3="ssh root@node3"
alias sudo-shell="sudo --shell"

# location
function cdp() { DIRECTORY="${1}"; echo "+ cd -P ${@}">&2; command cd -P ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then printf "\e[38;2;216;160;223mLOCATION: $(pwd)\e[0m\n"; ls --almost-all -l; fi; }
function goapp() { DIRECTORY="/svc/app"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function goapm() { DIRECTORY="/svc/apm"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function goappsvr() { DIRECTORY="/svc/appsvr"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function gohttpd() { DIRECTORY="/etc/httpd"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function gohttpdconf() { DIRECTORY="/etc/httpd/conf"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function gohttpdconfd() { DIRECTORY="/etc/httpd/conf.d"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function gohttpdconfmd() { DIRECTORY="/etc/httpd/conf.modules.d"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function gohttpddocs() { DIRECTORY="/var/www/html"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function gohttpdlog() { DIRECTORY="/var/log/httpd"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function gohttpdmod() { DIRECTORY="/usr/lib64/httpd/modules"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function gohttpdrun() { DIRECTORY="/run/httpd"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function goinfra() { DIRECTORY="/svc/infrastructure"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all; fi; }
function goinstall() { DIRECTORY="/svc/install"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function goiplanet() { DIRECTORY="/usr/local/iplanet"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function gojava() { DIRECTORY="/usr/lib/jvm"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function gojboss() { DIRECTORY="/usr/local/jboss"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function goldconf() { DIRECTORY="/etc/ld.so.conf.d"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function golib() { DIRECTORY="/svc/lib"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function gonginx() { DIRECTORY="/etc/nginx"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function goohs() { DIRECTORY="/usr/local/ohs"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function goorcljava() { DIRECTORY="/usr/java"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function gorepos() { DIRECTORY="/svc/repos"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function gosvc() { DIRECTORY="/svc"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function goservicesys() { DIRECTORY="/etc/systemd/system"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function goservicepkg() { DIRECTORY="/usr/lib/systemd/system"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function gotomcat() { DIRECTORY="/usr/local/tomcat"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function goweblogic() { DIRECTORY="/usr/local/weblogic"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function gowebsvr() { DIRECTORY="/svc/websvr"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function gowildfly() { DIRECTORY="/usr/local/wildfly"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function readlinkpwd() { echo "+ readlink --canonicalize .">&2; command readlink --canonicalize .; }

[ -f ~/.aliases/argo_aliases ] && source ~/.aliases/argo_aliases
[ -f ~/.aliases/cloud_aliases ] && source ~/.aliases/cloud_aliases
[ -f ~/.aliases/docker_aliases ] && source ~/.aliases/docker_aliases
[ -f ~/.aliases/docker_compose_aliases ] && source ~/.aliases/docker_compose_aliases
[ -f ~/.aliases/git_aliases ] && source ~/.aliases/git_aliases
[ -f ~/.aliases/helm_aliases ] && source ~/.aliases/helm_aliases
[ -f ~/.aliases/istio_aliases ] && source ~/.aliases/istio_aliases
[ -f ~/.aliases/jdk_aliases ] && source ~/.aliases/jdk_aliases
[ -f ~/.aliases/krew_aliases ] && source ~/.aliases/krew_aliases
[ -f ~/.aliases/kustomize_aliases ] && source ~/.aliases/kustomize_aliases
[ -f ~/.aliases/kubernetes_aliases ] && source ~/.aliases/kubernetes_aliases
[ -f ~/.aliases/minio_aliases ] && source ~/.aliases/minio_aliases
[ -f ~/.aliases/network_aliases ] && source ~/.aliases/network_aliases
[ -f ~/.aliases/package_aliases ] && source ~/.aliases/package_aliases
[ -f ~/.aliases/process_aliases ] && source ~/.aliases/process_aliases
[ -f ~/.aliases/strimzi_aliases ] && source ~/.aliases/strimzi_aliases
[ -f ~/.aliases/systemctl_aliases ] && source ~/.aliases/systemctl_aliases
[ -f ~/.aliases/tekton_aliases ] && source ~/.aliases/tekton_aliases

# others
function descheduler() { echo "+ descheduler ${@}">&2; command descheduler ${@}; }
function tidy() { echo "+ tidy ${@}">&2; command tidy ${@}; }
alias descheduler="docker container run --rm -it k8s.gcr.io/descheduler/descheduler:v0.19.0 descheduler"
alias rook-ceph-password="kubectl get secrets rook-ceph-dashboard-password -n rook-ceph -o jsonpath=\"{['data']['password']}\" | base64 --decode && echo"
alias tidy-indent="tidy -modify --indent auto --indent-spaces 4 --indent-attributes true --input-xml true --output-xml true --quote-nbsp false --quiet true --hide-comments true --wrap 80"
alias tidy-nowrap="tidy -modify --indent auto --indent-spaces 4 --indent-attributes false --input-xml true --output-xml true --quote-nbsp false --quiet true --hide-comments true --wrap 0"

# neovim
alias vi="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"

# color
LS_COLORS="${LS_COLORS}:di=\e[38;2;86;156;214"        # directory
LS_COLORS="${LS_COLORS}:ex=\e[38;2;87;166;74"         # executable file
LS_COLORS="${LS_COLORS}:ln=\e[38;2;78;201;176"        # symbolic link
LS_COLORS="${LS_COLORS}:or=\e[38;2;255;0;0"           # orphan symbolic link
LS_COLORS="${LS_COLORS}:so=\e[38;2;216;160;223"       # socket
LS_COLORS="${LS_COLORS}:*.gz=\e[38;2;214;157;133"
LS_COLORS="${LS_COLORS}:*.jar=\e[38;2;214;157;133"
LS_COLORS="${LS_COLORS}:*.tar=\e[38;2;214;157;133"
LS_COLORS="${LS_COLORS}:*.tgz=\e[38;2;214;157;133"
LS_COLORS="${LS_COLORS}:*.war=\e[38;2;214;157;133"
LS_COLORS="${LS_COLORS}:*.zip=\e[38;2;214;157;133"
export LS_COLORS

# path
PATH="${PATH}:/usr/local/go/bin"
PATH="${PATH}:${JAVA_HOME}/bin"
PATH="${PATH}:${KREW_ROOT:-"${HOME}/.krew"}/bin"
PATH="${PATH}:${HOME}/.istioctl/bin"
PATH="${PATH}:/usr/local/maven/bin"
export PATH
