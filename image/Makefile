ARTIFACTS =          \
  _image_config.json \
  _manifest.json

GCLOUD_OPTIONS = \
  --quiet        \
  --project $$(jq -r ".google_project" ../config.json)


.PHONY: all clean

all: _manifest.json
	@:

clean:
	jq -r ".builds[].artifact_id" < _manifest.json | xargs gcloud compute images delete $(GCLOUD_OPTIONS)
	rm -f $(ARTIFACTS)

_manifest.json: _image_config.json mlbox.json assets/* scripts/*
	packer build -var-file _image_config.json mlbox.json

_image_config.json: ../config.json
	jq 'with_entries(select(.key | test("ssh_.*") | not))' < $< > $@
