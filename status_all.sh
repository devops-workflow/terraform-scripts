#!/bin/bash
for D in $(ls -1d tf_* apps_*); do
  pushd $D
  git status
  popd
done
