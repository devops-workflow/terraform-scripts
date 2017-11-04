aws_security_viz -a ${AWS_ACCESS_KEY_ID} -s ${AWS_SECRET_ACCESS_KEY} -f sg.dot --color=true -c opts.yaml
cat sg.dot | dot -Tpng > sg.png
