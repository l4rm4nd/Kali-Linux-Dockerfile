# Kali Linux latest with useful tools by tsumarios
FROM kalilinux/kali-rolling

# Set working directory to /root
WORKDIR /root

# Update
RUN apt -y update && DEBIAN_FRONTEND=noninteractive apt -y dist-upgrade && apt -y autoremove && apt clean

# Install common and useful tools
RUN apt -y install curl wget vim git net-tools whois netcat-traditional pciutils usbutils dnsutils nano iproute2 iputils-ping

# Install useful languages
RUN apt -y install python3-pip golang

# Install Kali Linux "Top 10" metapackage and a few cybersecurity useful tools
RUN DEBIAN_FRONTEND=noninteractive apt -y install kali-tools-top10 exploitdb man-db dirb nikto wpscan uniscan lsof apktool dex2jar ltrace strace binwalk

# Install Tor and proxychains, then configure proxychains with Tor
RUN apt -y install tor proxychains
COPY config/proxychains.conf /etc/proxychains.conf

# Install wireguard and openssh
RUN apt -y install wireguard openssh-server procps

# copy ssh configuration
COPY config/sshd_config /etc/ssh/sshd_config

# change root pw for ssh logins from local lan
RUN echo '!Kali-Linux-on-Docker!' | passwd --stdin root 

# fix capabilities for nmap
RUN setcap cap_net_raw,cap_net_bind_service+eip $(which nmap)

# Install ZSH shell with custom settings and set it as default shell
RUN apt -y install zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
COPY config/.zshrc .

# Install resolvconf for wireguard
RUN apt -y install resolvconf; exit 0

ENTRYPOINT ["/bin/zsh"]
