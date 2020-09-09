#!/usr/bin/env bash

# This is heavily inspired by https://github.com/nvm-sh/nvm/blob/master/install.sh

latest_version() {
  echo "v0.5.4"
}

default_install_dir() {
  [ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.kloud-installer" || printf %s "${XDG_CONFIG_HOME}/kloud-installer"
}

install_dir() {
   if [ -n "$KLOUD_INSTALLER_DIR" ]; then
    printf %s "${$KLOUD_INSTALLER_DIR}"
  else
    default_install_dir
  fi
}

git_source() {
  echo "https://github.com/kloudio/kloud-installer.git"
}

install_from_git() {
  local INSTALL_DIR
  INSTALL_DIR="$(install_dir)"

  if [ -d "$INSTALL_DIR/.git" ]; then
    echo "=> kloud-installer is already installed in $INSTALL_DIR, trying to update using git"
    command printf '\r=> '
    command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" fetch origin tag "$(latest_version)" --depth=1 2> /dev/null || {
      echo >&2 "Failed to update kloud-installer, run 'git fetch' in $INSTALL_DIR yourself."
      exit 1
    }
  else
    # Cloning to $INSTALL_DIR
    echo "=> Downloading kloud-installer from git to '$INSTALL_DIR'"
    command printf '\r=> '
    mkdir -p "${INSTALL_DIR}"
    if [ "$(ls -A "${INSTALL_DIR}")" ]; then
      command git init "${INSTALL_DIR}" || {
        echo >&2 'Failed to initialize kloud-installer repo. Please report this!'
        exit 2
      }
      command git --git-dir="${INSTALL_DIR}/.git" remote add origin "$(git_source)" 2> /dev/null \
        || command git --git-dir="${INSTALL_DIR}/.git" remote set-url origin "$(git_source)" || {
        echo >&2 'Failed to add remote "origin" (or set the URL). Please report this!'
        exit 2
      }
      command git --git-dir="${INSTALL_DIR}/.git" fetch origin --tags "$(latest_version)" --depth=1 || {
        echo >&2 'Failed to fetch origin with tags. Please report this!'
        exit 2
      }
    else
      command git -c advice.detachedHead=false clone "$(git_source)" "${INSTALL_DIR}" || {
        echo >&2 'Failed to clone kloud-installer repo. Please report this!'
        exit 2
      }
      command cd ${INSTALL_DIR} && git -c advice.detachedHead=false checkout "$(latest_version)" && cd - || {
        echo >&2 'Failed to checkout tag. Please report this!'
        exit 2
      }
    fi
  fi
  command git -c advice.detachedHead=false --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" checkout -f --quiet "$(latest_version)"
  if [ -n "$(command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" show-ref refs/heads/master)" ]; then
    if command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" branch --quiet 2>/dev/null; then
      command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" branch --quiet -D master >/dev/null 2>&1
    else
      echo >&2 "Your version of git is out of date. Please update it!"
      command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" branch -D master >/dev/null 2>&1
    fi
  fi

  echo "=> Compressing and cleaning up git repository"
  if ! command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" reflog expire --expire=now --all; then
    echo >&2 "Your version of git is out of date. Please update it!"
  fi
  if ! command git --git-dir="$INSTALL_DIR"/.git --work-tree="$INSTALL_DIR" gc --auto --aggressive --prune=now ; then
    echo >&2 "Your version of git is out of date. Please update it!"
  fi

  echo "=> Moving binaries, might require sudo..."
  if ! command sudo mv "$INSTALL_DIR/kloud-installer" /bin/ ; then 
    echo >&2 "Unable to move binaries. Please run with sudo and try again!"
  fi
  return
}

install_from_git
