#!/usr/bin/env bash
#Place this script in project /android/app/

cd ..

# fail if any command fails
set -e
# debug log
set -x

cd ..
git clone -b stable https://github.com/flutter/flutter.git
# shellcheck disable=SC2006
# shellcheck disable=SC2155
export PATH=`pwd`/flutter/bin:$PATH

flutter channel stable
flutter doctor

# shellcheck disable=SC2006
echo "Installed flutter to `pwd`/flutter"

flutter pub get

exit 0