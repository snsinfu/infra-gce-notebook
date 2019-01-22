GCE machine learning image
==========================

Packer template and Terraform configuration for deploying GPU-enabled private
jupyter server on Google Cloud. Notebooks are stored in a GCS bucket.

## Usage

Create storage bucket and image:

```sh
make -C storage
make -C image
```

Launch a machine, start SSH forwarding of jupyterlab, then destroy:

```sh
make -C machine
make -C machine forward
make -C machine destroy
```

## Price

With preemptible instance and regional storage:

| Component | Spec             | Cost      |
|-----------|------------------|-----------|
| Machine   | n1-highmem-4     | $0.050/hr |
| GPU       | nvidia-tesla-k80 | $0.135/hr |
| Disk      | 20GB SSD         | $0.005/hr |
| Image     | 20GB             | $1.70/mo  |
| Storage   | 100GB regional   | $2.00/mo  |

```
Monthly cost = $3.70 + $0.190 × T (hours)
```
