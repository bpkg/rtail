#!/bin/bash

VERSION="0.0.1"
NULL=/dev/null
STDIN=0
STDOUT=1
STDERR=2
VERBOSE=0

host=""
files=""

## is piped ?
if [ -t 0 ]; then
  ISATTY=1
else
  ISATTY=0
fi

## detect ssh environment arguments
if [[ -z "$SSH_ARGS" ]]; then
  SSH_ARGS=""
fi

## detect tail environment arguments
if [[ -z "$TAIL_ARGS" ]]; then
  TAIL_ARGS=""
fi

## output program version
version () {
  echo $VERSION
}

## outputs program usage
usage () {
  echo "usage: rtail [-hvV] [ssh_options] [user@]<host> [tail_options] [files ...]"
}

## outputs verbose information
verbose () {

  if [[ "1" == "$VERBOSE" ]]; then
    {
      printf "verbose: "
      echo "$@"
    } >&$STDERR
  fi
}

## output to stderr
perror () {
  {
    printf "error: "
    echo "$@"
  } >&$STDERR
}

## parse program opts and build
## ssh and tail arguments
parse_opts () {

  while true; do
    arg="$1"

    ## break on empty arg
    if [ "" = "$1" ]; then
      break;
    fi

    ## ignore args without a `-' prefix
    ## but attempt to set host and file(s)
    ## to tail
    if [ "${arg:0:1}" != "-" ]; then
      if [[ -z "$host" ]]; then
        host="$1"
      else
        files+="$1 "
      fi
      shift
      continue
    fi

    ## overload these flags and
    ## pass subsequent arguments
    ## directly to `tail(1)'
    case $arg in

      -h|--help)
        usage 1
        return 1
        ;;

      -V|--version)
        version
        exit
        ;;

      -v|--verbose)
        SSH_ARGS+="-v "
        VERBOSE=1
        shift
        ;;

      ## catch all
      *)

        if [[ -z "$host" ]]; then
          SSH_ARGS+="$1";
        elif [[ -z "$files" ]]; then
          TAIL_ARGS+="$1"
        elif [ "-" = "${arg:0:1}" ]; then
          perror "Unknown argument \`${arg}'"
          usage
          return 1
        fi
        shift
        ;;

    esac
  done
}

rtail () {
  ## opts
  parse_opts "$@" || return 1

  ## detect missing variables
  if [[ -z $host ]]; then
    perror "Missing host"
    usage
    return 1
  elif [[ -z $files ]]; then
    perror "Missing input file(s)"
    usage
    return 1
  fi

  ## build command
  cmd="ssh $SSH_ARGS $host tail $TAIL_ARGS $files"

  ## verbose out
  verbose "host = $host"
  verbose "ssh arguments = '$SSH_ARGS'"
  verbose "file(s) = $files"
  verbose "tail arguments = '$TAIL_ARGS'"
  verbose "command = '$cmd'"

  ## exec
  $cmd
}

if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f rtail
else
  rtail "$@"
fi
