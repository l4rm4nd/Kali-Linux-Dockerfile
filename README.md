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
- For WireGuard to work, you have to run as `--privileged`.

### Usage

#### Custom Image Building

```sh
# clone this repo
git clone https://github.com/l4rm4nd/Kali-Linux-Dockerfile && cd Kali-Linux-Dockerfile

# build the image
docker build -t my-kali .

# run the container and spawn tty shell
docker run --rm --cap-add=NET_ADMIN --cap-add=NET_RAW --tty --interactive my-kali
```

#### External DockerHub Image

Alternatively, you can use my pre-built image `l4rm4nd/kali` from DockerHub.

Either via Docker Run:

```sh
docker run --rm --cap-add=NET_ADMIN --cap-add=NET_RAW --tty --interactive l4rm4nd/kali:latest
```

or using the provided Docker Compose file:

```sh
# spawn the stack
docker compose up -d

# exec into container
docker exec -it kali zsh
```

#### Enabling OpenSSH

You can enable OpenSSH via the following means:

```sh
# run container and map openssh port
docker run --rm -p 2222:22 -v ./kali-volume-data:/root --cap-add=NET_ADMIN --cap-add=NET_RAW --tty --interactive l4rm4nd/kali:latest

# within container: change the root password; default is `!Kali-Linux-on-Docker!`
passwd

# optional: add your ssh pubkey to /root/.ssh/authorized_keys if you plan on accessing ssh from public class IP ranges and not local lan

# within container: start the openssh service; root login is already allowed in /etc/ssh/sshd_config
service ssh restart

# connect from other machines
# pw auth allowed from private class ranges; otherwise pubkey auth!
ssh root@<YOUR-IP> -p 2222
```

##### More info

Check out [Kali Linux Official Docker Images](https://www.kali.org/docs/containers/official-kalilinux-docker-images/) for more detailed info.
