# Install docker

Install the `docker.io` package.
```bash
sudo apt install docker.io
```

Start the Docker service and enable it at boot.
```bash
sudo systemctl start docker
sudo systemctl enable docker
```

Add the current user to the docker group
```bash
sudo usermod -a -G docker $USER
```
The effects are only visible after the user logs out and back in again.


# Install docker-compose

Download the `docker-compose` service
```bash
sudo curl -L "https://github.com/docker/compose/releases/download/[VERSION]/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

Apply the correct permissions for `docker-compose`.
```bash
sudo chmod +x /usr/local/bin/docker-compose
```

Verify `docker-compose` version.
```bash
docker-compose --version
```




# Optional configurations:

# Enable Nvidia GPU in Docker

You need `curl` to fetch the gpgkey, etc.
```bash
sudo apt install curl
```

Get the key, add the repository, update the packages list, install the `nvidia-container-toolkit` package and restart the Docker service.
```bash
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker
```

To test your GPU in Docker execute the following command:
```bash
docker run --gpus all nvidia/cuda:11.0-base nvidia-smi
```

The output should be something like the listing below:
```bash
Wed Mar  3 13:11:09 2021
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 460.39       Driver Version: 460.39       CUDA Version: 11.2     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  GeForce GTX 108...  Off  | 00000000:65:00.0  On |                  N/A |
|  0%   24C    P2    58W / 280W |    453MiB / 11175MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
+-----------------------------------------------------------------------------+
```
