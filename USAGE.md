## How I am using the `cli-box`

1. **Just**: I am using [Just](https://github.com/casey/just), a `Makefile` alternative, to run the `cli-box` with the shortcut `j`.

   - With `Just`, I can easily manage and execute various tasks and commands.
   - This is configured in file named `justfile`

2. **Aliases**: To access the `cli-box`, I have created an alias and added it to my `.zshrc` file.

   - The alias is as follows:

   ```bash
   alias j="just -f $HOME/personal-projects/cli-box/justfile"
   ```
1. **Transcrypt**: To securely store all my dotfiles on GitHub, I am using [Transcrypt](https://github.com/elasticdog/transcrypt).

   - `Transcrypt` encrypts all the files in the `home` folder.
   - The encrypted `home` folder is then mounted as `$HOME` folder inside the `cli-box` container, as configured in the `justfile`.
   - This gives a central directory to store and persist all the configurations for various CLI tools, in both, inside the container and locally.
2. **Mounting local directories**: I am also mounting my local `$HOME` directory under `/mnt` in the `cli-box` container.

   - This allows me to work with all the local files inside the container.
   - This configuration is also set in the `justfile`.
3. **Tmux**: I am using `tmux` to manage multiple terminal sessions within the container.

   - The `tmux` config is stored in the `build` directory, which is copied to the container during the build process.
   - This config is referred to when invoking the `tmux` command from the `justfile`.
