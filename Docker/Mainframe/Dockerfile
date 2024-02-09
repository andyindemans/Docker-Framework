FROM ubuntu:jammy
#FROM osrf/ros:noetic-desktop-full-focal
#FROM nvcr.io/nvidia/pytorch:20.12-py3
# The OSRF ROS Noetic containers use the root user.
# Therefore, the following commands are executed as root up until the
# USER user statement.

# We love UTF!
ENV LANG C.UTF-8

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections


# Install some handy tools.
RUN set -x \
	&& apt-get update \
	&& apt-get --with-new-pkgs upgrade -y \
	&& apt-get install -y mesa-utils lshw xcb \ 
	&& apt-get install -y iputils-ping \ 
	&& apt-get install -y apt-transport-https ca-certificates \
	&& apt-get install -y openssh-server python3-pip exuberant-ctags \
	&& apt-get install -y git vim tmux nano htop sudo curl wget gnupg2 screen lm-sensors \
	&& apt-get install -y bash-completion \
	&& apt-get install -y libcanberra-gtk3-0 \
	&& python3 -m pip install --upgrade pip \
	&& pip3 install powerline-shell  \
	&& pip3 install kafka-python scipy keras tensorflow mss \
	&& pip3 install numpy>=1.19.5 pandas matplotlib>=3.3.4 regex>=2021.4.4 \
    	&& pip3 install scipy>=1.5.4 jupyter>=1.0.0 scikit-learn>=0.24.1 split-folders>=0.4.3 \
    	&& pip3 install keras>=2.3.1 \
	&& rm -rf /var/lib/apt/lists/* \
	&& useradd -ms /bin/bash user \
	&& echo "user:user" | chpasswd && adduser user sudo \
	&& echo "user ALL=(ALL) NOPASSWD: ALL " >> /etc/sudoers

# Fixing the OSRF container not linking python3 to python
RUN ln -s /usr/bin/python3 /usr/bin/python
COPY requirements.txt .
RUN pip install -r requirements.txt gsutil

USER user
WORKDIR /home/user
RUN sudo usermod -a -G video user

RUN git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack  \
        && git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux-resurrect
COPY --chown=user:user ./.tmux.conf /home/user/.tmux.conf
COPY --chown=user:user ./.powerline.sh /home/user/.powerline.sh

RUN mkdir -p /home/user/.vim/bundle \
        && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

COPY --chown=user:user ./.vimrc /home/user/.vimrc
 
RUN set -x \
        && vim -E -u NONE -S /home/user/.vimrc -C "+PluginInstall" -C "+qall";  exit 0
#
# Set some decent colors if the container needs to be accessed via /bin/bash.
RUN echo LS_COLORS=$LS_COLORS:\'di=1\;33:ln=36\' >> ~/.bashrc \
        && echo export LS_COLORS >> ~/.bashrc \
        && echo 'source ~/.powerline.sh' >> ~/.bashrc \
        && echo 'alias tmux="tmux -2"' >> ~/.bashrc \
        && echo 'PATH=~/bin:$PATH' >> ~/.bashrc \
        && touch ~/.sudo_as_admin_successful # To surpress the sudo message at run.


STOPSIGNAL SIGTERM

CMD sudo service ssh start && /bin/bash
