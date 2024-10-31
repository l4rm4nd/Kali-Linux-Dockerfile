# Kali-Linux-Dockerfile

A simple dockerfile which allows you to build a _docker image_ starting from the latest official one of **Kali Linux** and including some useful tools.

## Included tools

These are the main **tools** which are included:

- Kali Linux [Top 10](https://tools.kali.org/kali-metapackages) metapackage
- exploitdb
- man-db
- dirb
- nikto
- wpscan
- uniscan
- tor
- proxychains
- wireguard
- openssh-server

Note that you can _add/modify/delete_ configuration files by doing the related changes in the dockerfile.

### Other useful things

Also [zsh](https://github.com/robbyrussell/oh-my-zsh/wiki/Installing-ZSH) is installed as default shell. You can add some changes directly in the [.zshrc](https://github.com/zMrSec/Kali-Linux-Dockerfile/blob/master/config/.zshrc) file, such as setting your favourite theme.
_Python-Pip_ and _Golang_ are included, too. Finally, WireGuard and a OpenSSH server was installed, which can be used if necessary. 

- For Nmap to work, the container must run with `--cap-add=NET_ADMIN --cap-add=NET_RAW`.
- For WireGuard to work, you likely want to run with `--privileged --sysctl net.ipv4.ip_forward=1`.

### Usage

```sh
# clone this repo
git clone https://github.com/l4rm4nd/Kali-Linux-Dockerfile && cd Kali-Linux-Dockerfile

# build the image
docker build -t my-kali .

# run the container and spawn tty shell
docker run --rm --cap-add=NET_ADMIN --cap-add=NET_RAW --tty --interactive my-kali
```

Alternatively, you can use my pre-built image `l4rm4nd/kali` from DockerHub.

```sh
docker run --rm --cap-add=NET_ADMIN --cap-add=NET_RAW --tty --interactive l4rm4nd/kali:latest
```

You can enable OpenSSH via the following means:
```sh
# change the root password; default is !Kali-Linux-on-Docker!
passwd

# start the openssh service; root login is already allowed in /etc/ssh/sshd_config
service ssh restart
```

##### More info

Check out [Kali Linux on a Docker container: the easiest way](https://tsumarios.github.io/blog/2022/09/17/kali-linux-docker-container/) for more detailed info.
