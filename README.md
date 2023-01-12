Сборка:
```
docker build . -t bitaddress
```

Запуск:
#docker run \
#  --shm-size=384m \
#  -e DISPLAY=$DISPLAY \
#  --device /dev/snd/controlC0 \
#  --device /dev/snd/pcmC0D0p \
#  --device /dev/snd/timer \
#  -v /tmp/.X11-unix:/tmp/.X11-unix \
#  -v $XAUTHORITY:/tmp/.host_Xauthority:ro \
#  -dti --rm test_1
```
docker run \
  --shm-size=384m \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $XAUTHORITY:/tmp/.host_Xauthority:ro \
  --network=none \
  --mount type=bind,source=$(pwd)/out,destination=/mnt \
  -dti --rm bitaddress
```

