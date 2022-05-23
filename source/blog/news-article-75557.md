---
title: Possible privilege escalations in XAMPP for Windows
date: 2006/05/09
author: Oswald
category: archive
---

Thierry Zoller informed us about four possible privilege escalations in XAMPP for Windows. Thierry, thank you very much for notifying us of this problem.

The problem occurs if the installation path of XAMPP for Windows contains a blank character (like in [b:jmamqbgm]C:\Program files\XAMPP[/b:jmamqbgm]) and you're creating a file named [b:jmamqbgm]C:\Program.exe[/b:jmamqbgm]. In this case you will be able (for example) to catch the starting FileZilla service and start your own program ([b:jmamqbgm]C:\Program.exe[/b:jmamqbgm]) as a service.

To exploit this vulnerability an attacker already needs full access to your C:\ directory to create the needed C:\Program.exe file.

Thierry found three other scenarios within this bug will appear. To find out more details about this problem please take a look into [Thierry's Blog](http://secdev.zoller.lu/research/xamp1.htm).

[b:jmamqbgm]Update May 9th 2006[/b:jmamqbgm]
The current [Windows beta](http://www.apachefriends.org/de/xampp-beta.html) fixes two of the problems based on this bug. We expect the next beta soon which will fix all four problems.

[b:jmamqbgm]Update May 10th 2006[/b:jmamqbgm]
The new [Windows beta](http://www.apachefriends.org/de/xampp-beta.html) now fixes all problems.
