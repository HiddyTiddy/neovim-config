FROM archlinux

RUN pacman -Syu neovim git gcc --noconfirm --needed
RUN mkdir -p /root/.config/nvim/lua

COPY lua /root/.config/nvim/lua
COPY init.lua /root/.config/nvim

CMD ["bash"]
