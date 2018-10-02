set -x

export PATH=/opt/chef/embedded/bin:$PATH
export BACKEND_LOCAL="local"

CURRENT=$(cd $(dirname $0) && pwd)
cd $CURRENT

sudo -E /opt/chef/embedded/bin/bundle install
bundle exec rake spec

RET=$?

systemctl stop jira
rm -rf /mnt/atlassian/jira/data/*
rm -rf /tmp/*

exit $RET