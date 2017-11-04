#!/bin/bash
for D in $(ls -1d tf_* apps_*); do
  pushd $D
  git commit -a -m "$1"
  git push
  popd
done
