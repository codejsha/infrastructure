######################################################################

docker container run --rm -it amazon/aws-cli --version
docker container run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli --version
docker container run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli --version

######################################################################

function aws() { echo "+ aws ${@}">&2; command aws ${@}; }
alias aws="docker container run --rm -it -v ~/.aws:/root/.aws -v \$(pwd):/aws amazon/aws-cli"

######################################################################

mkdir ~/.aws
docker container run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli configure
# aws configure
### AWS Access Key ID [None]:
### AWS Secret Access Key [None]:
### Default region name [None]:
### Default output format [None]:
