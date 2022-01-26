#!/bin/bash

DCFILE="compose-test.yml"
COMPOSE_PROJECT_NAME="$(basename ${0})"

export TESTVAR="Just a random TESTVAR value"

# Cleaning up just in case
docker-compose -f ${DCFILE} -p ${COMPOSE_PROJECT_NAME} kill
docker rm $(docker ps -aq) 2>&1 >/dev/null

# Now running the environment using local images
docker-compose -f ${DCFILE} build
docker-compose -f ${DCFILE} -p ${COMPOSE_PROJECT_NAME} up
echo -e "---\nInformation from docker:"
docker ps -a | egrep "(server|client)box" \
| sed 's/^\([0-9a-z]\+\).\+_\([a-z]\+\)_[0-9]*$/\2 ID=\1/g'

exit 0
---cut---
Task:

Launch of attached shell script file should produce following lines in output (at the end of it):

serverbox_1  | Just a random TESTVAR value
serverbox_1  | /etc/issue is "Ubuntu 20.04.3 LTS \n \l"
serverbox_1  | Server hostname is 27621077674e
serverbox_1  | Client hostname is 02f27c6d6809
runtestsh_clientbox_1 exited with code 0
runtestsh_serverbox_1 exited with code 0
---
Information from docker:
clientbox ID=02f27c6d6809
serverbox ID=27621077674e

end exit.

Restrictions:
* run-test.sh CANNOT be modified at all.
* Container(s) should use ubuntu:20.04 image as base.

Requirements:
* Container services names should be exactly 'clientbox' and 'serverbox'.
* Text "Just a random TESTVAR value" in example above comes directly from TESTVAR value defined in run-test.sh, so in case it has been changed in run-test.sh - output on the next launch should reflect this change.
* Text "Ubuntu 20.04.3 LTS \n \l" in example above comes from actual file /etc/issue in the 'serverbox' service container.
* Instead of 02f27c6d6809 and 27621077674e actual docker container hostnames (container IDs) for 'clientbox' and 'serverbox' should appear respectively.
* Containers exit codes do matter and should be 0

This would require a local docker installation.

As the answer please create a tgz archive that includes full output log from run-test.sh run, run-test.sh itself and all extra files you created to make this possible.
---cut---
