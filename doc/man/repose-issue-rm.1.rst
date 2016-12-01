.. vim: ft=rst sw=2 sts=2 et

===================
**repose-issue-rm**
===================

----------------------------------
Remove issue-specific repositories
----------------------------------

:Authors:
:Copyright: GPL-3.0
:Version: @VERSION@
:Manual section: 1
:Manual group: User Commands
:Maintainer: openSUSE Project

SYNOPSIS
========

**repose issue-rm** **-h** \| **--help**

**repose issue-rm** [**-v** \| **--verbose**] [**-n** \| **--print**] *HOST*... -- *ISSUE*...

DESCRIPTION
===========

**repose issue-rm** removes, from each *HOST*, any number of package repositories for one or more maintenance updates. Removes repositories with names matching \*:p=\ *ISNO*, where an *ISNO* is derived from each *ISSUE* (see below for details).

OPTIONS
=======

:-h:
 Display usage instructions.

:--help:
 Display this manual page.

:-n, --print:
 Write destructive operations to standard output, do not actually perform them.

:-v, --verbose:
 Disable quiet mode for ssh and scp that suppresses most warning and diagnostic messages.

OPERANDS
========

*HOST*
 Machine to operate on (see repose(1)).

*ISSUE*
 A string of the following format: [SUSE:Maintenance:]\ *ISNO*\ [:\ *MRNO*\ ]

EXAMPLES
========

Remove repositories created using repose-issue-add(1) for SUSE:Maintenance:1234 and SUSE:Maintenance:2345.

::

$ repose issue-rm root@{fubar,snafu}.example.org -- SUSE:Maintenance:1234 2345

SEE ALSO
========

repoq(1), repose(1), repose-issue-add(1), ssh(1), sumaxy(1), zypper(8).

REPOSE
======

**repose issue-rm** is part of repose(1).
