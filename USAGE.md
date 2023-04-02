## How I am using the `cli-box`

- **Just**: I am using [Just](https://github.com/casey/just), a `Makefile` alternative, to run the `cli-box` with the shortcut `j`.

   - With `Just`, I can easily manage and execute various tasks and commands.
   - This is configured in file named `justfile`

- **Aliases**: To access the `cli-box`, I have created an alias and added it to my `.zshrc` file.

   - The alias is as follows:

   ```bash
   alias j="just -f $HOME/personal-projects/cli-box/justfile"
   ```
- **Transcrypt**: To securely store all my dotfiles on GitHub, I am using [Transcrypt](https://github.com/elasticdog/transcrypt).

   - `Transcrypt` encrypts all the files in the `home` directory when pushing updates to **GitHub**.
   - `home` directory remains in plain-text format locally, and mounted as `$HOME` directory inside the `cli-box` container, as configured in the `justfile`.
   - This gives a central directory to store and persist all the configurations for various CLI tools, in both, inside the container and locally.
-  **Mounting local directories**: I am also mounting my local `$HOME` directory under `/mnt` in the `cli-box` container.

   - This allows me to work with all the local files inside the container.
   - This configuration is also set in the `justfile`.
- **Tmux**: I am using `tmux` to manage multiple terminal sessions within the container.

   - The `tmux` config is stored in the `build` directory, which is copied to the container during the build process.
   - This config is referred to when invoking the `tmux` command from the `justfile`.

## Check for New Versions of Applications

`check_updates.sh` script checks for new versions of applications listed in a YAML configuration file, specifically looking for updates on GitHub. It then prints out a list of any applications that have a new version available.

- Run the `check_updates.sh` script:

   ```
   ./check_updates.sh
   ```

- The script will then output a list of any applications with a new version available.

- If there are any non-GitHub URLs listed in the YAML file, the script will also print a list of them at the end.
