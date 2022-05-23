---
title: New version of LAMPP (1.0)
date: 2003/06/01
author: Oswald
category: archive
---

This month LAMPP got 1 year old and after getting up to version 0.9.9a I think this is a good time to release the 1.0 version.

Fresh and new in this version of LAMPP: Apache (2.0.46), PHP (4.3.2), MySQL (4.0.13), ProFTPD (1.2.8) und phpMyAdmin (2.5.0).

Notice: In this version of LAMPP I compiled PHP with internal MySQL support and not by linking to MySQL 4.0.13 own client library. The combination PHP 4.3.2 and MySQL 4.0.13 seems to be not stable. You can crash the Apache by clicking on any "BROWSE" button in phpMyAdmin. The internal PHP MySQL support doesn't seems to have this bug and works - as far as I can see - stable.
