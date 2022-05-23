---
title: Developing a PHP application on XAMPP-VM for OS X
date: 2017/07/11
---

[XAMPP-VM for OS X](https://www.apachefriends.org/download.html#download-apple) is a XAMPP application that lets you run XAMPP for Linux on your Mac using an OS X hypervisor based on [hyperkit](https://github.com/moby/hyperkit). As a result, you have a dev environment that's much closer to what you'll usually see in production. Plus, it's very lightweight, as it doesn't require other preinstalled software like VirtualBox or VMware.

Putting together a database-backed [CakePHP](https://cakephp.org/) application on XAMPP-VM using the included Apache, PHP and MariaDB components is fairly easy to do. This blog post will walk you through the steps.

### Assumptions

- You've already installed and started XAMPP-VM
- You have some familiarity with [PHP](http://php.net/) development, including how to create tables and grant user privileges in [MariaDB](https://mariadb.org/) ([learn more](https://dev.mysql.com/doc/))

Before proceeding, check the XAMPP-VM stack manager and ensure that:

- The Apache and MySQL services are running.

![Service status](blog/xampp-vm-cakephp-1.png "Services")

- Port forwarding between port 8080 of the host machine and port 80 of the XAMPP-VM stack is enabled.

![Port forwarding status](blog/xampp-vm-cakephp-2.png "Network")

- The */opt/lampp* directory of the XAMPP-VM stack is mounted.

![Mount status](blog/xampp-vm-cakephp-3.png "Volumes")

### Create a skeleton CakePHP application

The easiest way to get started with a new CakePHP application is with [Composer](https://getcomposer.org/), the PHP dependency manager. From the XAMPP-VM stack manager's "General" tab, click "Open Terminal". This will start a new XAMPP-VM console with root privileges. At the console prompt, execute the command below to download Composer:

    $ curl -s https://getcomposer.org/installer | php

Once Composer has been downloaded, execute the command below to create a new CakePHP skeleton application in the */opt/lampp/htdocs/myapp* directory:

    $ COMPOSER_ALLOW_SUPERUSER=1 php composer.phar create-project --prefer-dist cakephp/app myapp

| NOTE: Composer will not allow you to run commands as root for security reasons and will normally issue a warning when you attempt this. However, since the XAMPP-VM console is preconfigured to run with root privileges, the *COMPOSER_ALLOW_SUPERUSER=1* environment variable is added to the previous command to deactivate the warning. [Learn more about this in the Composer documentation](https://getcomposer.org/doc/03-cli.md#composer-allow-superuser).

You should see something like this as the skeleton application is installed:

![CakePHP skeleton application installation](blog/xampp-vm-cakephp-4.png "CakePHP skeleton application installation")

Once the skeleton application is installed, test it by browsing to *http://localhost:8080/myapp*. You should see the default CakePHP application welcome page, as shown below:

![CakePHP skeleton application welcome page](blog/xampp-vm-cakephp-5.png "CakePHP skeleton application welcome page")

Notice that the page includes an error about CakePHP being unable to connect to the database. We'll fix that in the next step. For the moment, rejoice in the fact that your CakePHP skeleton is installed and (mostly) ready for use.

### Create a database user and database

XAMPP-VM includes [phpMyAdmin](https://www.phpmyadmin.net/), which you can access by browsing to *http://localhost:8080/phpmyadmin* (remember that port forwarding should be active for this to work). From the "User accounts" tab, create a new user called *myapp*, set a password and instruct phpMyAdmin to create a database of the same name and grant this user account full privileges to it.

![Database user creation](blog/xampp-vm-cakephp-6.png "Database user creation")

Switch back to the XAMPP-VM console and adjust the default ownership of the */opt/lampp/htdocs/myapp/config/app.php* file so that you can edit it through the OS X Finder:

    $ cd /opt/lampp/htdocs/myapp
    $ chown bitnami.root config/myapp.php

Using the OS X Finder, browse to the mounted */opt/lampp* directory and edit the *htdocs/myapp/config/app.php* file. Update the "Datasources" key of the configuration array with the new database name and account credentials created above, as shown below, and save the changes.

![CakePHP database configuration](blog/xampp-vm-cakephp-7.png "CakePHP database configuration")

Re-test the skeleton application by browsing to *http://localhost:8080/myapp*. You should now see that the previous database connection error has been resolved and the CakePHP application is able to connect to the XAMPP-VM MariaDB database using the provided credentials.

![CakePHP skeleton application welcome page](blog/xampp-vm-cakephp-8.png "CakePHP skeleton application welcome page")

You're now ready to begin developing the application.

### Create a database table and CRUD scaffolding

We won't be developing anything very complicated here; a simple to-do list application should provide the foundation you need to start creating your own applications. Begin by browsing to phpMyAdmin and creating a new table named *todo* in the *myapp* database with three fields: a primary key (*id*), a VARCHAR field (*title*) and a BOOLEAN field (*status*). Here's what the result should look like:

![Database table creation](blog/xampp-vm-cakephp-9.png "Database table creation")

One of the nice things about CakePHP is that it can inspect your database and automatically create basic [Create/Read/Update/Delete (CRUD) scaffolding](https://book.cakephp.org/3.0/en/bake/usage.html) to interact with your data. This significantly simplifies the amount of work you have to do when building database-driven apps. To see this in action, switch back to the XAMPP-VM console and run the following commands:

    $ cd /opt/lampp/htdocs/myapp
    $ chmod +x bin/cake
    $ ./bin/cake bake all todo

CakePHP will go to work creating the necessary CRUD templates and code for the *todo* table. Once it's done, browse to *http://localhost:8080/myapp/todo* and you should see a basic interface to add, edit and delete todo list items, as shown below:

![To-do list CRUD scaffolding](blog/xampp-vm-cakephp-10.png "To-do list CRUD scaffolding")

Try adding a new item, and you'll see it appear in the list, together with links to view, edit and delete it:

![To-do list CRUD scaffolding](blog/xampp-vm-cakephp-11.png "To-do list CRUD scaffolding")

As you can see, you've now got the bare bones of a database-driven PHP application running on XAMPP-VM...and it was fairly easy to get here as well!

You can now continue building out the application by adding more database tables, modifying the templates to use a different interface, or adding custom business logic to the controllers. Read more about all these tasks in the [official CakePHP cookbook](https://book.cakephp.org/), or [download XAMPP-VM for OS X](https://www.apachefriends.org/download.html#download-apple) and try it today!
