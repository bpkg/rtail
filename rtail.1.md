rtail(1) -- Tail file over ssh
=================================

## SYNOPSIS

`rtail` [-hvV] [ssh_options] [user@]<host> [tail_options] [files ...]

## OPTIONS

  `-v, --verbose`           enable verbose output
  `-h, --help`              display this message
  `-V, --version`           output version

  `[ssh_options]`           ssh options
  `[tail_options]`          tail options

## USAGE

  $ rtail somehost.com -f /var/log/host.log

## AUTHOR

  - Joseph Werle <joseph.werle@gmail.com>

## REPORTING BUGS

  - https://github.com/jwerle/rtail/issues

## SEE ALSO

  `ssh`(1), `tail`(1)

## LICENSE

  MIT (C) Copyright Joseph Werle 2014

