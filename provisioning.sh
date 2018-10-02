set -eux


CURRENT=$(cd $(dirname $0) && pwd)
cd $CURRENT

curl -L https://www.opscode.com/chef/install.sh | bash

set +e
service systemctl stop jira
while `ps aux |grep java |grep jira |grep -v grep >/dev/null`; do
        sleep 1
done
set -e

chef-client -z -c ${CURRENT}/solo.rb -j ${CURRENT}/nodes/${1}.json -N ${1}

DATE=$(date "+%Y%m%d-%H%M%S")

mkdir -p /var/local/backup/chef/${DATE}

rsync -a ${CURRENT}/local-mode-cache/backup/ /var/local/backup/chef/${DATE}/
