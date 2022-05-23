---
title: New XAMPP 1.8.2-1 and 1.8.3-0 versions
date: 2013/07/29
author: Beltran
category: archive
---

We are happy to announce a new release of XAMPP for all platforms! This is a minor release that fixes the following issues in both XAMPP versions:

1.8.2-1 version (PHP 5.4 based)

- Fix issue with RedHat-based Linux distros (i.e CentOS) in which the start script would fail to autodetect the distribution and start the servers.
- Create "mysql" user if it does not already exist on Linux. Now MySQL runs as "mysql" user by default.
- Change Apache and ProFTP users to "daemon" on Linux. The previous "nobody" user does not exist on some Linux distributions by default (i.e. CentOS).
- Fix Mercury Mail configuration on Windows.
- Fix XDebug issue on Windows. The previous module did not work with this PHP version.

1.8.3-0 version (PHP 5.5 based)

- Updated PHP to 5.5.1 version for Windows, OS X and Linux.
- Fix issue with RedHat-based Linux distros (i.e CentOS) in which the start script would fail to autodetect the distribution and start the servers.
- Create "mysql" user if it does not already exist on Linux. Now MySQL runs as "mysql" user by default.
- Change Apache and ProFTP users to "daemon" on Linux. The previous "nobody" user does not exist on some Linux distributions by default (i.e. CentOS).


Our goal is to keep releasing new versions periodically and maintaining the stacks up-to-date. Old versions are still archived in case you need them. Thanks to all users that posted issues in the forums. You can contribute to the Apache Friends project submitting your suggestions at <!-- m --><a class="postlink" href="https://community.apachefriends.org/f/">https://community.apachefriends.org/f/</a><!-- m -->

Enjoy!
