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
function cdp() { DIRECTORY="${1}"; echo "+ cd -P ${@}">&2; command cd -P ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then printf "\x1b[38;2;216;160;223mLOCATION: $(pwd)\x1b[0m\n"; ls --almost-all -l; fi; }
function goapp() { DIRECTORY="/svc/app"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
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
function golib() { DIRECTORY="/svc/lib"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function gonginx() { DIRECTORY="/etc/nginx"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function goohs() { DIRECTORY="/usr/local/ohs"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function goorcljava() { DIRECTORY="/usr/java"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function gorepos() { DIRECTORY="/svc/repos"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function gotomcat() { DIRECTORY="/usr/local/tomcat"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function goweblogic() { DIRECTORY="/usr/local/weblogic"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function gowebsvr() { DIRECTORY="/svc/websvr"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function gowildfly() { DIRECTORY="/usr/local/wildfly"; echo "+ cd ${DIRECTORY}">&2; command cd ${DIRECTORY}; STATUS="${?}"; if [ "${STATUS}" -eq "0" ]; then ls --almost-all -l; fi; }
function readlinkpwd() { echo "+ readlink --canonicalize .">&2; command readlink --canonicalize .; }

# systemctl
alias sc-daemon-reload="sudo systemctl daemon-reload"
alias sc-disable="sudo systemctl disable"
alias sc-edit="sudo systemctl edit"
alias sc-edit-docker="sudo systemctl edit docker"
alias sc-enable="sudo systemctl enable"
alias sc-isact="sudo systemctl is-active"
alias sc-isenabled="sudo systemctl is-enabled"
alias sc-restart="sudo systemctl restart"
alias sc-restart-docker="sudo systemctl restart docker"
alias sc-restart-haproxy="sudo systemctl restart haproxy"
alias sc-restart-httpd="sudo systemctl restart httpd"
alias sc-restart-net="sudo systemctl restart network"
alias sc-restart-nginx="sudo systemctl restart nginx"
alias sc-restart-nm="sudo systemctl restart NetworkManager"
alias sc-restart-vnstat="sudo systemctl restart vnstat"
alias sc-service-failed="sudo systemctl list-units --type=service --state=failed"
alias sc-service-running="sudo systemctl list-units --type=service --state=running"
alias sc-start="sudo systemctl start"
alias sc-start-docker="sudo systemctl start docker"
alias sc-start-haproxy="sudo systemctl start haproxy"
alias sc-start-httpd="sudo systemctl start httpd"
alias sc-start-net="sudo systemctl start network"
alias sc-start-nginx="sudo systemctl start nginx"
alias sc-start-nm="sudo systemctl start NetworkManager"
alias sc-start-vnstat="sudo systemctl start vnstat"
alias sc-status="sudo systemctl status"
alias sc-status-docker="sudo systemctl status docker"
alias sc-status-haproxy="sudo systemctl status haproxy"
alias sc-status-httpd="sudo systemctl status httpd"
alias sc-status-net="sudo systemctl status network"
alias sc-status-nginx="sudo systemctl status nginx"
alias sc-status-nm="sudo systemctl status NetworkManager"
alias sc-status-vnstat="sudo systemctl status vnstat"
alias sc-statusfull="sudo systemctl status --no-pager --full"
alias sc-statusfull-docker="sudo systemctl status --no-pager --full docker"
alias sc-stop="sudo systemctl stop"
alias sc-stop-docker="sudo systemctl stop docker"
alias sc-stop-haproxy="sudo systemctl stop haproxy"
alias sc-stop-httpd="sudo systemctl stop httpd"
alias sc-stop-net="sudo systemctl stop network"
alias sc-stop-nginx="sudo systemctl stop nginx"
alias sc-stop-nm="sudo systemctl stop NetworkManager"
alias sc-stop-vnstat="sudo systemctl stop vnstat"

# package
alias dnf-install="sudo dnf install -y"
alias dnf-list-installed="sudo dnf list installed"
alias dnf-list-updates="sudo dnf list updates"
alias dnf-remove="sudo dnf remove -y"
alias dnf-search="sudo dnf search"
alias rpm-install="sudo rpm -ivh"
alias rpm-query-doc="sudo rpm -qd"
alias rpm-query-info="sudo rpm -qi"
alias rpm-query-list="sudo rpm --query --list"
alias rpm-verify-package="sudo rpm --verify --package"
alias rpm-update="sudo rpm -Uvh"
alias yum-clean-all="sudo yum clean all"
alias yum-erase="sudo yum erase -y"
alias yum-deplist="sudo yum deplist"
alias yum-history="sudo yum history"
alias yum-history-info="sudo yum history info"
alias yum-info="sudo yum info"
alias yum-install="sudo yum install -y"
alias yum-list="sudo yum list --showduplicate"
alias yum-list-installed="sudo yum list installed"
alias yum-provides="sudo yum provides"
alias yum-repolist="sudo yum repolist"
alias yum-search="sudo yum search"
alias yum-update="sudo yum update -y"

# network
alias netstat-tunlp="sudo netstat --tcp --udp --numeric --listening --programs"

# alternative
alias alternatives-config-java="sudo alternatives --config java"
alias alternatives-list="sudo alternatives --list"

# process
alias killhttpd="sudo pgrep httpd | xargs sudo kill -9"
alias killjava="sudo pgrep java | xargs sudo kill -9"
alias psef="sudo ps -ef | grep "
alias psef-httpd="sudo ps -ef | grep httpd"
alias psef-java="sudo ps -ef | grep java"
alias psef-jboss="sudo ps -ef | grep jboss"
alias psef-tomcat="sudo ps -ef | grep tomcat"
alias psef-weblogic="sudo ps -ef | grep weblogic"
alias pxhttpd="sudo pgrep --exact --list-full httpd"
alias pxjava="sudo pgrep --exact --list-full java"
alias pxjava-jboss="sudo pgrep --exact --list-full java | grep jboss"
alias pxjava-tomcat="sudo pgrep --exact --list-full java | grep tomcat"
alias pxjava-weblogic="sudo pgrep --exact --list-full java | grep weblogic"

# git
eval "$(gh completion --shell bash)"
function gh() { echo "+ gh ${@}">&2; command gh ${@}; }
function git() { echo "+ git ${@}">&2; command git ${@}; }
alias gh-auth-login="gh auth login"
alias gh-auth-logout="gh auth logout"
alias gh-auth-status="gh auth status"
alias gh-config-get="gh config get"
alias gh-config-get-git-protocol="gh config get git_protocol"
alias gh-config-set="gh config set"
alias gh-config-set-git-protocol-https="gh config set git_protocol https"
alias gh-config-set-git-protocol-ssh="gh config set git_protocol ssh"
alias gh-repo-clone="gh repo clone"
alias gh-repo-create="gh repo create"
alias gh-repo-create-private="gh repo create --private"
alias gh-repo-create-public="gh repo create --public"
alias gh-repo-view="gh repo view"
alias git-add-all="git add --all"
alias git-add-no-all="git add --no-all"
alias git-add-update="git add --update"
alias git-commit-message="git commit --message"
alias git-fetch-all="git fetch --all"
alias git-pull-origin="git pull origin"
alias git-pull-origin-master="git pull origin master"
alias git-push="git push"
alias git-push-origin="git push origin"
alias git-push-origin-master="git push origin master"
alias git-reset-hard="git reset --hard"
alias git-reset-hard-master="git reset --hard origin/master"
alias git-status="git status"

# docker
function docker() { echo "+ docker ${@}">&2; command docker ${@}; }
alias dcattach="docker container attach"
alias dclo="docker container logs -f"
alias dcls="docker container ls"
alias dclsall="docker container ls --all"
alias dcstart="docker container start"
alias dcstop="docker container stop"
alias dcrm="docker container rm"
alias dcrmall="docker container rm \$(docker container ls --all --quiet)"
alias dcrmall-force="docker container rm --force \$(docker container ls --all --quiet)"
alias dcrm-force="docker container rm --force"
alias dcrmunused="docker container prune --force"
alias dcrun="docker container run"
function dexecbash() { CONTAINER_NAME="${1}"; if [ -n "${CONTAINER_NAME}" ]; then docker exec --interactive --tty ${1} bash; fi; }
function dexecsh() { CONTAINER_NAME="${1}"; if [ -n "${CONTAINER_NAME}" ]; then docker exec --interactive --tty ${1} sh; fi; }
function dhubimtags() { curl --silent "https://registry.hub.docker.com/v2/repositories/library/${1}/tags/" | jq '."results"[]["name"]' | tr -d '"'; }
alias dimls="docker image ls"
alias dimrm="docker image rm"
alias dimrmall="docker image rm \$(docker image ls --all --quiet)"
alias dimrmall-force="docker image rm --force \$(docker image ls --all --quiet)"
alias dimrmdangling="docker image rm \$(docker image ls --all --quiet --filter dangling=true)"
alias dimrmunused="docker image prune --force"
alias dinspect="docker inspect"
alias dnetcreate="docker network create"
alias dnetls="docker network ls"
alias dnetrm="docker network rm"
alias dnetrmunused="docker network prune --force"
alias dpull="docker pull"
alias dsearch="docker search"
alias dsearchofficial="docker search --filter=is-official=true"
alias dvolcreate="docker volume create"
alias dvolls="docker volume ls"
alias dvolrm="docker volume rm"
alias dvolrmunused="docker volume prune --force"

# docker compose
function docker-compose() { echo "+ docker-compose ${@}">&2; command docker-compose ${@}; }
alias dcp="docker-compose"
alias dcpbuild="docker-compose build"
alias dcpconfig="docker-compose config"
alias dcpdown="docker-compose down"
alias dcpexecbash="docker-compose down"
alias dcpexecsh="docker-compose down"
alias dcpkill="docker-compose kill"
alias dcplo="docker-compose logs --follow"
function dcplotail() { LINES="${1}"; docker-compose logs --follow --tail="${LINES}"; }
alias dcpps="docker-compose ps"
alias dcpup="docker-compose up"
alias dcprm="docker-compose rm"
alias dcprestart="docker-compose restart"
alias dcpstart="docker-compose start"
alias dcpstop="docker-compose stop"
alias dcptop="docker-compose top"

# kubernetes
source <(kubectl completion bash)
function kubectl() { echo "+ kubectl ${@}">&2; command kubectl ${@}; }
[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases
alias dashboard-password="kubectl -n kube-system describe secrets kubernetes-dashboard-token | grep token: | awk '{print \$2}'"
alias kaeof="cat <<EOF | kubectl apply --filename -"
alias kc="kubectl create --recursive --filename"
alias kdep="kubectl describe endpoints"
alias kdeps="kubectl describe endpointslices"
alias kgep="kubectl get endpoints"
alias kgeps="kubectl get endpointslices"
alias kgpv="kubectl get persistentvolumes"
alias kgpvc="kubectl get persistentvolumeclaims"
alias kgpvcall="kubectl get persistentvolumeclaims --all-namespaces"
alias krmjob-force="kubectl delete jobs --grace-period=0 --force"
alias krmjoball="kubectl delete jobs --all"
alias krmjoball-force="kubectl delete jobs --all --grace-period=0 --force"
alias krmpo-force="kubectl delete pods --grace-period=0 --force"
alias krmpoall-force="kubectl delete pods --all --grace-period=0 --force"

# krew
function kubectl-ctx() { echo "+ kubectl-ctx ${@}">&2; command kubectl-ctx ${@}; }
function kubectl-kns() { echo "+ kubectl-ns ${@}">&2; command kubectl-ns ${@}; }
function kubectl-krew() { echo "+ kubectl-krew ${@}">&2; command kubectl-krew ${@}; }
function kubectl-tail() { echo "+ kubectl-tail ${@}">&2; command kubectl-tail ${@}; }
function kubectl-tree() { echo "+ kubectl-tree ${@}">&2; command kubectl-tree ${@}; }
alias kctx="kubectl-ctx"
alias kns="kubectl-ns"
alias kns-argo="kubectl-ns argo"
alias kns-argo-events="kubectl-ns argo-events"
alias kns-argo-rollouts="kubectl-ns argo-rollouts"
alias kns-argocd="kubectl-ns argocd"
alias kns-artifactory="kubectl-ns artifactory-system"
alias kns-backstage="kubectl-ns backstage-system"
alias kns-bookinfo="kubectl-ns bookinfo"
alias kns-default="kubectl-ns default"
alias kns-drone="kubectl-ns drone-system"
alias kns-cassandra="kubectl-ns cassandra-system"
alias kns-chart="kubectl-ns chart-system"
alias kns-elastic="kubectl-ns elastic-system"
alias kns-gitlab="kubectl-ns gitlab-system"
alias kns-harbor="kubectl-ns harbor-system"
alias kns-influx="kubectl-ns influx-system"
alias kns-ingress="kubectl-ns ingress-nginx"
alias kns-istio-operator="kubectl-ns istio-operator"
alias kns-istio="kubectl-ns istio-system"
alias kns-jenkins="kubectl-ns jenkins-system"
alias kns-kafka="kubectl-ns kafka-system"
alias kns-kube-node-lease="kubectl-ns kube-node-lease"
alias kns-kube-public="kubectl-ns kube-public"
alias kns-kube-system="kubectl-ns kube-system"
alias kns-kraken="kubectl-ns kraken-system"
alias kns-metallb="kubectl-ns metallb-system"
alias kns-mongo="kubectl-ns mongo-system"
alias kns-mssql="kubectl-ns mssql-system"
alias kns-myproject="kubectl-ns myproject"
alias kns-minio="kubectl-ns minio-system"
alias kns-nexus="kubectl-ns nexus-system"
alias kns-postgres="kubectl-ns postgres-system"
alias kns-redis="kubectl-ns redis-system"
alias kns-registry="kubectl-ns registry-system"
alias kns-rook-ceph="kubectl-ns rook-ceph"
alias kns-tomcat="kubectl-ns tomcat-system"
alias kns-tekton="kubectl-ns tekton-pipelines"
alias kns-vault="kubectl-ns vault-system"
alias krew="kubectl-krew"
alias ktail="kubectl-tail"
alias ktree="kubectl-tree"
alias ktreedep="kubectl-tree deployments"
alias ktreers="kubectl-tree replicasets"

# helm
function helm() { echo "+ helm ${@}">&2; command helm ${@}; }
alias helm-install="helm install"
alias helm-list="helm list"
alias helm-plugin-list="helm plugin list"
alias helm-pull="helm pull"
alias helm-push="helm push"
alias helm-push-chartmuseum="helm push ${1} chartmuseum"
alias helm-repo-add="helm repo add"
alias helm-repo-list="helm repo list"
alias helm-repo-update="helm repo update"
alias helm-search-repo="helm search repo"
alias helm-search-repo-all="helm search repo --versions"
alias helm-search-repo-chartmuseum="helm search repo chartmuseum/"
alias helm-status="helm status"
alias helm-uninstall="helm uninstall"
alias helm-upgrade="helm upgrade"
alias helm-upgrade-install="helm upgrade --install"

# tekton
source <(tkn completion bash)
function tkn() { echo "+ tkn ${@}">&2; command tkn ${@}; }
alias kgctb="kubectl get clustertriggerbindings"
alias kgel="kubectl get eventlisteners"
alias kgtb="kubectl get triggerbindings"
alias kgtri="kubectl get triggers"
alias kgtt="kubectl get triggertemplates"
alias tkncondlist="tkn conditions list"
alias tknctlist="tkn clustertasks list"
alias tknctblist="tkn clustertriggerbinding list"
alias tknellist="tkn eventlisteners list"
alias tknpdel="tkn pipelines delete"
alias tknpdelall="tkn pipelines delete --all"
alias tknpdelall-force="tkn pipelines delete --all --force"
alias tknplist="tkn pipelines list"
alias tknprdel="tkn pipelineruns delete"
alias tknprdelall="tkn pipelineruns delete --all"
alias tknprdelall-force="tkn pipelineruns delete --all --force"
alias tknprdesc="tkn pipelineruns desc"
alias tknprdesclast="tkn pipelineruns desc --last"
alias tknprlist="tkn pipelineruns list --reverse"
alias tknprlo="tkn pipelineruns logs --follow"
alias tknprlolast="tkn pipelineruns logs --follow --last"
alias tknreslist="tkn resresources list"
alias tkntlist="tkn tasks list"
alias tkntdel="tkn tasks delete"
alias tkntdelall="tkn tasks delete --all"
alias tkntdelall-force="tkn tasks delete --all --force"
alias tkntblist="tkn triggerbinding list"
alias tkntrdel="tkn taskruns delete"
alias tkntrdelall="tkn taskruns delete --all"
alias tkntrdelall-force="tkn taskruns delete --all --force"
alias tkntrdesc="tkn taskruns desc"
alias tkntrdesclast="tkn taskruns desc --last"
alias tkntrlist="tkn taskruns list --reverse"
alias tkntrlo="tkn taskruns logs --follow"
alias tkntrlolast="tkn taskruns logs --follow --last"
alias tknttlist="tkn triggertemplate list"
alias tknver="tkn version"

# minio
function mc() { echo "+ mc ${@}">&2; command mc ${@}; }
alias mccat="mc cat"
alias mccp="mc cp"
alias mccpa="mc cp --preserve"
alias mccpnewer="mc cp --newer-than"
alias mccporder="mc cp --older-than"
alias mccpr="mc cp --recursive"
alias mcdu="mc du"
alias mcfind="mc find"
alias mcls="mc ls"
alias mcmb="mc mb"
alias mcmv="mc mv"
alias mcmva="mc mv --preserve"
alias mcmvnewer="mc mv --newer-than"
alias mcmvorder="mc mv --older-than"
alias mcmvr="mc mv --recursive"
alias mcrb="mc rb"
alias mcrb=-force="mc rb --force"
alias mcrm="mc rm"
alias mcrmnewer="mc rm --newer-than"
alias mcrmorder="mc rm --older-than"
alias mcrmr="mc rm --recursive"
alias mcrmr=-force="mc rm --recursive --force"
alias mctree="mc tree"
alias mctreed="mc tree --depth"
alias mctreef="mc tree --files"
complete -C /usr/local/bin/mc mc

# istio
function istioctl() { echo "+ istioctl ${@}">&2; command istioctl ${@}; }
alias istioctl-proxy-status="istioctl proxy-status"
alias kddr="kubectl describe destinationrules"
alias kdgw="kubectl describe gateways"
alias kdse="kubectl describe serviceentries"
alias kdvs="kubectl describe virtualservices"
alias kgdr="kubectl get destinationrules"
alias kggw="kubectl get gateways"
alias kgnslc-istio="kubectl get namespace -L istio-injection"
alias kgse="kubectl get serviceentries"
alias kgtm="kubectl get gw,vs,dr,se"
alias kgvs="kubectl get virtualservices"
alias kgwe="kubectl get workloadentries"
function klbns-istio() { NAMESPACE="${1}"; kubectl label namespace ${1} istio-injection=enabled; }
alias krmtm="kubectl delete gw,vs,dr,se --all"

# argo
source <(argo completion bash)
source <(argocd completion bash)
function argo() { echo "+ argo ${@}">&2; command argo ${@}; }
function argocd() { echo "+ argocd ${@}">&2; command argocd ${@}; }
alias ag="argo"
alias agcd="argocd"
alias agcd-account-update-password="argocd account update-password"
alias agcd-app="argocd app"
alias agcd-app-create="argocd app create"
alias agcd-app-delete="argocd app delete"
alias agcd-app-diff="argocd app diff"
alias agcd-app-get="argocd app get"
alias agcd-app-history="argocd app history"
alias agcd-app-list="argocd app list"
alias agcd-app-manifests="argocd app manifests"
alias agcd-app-resources="argocd app resources"
alias agcd-app-set="argocd app set"
alias agcd-app-unset="argocd app unset"
alias agcd-app-sync="argocd app sync"
alias agcd-login="argocd login argocd.example.com"
alias agcd-logout="argocd logout argocd.example.com"
alias agcd-password="kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2"
alias agcd-proj-create="argocd proj create"
alias agcd-proj-delete="argocd proj delete"
alias agcd-proj-get="argocd proj get"
alias agcd-proj-list="argocd proj list"
alias agcd-proj-role="argocd proj role"
alias agcd-proj-role-create="argocd proj role create"
alias agcd-proj-role-delete="argocd proj role delete"
alias agcd-proj-role-get="argocd proj role get"
alias agcd-proj-role-list="argocd proj role list"
alias agcd-proj-set="argocd proj set"
alias kgapp="kubectl get app"
alias kgappproj="kubectl get appprojects"
alias kgar="kubectl get analysisruns"
alias kgat="kubectl get analysistemplates"
alias kgcat="kubectl get clusteranalysistemplates"
alias kgcwf="kubectl get cronworkflows"
alias kgcwft="kubectl get clusterworkflowtemplates"
alias kgeb="kubectl get eventbus"
alias kges="kubectl get eventsources"
alias kgro="kubectl get rollouts"
alias kgsn="kubectl get sensors"
alias kgwf="kubectl get workflows"
alias kgwfeb="kubectl get workfloweventbindings"
alias kgwftmpl="kubectl get workflowtemplates"

# jdk
function jar() { echo "+ jar ${@}">&2; command jar ${@}; }
function java() { echo "+ java ${@}">&2; command java ${@}; }
function jstack() { echo "+ jstack ${@}">&2; command jstack ${@}; }
# export JAVA_HOME="/usr/java/current"
# export JAVA_HOME="/usr/lib/jvm/java-1.8.0"
export JAVA_HOME="/usr/lib/jvm/java-11"
# alias change-openjdk8="export JAVA_HOME=\"/usr/lib/jvm/java-1.8.0\"; export PATH=\"\${PATH}:\${JAVA_HOME}/bin\""
# alias change-openjdk11="export JAVA_HOME=\"/usr/lib/jvm/java-11\"; export PATH=\"\${PATH}:\${JAVA_HOME}/bin\""
alias change-orcljdk6="ln -snf /usr/java/java-1.6.0 /usr/java/current"
alias change-orcljdk7="ln -snf /usr/java/java-1.7.0 /usr/java/current"
alias change-orcljdk8="ln -snf /usr/java/java-1.8.0 /usr/java/current"
alias change-orcljdk11="ln -snf /usr/java/java-11 /usr/java/current"
# alias change-orcljdk6="ln -snf /usr/java/java-1.6.0 /usr/java/current; export PATH=\"\${PATH}:\${JAVA_HOME}/bin\""
# alias change-orcljdk7="ln -snf /usr/java/java-1.7.0 /usr/java/current; export PATH=\"\${PATH}:\${JAVA_HOME}/bin\""
# alias change-orcljdk8="ln -snf /usr/java/java-1.8.0 /usr/java/current; export PATH=\"\${PATH}:\${JAVA_HOME}/bin\""
# alias change-orcljdk11="ln -snf /usr/java/java-11 /usr/java/current; export PATH=\"\${PATH}:\${JAVA_HOME}/bin\""

# others
function aws() { echo "+ aws ${@}">&2; command aws ${@}; }
function kustomize() { echo "+ kustomize ${@}">&2; command kustomize ${@}; }
function tidy() { echo "+ tidy ${@}">&2; command tidy ${@}; }
alias aws="docker run --rm -it -v ~/.aws:/root/.aws -v \$(pwd):/aws amazon/aws-cli"
alias rook-ceph-password="kubectl -n rook-ceph get secrets rook-ceph-dashboard-password -o jsonpath=\"{['data']['password']}\" | base64 --decode && echo"
alias tidy-indent="tidy -modify --indent auto --indent-spaces 4 --indent-attributes true --input-xml true --output-xml true --quote-nbsp false --quiet true --hide-comments true --wrap 80"
alias tidy-nowrap="tidy -modify --indent auto --indent-spaces 4 --indent-attributes false --input-xml true --output-xml true --quote-nbsp false --quiet true --hide-comments true --wrap 0"
alias vi="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"

# color
LS_COLORS="${LS_COLORS}:di=\x1b[38;2;86;156;214"        # directory
LS_COLORS="${LS_COLORS}:ex=\x1b[38;2;87;166;74"         # executable file
LS_COLORS="${LS_COLORS}:ln=\x1b[38;2;78;201;176"        # symbolic link
LS_COLORS="${LS_COLORS}:or=\x1b[38;2;255;0;0"           # orphan symbolic link
LS_COLORS="${LS_COLORS}:so=\x1b[38;2;216;160;223"       # socket
LS_COLORS="${LS_COLORS}:*.gz=\x1b[38;2;214;157;133"
LS_COLORS="${LS_COLORS}:*.jar=\x1b[38;2;214;157;133"
LS_COLORS="${LS_COLORS}:*.tar=\x1b[38;2;214;157;133"
LS_COLORS="${LS_COLORS}:*.tgz=\x1b[38;2;214;157;133"
LS_COLORS="${LS_COLORS}:*.war=\x1b[38;2;214;157;133"
LS_COLORS="${LS_COLORS}:*.zip=\x1b[38;2;214;157;133"
export LS_COLORS

# path
PATH="${PATH}:/usr/local/go/bin"
PATH="${PATH}:${JAVA_HOME}/bin"
PATH="${PATH}:${KREW_ROOT:-$HOME/.krew}/bin"
PATH="${PATH}:${HOME}/.istioctl/bin"
PATH="${PATH}:/usr/local/maven/bin"
export PATH
