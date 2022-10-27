#!/bin/bash

cleanup() {
  docker stop $container >/dev/null
  docker rm $container >/dev/null
}

main() {

  container=dev_env_base-gui-38-gymphysics
  image=pmallozzi/devenvs:base-gui-38-gymphysics
  port=6901
  port_ssh=22

  os=$(uname)

  which docker 2>&1 >/dev/null
  if [ $? -ne 0 ]; then
    echo "Error: the 'docker' command was not found.  Please install docker."
    exit 1
  fi

  #  ip=$(docker-machine ip ${vm} 2>/dev/null || echo "localhost")
  url="http://${ip}:$port"

  running=$(docker ps -a -q --filter "name=${container}")

  cleanup

  pwd_dir="$(pwd)"
  mount_local=""
  echo ${os}
  echo ${mount_local}
  if [ "${os}" = "Linux" ] || [ "${os}" = "Darwin" ]; then
    mount_local=" -v ${pwd_dir}:/home/headless/code"
  fi
  port_arg=""
  if [ -n "$port" ]; then
    port_arg="-p $port:6901 -p $port_ssh:22"
  fi

  echo "Navigate to http://localhost:6901"
  echo "Lite VNC http://localhost:6901/vnc_lite.html"
  echo "Full VNC http://localhost:6901/vnc.html"

  echo ${mount_local}

  docker run \
    -d \
    --name $container \
    --privileged \
    --workdir /home/headless/code \
    --platform linux/amd64 \
    ${mount_local} \
    $port_arg \
    $image >/dev/null

}

main $@

trap "docker stop $container >/dev/null && print_app_output" SIGINT SIGTERM

docker wait $container >/dev/null

print_app_output() {
  docker cp $container:/var/log/supervisor/graphical-app-launcher.log - |
    tar xO
  result=$(docker cp $container:/tmp/graphical-app.return_code - |
    tar xO)
  cleanup
  exit $result
}

print_app_output
