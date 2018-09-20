FROM ubuntu:18.04

LABEL maintainer="Saurabh <saurabhio@outlook.com>"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    build-essential systemd vim nano man wget curl sudo git htop tmux tree jq net-tools openssh-server telnet apt-transport-https ncdu lsb-core unzip whois finger httpie tcpdump nmap lshw traceroute dnsutils mtr iftop inetutils-traceroute inetutils-ping iptables ufw && \
    apt-get purge && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN useradd -D -s /bin/bash && \
    useradd -m -G sudo -p $(openssl passwd -crypt ubu) ubu


RUN mkdir -p /vol0 && \
    mkdir -p /home/ubu/vol1 && \
    mkdir -p /home/ubu/vol2

VOLUME ["/vol0", "/home/ubu/vol1", "/home/ubu/vol2"]


RUN wget -O /tmp/miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
    /bin/bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh  && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> /etc/bash.bashrc 


ENV PATH="/opt/conda/bin:$PATH"

RUN conda update conda && \
    conda install -y -c conda-forge \
    pip numpy scipy pandas scikit-learn matplotlib seaborn tensorflow keras jupyter jupyterhub && \
    conda update --all && \
    conda clean -y --all

RUN echo 'export PATH="/opt/conda/bin:$PATH"' >> /etc/bash.bashrc


# Listening JupyterHub, Jupyter Notebook, Tensorboard, MySQL:3306, MongoDB:27017
EXPOSE 22 80 443 8000 8888 6006  

USER ubu

WORKDIR /home/ubu/

CMD ["/bin/bash"]
