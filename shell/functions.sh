# Run a simple Java source file: compile it, then execute its main class.
# Supports files without a package declaration, for example: rj Hello.java
rj() {
  if (( $# < 1 )); then
    print -u2 "Usage: rj FILE.java [arguments...]"
    return 2
  fi

  local file="$1"
  local directory="${file:h}"
  local class_name="${file:t:r}"
  shift

  if [[ ! -f "$file" || "$file" != *.java ]]; then
    print -u2 "rj: expected an existing .java file: $file"
    return 2
  fi

  javac "$file" && java -cp "$directory" "$class_name" "$@"
}

# Run a Python script with the system Python 3 interpreter.
rp() {
  if (( $# < 1 )); then
    print -u2 "Usage: rp FILE.py [arguments...]"
    return 2
  fi

  python3 "$@"
}

# Run a project wrapper from the current directory or any parent directory.
_run_project_wrapper() {
  local wrapper="$1"
  shift

  local directory="$PWD"

  while [[ "$directory" != "/" ]]; do
    if [[ -x "$directory/$wrapper" ]]; then
      (
        cd "$directory" || return
        "./$wrapper" "$@"
      )
      return
    fi

    directory="${directory:h}"
  done

  print -u2 "No executable $wrapper found in this directory or its parents."
  return 1
}

# Run a Maven Wrapper command, for example: mw test
mw() {
  _run_project_wrapper "mvnw" "$@"
}

# Run a Gradle Wrapper command, for example: gw test
gw() {
  _run_project_wrapper "gradlew" "$@"
}
