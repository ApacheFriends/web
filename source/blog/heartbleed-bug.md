---
title: Heartbleed OpenSSL Bug
date: 2014/04/09
---

The Heartbleed Bug is a serious vulnerability in the popular OpenSSL cryptographic software library. This weakness allows stealing the information protected, under normal conditions, by the SSL/TLS encryption used to secure.
 
OpenSSL versions from 1.0.1 through 1.0.1f (inclusive) are vulnerable and make it possible to steal information, including everything from the encrypted content and to the secret key used for the encryption. The attack is also indetectable. 
This security issue has been described in detail on the following page:

[http://heartbleed.com/](http://heartbleed.com/)

 
If you are running any of the affected versions and are running a SSL-enabled website, meaning that you can access it using the https:// prefix instead of http://,  you will need to patch the libraries in your system and replace the certificates and keys that may have been compromised. Please notice that remote access using ssh is NOT affected.

## How to check if you are affected

Navigate to your XAMPP page and visit the *phpinfo()* link in the *Php* section of the left panel:

![phpinfo section](blog/phpinfo-section-1.png "phpinfo section")

And look for "SSL Version":

![phpinfo](blog/heartbleed-affected.png "heartbleed bug")

If the version is between 1.0.1 and 1.0.1f (both included), you are running a vulnerable version. The previous image shows an affected one, from XAMPP 1.8.3-3 for Windows. If you are running XAMPP 1.8.2 on Windows you are NOT vulnerable.

## How to fix it

We have released new XAMPP versions for all platforms fixing the bug but if you need to patch existing installations, you can follow the below instructions:

### XAMPP for Windows

If you are running XAMPP 1.8.2 on Windows you are NOT vulnerable. To patch your current 1.8.3 installation you will need to replace some files in your installation following the below steps:

1. Download the Windows patch files [xampp-opensslfix-win32.zip](http://sourceforge.net/projects/xampp/files/security/2014-04%20Heartbleed/xampp-opensslfix-win32.zip/download)
 

2. Stop Apache using the XAMPP control panel

3. Uncompress the xampp-opensslfix-win32.zip file in your desktop. It contains a folder with the following list of files:
```libeay32.dll
ssleay32.dll
openssl.exe
```

4. Navigate to your Apache bin directory, typically under:
```c:\xampp\apache\bin
```

5. Create a directory to story a copy of the files that will be replaced named 'opensslbackup'

6. Move the below list of files (located in the c:\xampp\apache\bin directory) to the folder you just created (opensslbackup)
```c:\xampp\apache\bin\libeay32.dll
c:\xampp\apache\bin\ssleay32.dll
c:\xampp\apache\bin\openssl.exe
```

7. Copy the files under the xampp-opensslfix-win32 folder you uncompressed in step 3 to c:\xampp\apache\bin

8. Navigate to your PHP directory, typically under:
```c:\xampp\php```

9. Create a directory to story a copy of the files that will be replaced named 'opensslbackup'

10. Move the below list of files (located in the c:\xampp\php directory) to the folder you just created (opensslbackup)
```c:\xampp\php\libeay32.dll
c:\xampp\php\ssleay32.dll
```

11. Copy the files under the xampp-opensslfix-win32 folder you uncompressed in step 3 to c:\xampp\php

12. Start Apache using the XAMPP control panel

13. Verify that the "SSL Version" has been updated to a safe one (at least 1.0.1g) using the phpinfo() information as explained in the previous section

![phpinfo](blog/heartbleed-fixed.png "heartbleed bug fixed")

### XAMPP for Linux

<a name="linuxfiles">

To patch your current installation you will need to replace some files in your installation. The first step would be to download the proper patch files for your architecture. If you are not sure, you can use the below command:

``file /opt/lampp/bin/openssl``

If the output looks like:

```/opt/lampp/bin/openssl: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.9, stripped
```

Then you need the 64 bit version: [xampp-opensslfix-linux-x64.tar.gz](http://sourceforge.net/projects/xampp/files/security/2014-04%20Heartbleed/xampp-opensslfix-linux-x64.tar.gz/download)
 
And if it looks like:

```/opt/lampp/bin/openssl: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.9, stripped
```

You will need the x86 version: [xampp-opensslfix-linux.tar.gz](http://sourceforge.net/projects/xampp/files/security/2014-04%20Heartbleed/xampp-opensslfix-linux.tar.gz/download)


Once you have the proper patch, you can either use the patch.sh script contained in them or follow the steps manually:

#### Automated Method

This method will try to automatically patch your XAMPP installation. If it fails at some point and your installation seems to still be outdated, you will have to check the manual method:

1. Download the Linux patch files (grab the proper version depending on your platform as explained [above](#linuxfiles)). 

2. Uncompress the downloaded file under /tmp
```tar -xzf xampp-opensslfix-linux.tar.gz -C /tmp/
```

3. Execute the patch.sh script:
```sudo /tmp/xampp-opensslfix-linux/patch.sh 
```
In most of the cases, the output of the script will be:
```Current OpenSSL version is: OpenSSL 1.0.1f 6 Jan 2014
You seem to be running an INSECURE OpenSSL version. Press any key to continue with the patching process.
Stopping Apache
XAMPP: Stopping Apache...ok.
Backing up files
Patching files
Starting Apache
XAMPP: Starting Apache...ok.
New OpenSSL version is OpenSSL 1.0.1g 7 Apr 2014
Successfully patched!
```


#### Manual Method


1. Download the Linux patch files (grab the proper version depending on your platform as explained [above](#linuxfiles)).
2. Stop Apache:
```sudo /opt/lampp/xampp stopapache
```

3. Uncompress the xampp-opensslfix-linux.tar.gz (or xampp-opensslfix-linux-x64.tar.gz) file under /tmp/
```tar -xzf xampp-opensslfix-linux.tar.gz -C /tmp/
```

4. Navigate to your XAMPP directory:
``cd /opt/lampp/``

5. Create a directory to story a copy of the files that will be replaced named 'opensslbackup'
``sudo mkdir -p /opt/lampp/opensslbackup/``

6. Move the below list of files to the folder you just created (opensslbackup)
```sudo mv /opt/lampp/lib/libssl* /opt/lampp/opensslbackup/
sudo mv /opt/lampp/lib/libcrypto* /opt/lampp/opensslbackup/
sudo mv /opt/lampp/lib/engines /opt/lampp/opensslbackup/
sudo mv /opt/lampp/bin/openssl /opt/lampp/opensslbackup/
```

7. Copy the files under the xampp-opensslfix-linux folder you uncompressed in step 3 to your XAMPP installation
```sudo cp -rp /tmp/xampp-opensslfix-linux/lib/* /opt/lampp/lib/
sudo cp -rp /tmp/xampp-opensslfix-linux/bin/openssl /opt/lampp/bin/
```

8. Start Apache
```sudo /opt/lampp/xampp startapache
```

9. Verify that the "SSL Version" has been updated to a safe one (at least 1.0.1g) using the phpinfo() information as explained in the previous section

![phpinfo](blog/heartbleed-fixed.png "heartbleed bug fixed")

Or using the below command:

```sudo /opt/lampp/bin/openssl version
```

It should now show a version higher to 1.0.1f:

```OpenSSL 1.0.1g 7 Apr 2014
```


### XAMPP for OS X

<a name="osxfiles">

To patch your current installation you will need to replace some files in your installation. The first step would be to download the patch files for OS X:  [xampp-opensslfix-osx.tar.gz](http://sourceforge.net/projects/xampp/files/security/2014-04%20Heartbleed/xampp-opensslfix-osx.tar.gz/download) 
nce you have the patch, you can either use the patch.sh script contained in them or follow the steps manually:

#### Automated Method

This method will try to automatically patch your XAMPP installation. If it fails at some point and your installation seems to still be outdated, you will have to check the manual method:

1. Download the Linux patch files ([xampp-opensslfix-osx.tar.gz](http://sourceforge.net/projects/xampp/files/security/2014-04%20Heartbleed/xampp-opensslfix-osx.tar.gz/download)

2. Uncompress the downloaded file under /tmp
``tar -xzf xampp-opensslfix-osx.tar.gz -C /tmp/``

3. Execute the patch.sh script:
``sudo /tmp/xampp-opensslfix-osx/patch.sh``

In most of the cases, the output of the script will be:
```Current OpenSSL version is: OpenSSL 1.0.1f 6 Jan 2014
You seem to be running an INSECURE OpenSSL version. Press any key to continue with the patching process.
Stopping Apache
XAMPP: Stopping Apache...ok.
Backing up files
Patching files
Starting Apache
XAMPP: Starting Apache...ok.
New OpenSSL version is OpenSSL 1.0.1g 7 Apr 2014
Successfully patched!
```

#### Manual Method


1. Download the Linux patch files ([xampp-opensslfix-osx.tar.gz](http://sourceforge.net/projects/xampp/files/security/2014-04%20Heartbleed/xampp-opensslfix-osx.tar.gz/download))
2. Stop Apache:
``sudo /Applications/XAMPP/xamppfiles/xampp stopapache``

3. Uncompress the xampp-opensslfix-osx.tar.gz file under /tmp/
``tar -xzf xampp-opensslfix-osx.tar.gz -C /tmp``

4. Navigate to your XAMPP directory:
``cd /Applications/XAMPP/xamppfiles/``

5. Create a directory to story a copy of the files that will be replaced named 'opensslbackup'
``sudo mkdir -p /Applications/XAMPP/xamppfiles/opensslbackup/``

6. Move the below list of files to the folder you just created (opensslbackup)
```sudo mv /Applications/XAMPP/xamppfiles/lib/libssl* /Applications/XAMPP/xamppfiles/opensslbackup/
sudo mv /Applications/XAMPP/xamppfiles/lib/libcrypto* /Applications/XAMPP/xamppfiles/opensslbackup/
sudo mv /Applications/XAMPP/xamppfiles/lib/engines /Applications/XAMPP/xamppfiles/opensslbackup/
sudo mv /Applications/XAMPP/xamppfiles/bin/openssl /Applications/XAMPP/xamppfiles/opensslbackup/
```

7. Copy the files under the xampp-opensslfix-osx folder you uncompressed in step 3 to your XAMPP installation
```sudo cp -rp /tmp/xampp-opensslfix-osx/lib/* /Applications/XAMPP/xamppfiles/lib/
sudo cp -rp /tmp/xampp-opensslfix-osx/bin/openssl /Applications/XAMPP/xamppfiles/bin/
```

8. Start Apache
``sudo /Applications/XAMPP/xamppfiles/xampp startapache``

9. Verify that the "SSL Version" has been updated to a safe one (at least 1.0.1g) using the phpinfo() information as explained in the previous section

![phpinfo](blog/heartbleed-fixed.png "heartbleed bug fixed")

Or using the below command:

``sudo /Applications/XAMPP/xamppfiles/bin/openssl version``

It should now show a version higher to 1.0.1f:

``OpenSSL 1.0.1g 7 Apr 2014``

