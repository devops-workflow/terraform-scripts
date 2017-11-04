#!/bin/bash
file_readme='README.md'
for D in $(ls -1d tf_* apps_*); do
  pushd $D
  ../terraform get
  ../terraform graph | tee graph.dot | dot -Tpng > graph.png
  go run ../terraform-docs/main.go md . > ${file_readme}
  echo -e "\n### Resource Graph\n" >> ${file_readme}
  echo "![Terraform Graph](graph.png)" >> ${file_readme}
  popd
done
