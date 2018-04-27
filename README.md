# deewinner
judge which is the winner with two hands

### RUBY ENV

```bash
git pull git@github.com:wsm1992/deewinner.git
bundle install
ruby process.rb A "3c 4d 4h 5c 5d qh qd ks kc ah 2h" "6c 2c 2d" " "
ruby process.rb B "4d 4h 5c 5d qh qd ks kc ah 2h" "6c 2c 2d" " 3c"
```

### USING DOCKER

https://hub.docker.com/r/siuming/deewinner/
```bash
docker pull siuming/deewinner
docker run -it siuming/deewinner:latest

ruby process.rb A "3c 4d 4h 5c 5d qh qd ks kc ah 2h" "6c 2c 2d" " "
ruby process.rb B "4d 4h 5c 5d qh qd ks kc ah 2h" "6c 2c 2d" " 3c"
```
