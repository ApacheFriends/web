---
title: Security vulnerability in XAMPP for Windows
date: 2007/04/27
author: Oswald
category: archive
---

Today someone sent me an exploit for the Windows version of XAMPP: Using our xampp/adodb.php and a buffer overflow vulnerability in mssql_connect() the exploit is able to call arbitrary(!) commands on the targeted system. 

If you secured your system as [described](http://www.apachefriends.org/en/xampp-windows.html#1221) in our manual, you're a lucky guy and your system is not affected by this vulnerability.
If you haven't secured your system, please [do it](http://www.apachefriends.org/en/xampp-windows.html#1221) right now!!!
