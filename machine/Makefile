ARTIFACTS =     \
  _init.ok      \
  _resources.ok \
  _ssh_config   \
  _known_hosts

TF_INIT_OPTIONS = \
  -backend-config bucket=$$(jq -r ".storage_bucket" < ../config.json)

TF_OPTIONS = \
  -var-file ../config.json


.PHONY: all clean destroy ssh ping

all: _resources.ok
	@:

clean:
	rm -rf $(ARTIFACTS)

destroy:
	terraform destroy -auto-approve $(TF_OPTIONS)

ssh: _ssh_config
	ssh -F _ssh_config mlbox

ping: _resources.ok
	ping $$(terraform output ip)

_init.ok:
	terraform init $(TF_INIT_OPTIONS)
	@touch $@

_resources.ok: _init.ok
	terraform apply -auto-approve $(TF_OPTIONS)
	@touch $@

_ssh_config: _resources.ok ssh_config.in
	terraform output ssh_config > $@
