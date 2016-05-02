Symfony Backend Boilerplate
===========================

Included
--------

 - PHP7
 - Symfony 3
 - PostgreSQL
 - Bootstrap
 - JQuery
 - Unirest
 - Font Awesome
 - PHPUnit
 
This is simple backend boilerplate giving your a simple app
with a left menu and top bar, translation, and sample of most
UI elements. This is based on the [SB Admin 2](http://startbootstrap.com/template-overviews/sb-admin-2/)
theme.

Requirements
------------

 - Vagrant
 - Ansible (Unix Only, will be installed on the guest on Windows)
 - VirtualBox (This could be changed to an other Hypervisor or Docker but the VagrantFile was made for Vbox to be cross-platform)

Usage
-----

    vagrant up

This will start the website on port `9502` (default, see the `VagrantFile` to change it if necessary).
After the first provisioning you should be able to access
the website on `http://127.0.0.1/app_dev.php`.

You also can change a few configuration in the `VagrantFile`,
if you do change the `APPNAME` be sure to change the `utils/*.sh` files accordingly if you want to use those.

You can access the VM by running `vagrant ssh`, the src is mounted
in `/vagrant` folder as defined in the `VagrantFile`.

Utils
-----

This project bundles a few utils to avoid having to `vagrant ssh`:

 - `utils/app_console.sh` Runs the Symfony console with given parameters
   - Ex: `utils/app_console.sh doctrine:migrations:migrate`
 - `utils/clear_cache.sh`: Clears Symfony cache
   - Ex: `utils/clear_cache.sh prod`
 - `utils/run_cs.sh`: Runs PHP Code Sniffer with `sf23` config style
   - Ex: `utils/run_cs.sh -f`
 - `utils/run_tests.sh`: Runs PHPUnit
   - Ex: `utils/run_tests.sh --help`
 