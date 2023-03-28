home_dir := env_var('HOME')
user_id := `whoami`

dcli:
  @docker run -it -v {{justfile_directory()}}/home:/root -v {{home_dir}}:/mnt --network host decisivedevops/cli-box fish -c "tmux -f /home/root/tmux.conf"

build:
  @./cli-box.sh
  @docker system prune -f
