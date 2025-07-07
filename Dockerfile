FROM ubuntu:22.04 AS build

WORKDIR /app
RUN apt-get update && \
    apt-get install -y wget unzip libfontconfig && \
    wget -q https://github.com/godotengine/godot/releases/download/4.4.1-stable/Godot_v4.4.1-stable_linux.x86_64.zip && \
    wget -q https://github.com/godotengine/godot/releases/download/4.4.1-stable/Godot_v4.4.1-stable_export_templates.tpz && \
    unzip Godot_v4.4.1-stable_linux.x86_64.zip && \
    unzip Godot_v4.4.1-stable_export_templates.tpz && \
    mkdir -p /root/.local/share/godot/export_templates/4.4.1.stable/ && \ 
    mv templates/* /root/.local/share/godot/export_templates/4.4.1.stable/ && \
    mv Godot_v4.4.1-stable_linux.x86_64 /usr/bin/godot

COPY . .

RUN godot --headless --export-release Web


FROM nginx:latest

COPY --from=build /app/build/ /usr/share/nginx/html/
