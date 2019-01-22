ARTIFACTS =     \
  _init.ok      \
  _resources.ok \
  _provision.ok \
  _ssh_config   \
  _known_hosts  \
  _provision.bash

JQ_BUCKET = \
  $$(jq -r ".storage_bucket" < ../config.json)

TF_INIT_OPTIONS = \
  -backend-config bucket=$(JQ_BUCKET)

TF_OPTIONS = \
  -var-file ../config.json

FORWARD_RULE = 18888:localhost:8888


.PHONY: all clean destroy ssh ping

all: _provision.ok
	@:

clean:
	rm -rf $(ARTIFACTS)

destroy:
	terraform destroy -auto-approve $(TF_OPTIONS)

ping: _resources.ok
	ping $$(terraform output ip)

ssh: _ssh_config
	ssh -F _ssh_config mlbox

forward: _provision.ok
	AUTOSSH_GATETIME=0 autossh -M 0 -F _ssh_config -N -L $(FORWARD_RULE) mlbox

_init.ok:
	terraform init $(TF_INIT_OPTIONS)
	@touch $@

_resources.ok: _init.ok
	terraform apply -auto-approve $(TF_OPTIONS)
	@touch $@

_ssh_config: _resources.ok ssh_config.in
	terraform output ssh_config > $@

_provision.bash: provision.bash.in
	sed "s/{{bucket}}/$(JQ_BUCKET)/g" $< > $@

_provision.ok: _ssh_config _provision.bash
	ssh -T -F _ssh_config mlbox bash < _provision.bash
	@touch $@
