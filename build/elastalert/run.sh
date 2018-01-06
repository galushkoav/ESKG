#/bin/bash
elastalert-create-index
cd /etc/elastalert/;
#python -m elastalert.elastalert --config config.yaml  --verbose  --rule  example_rules/example_frequency.yaml
python -m elastalert.elastalert --verbose
/bin/bash