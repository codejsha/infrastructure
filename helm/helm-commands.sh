######################################################################

### repo

### add
helm repo add stable https://charts.helm.sh/stable
helm repo add incubator https://charts.helm.sh/incubator

### list
helm repo list

### update
helm repo update

### search
helm search repo ingress-nginx/ingress-nginx
helm search repo --versions ingress-nginx/ingress-nginx

######################################################################

### chart

### show
helm show chart
helm show readme
helm show values

### install / upgrade
helm install my-ingress
helm upgrade my-ingress
helm upgrade --install my-ingress

### uninstall
helm uninstall my-ingress

### pull
helm pull --untar --untardir charts ingress-nginx/ingress-nginx

### dependency
helm dependency update

######################################################################

### plugin

### install push plugin
helm plugin install https://github.com/chartmuseum/helm-push.git

### list
helm plugin list

### push
helm push --insecure my-chart https://core.harbor.example.com/library

######################################################################

### status
helm status
