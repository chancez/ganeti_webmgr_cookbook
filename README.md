ganeti_webmgr Cookbook
======================
This cookbook is for easy deployment of ganeti_webmgr. In particular it is
aimed at deployment to Vagrant, but the end goal is to have a general
cookbook that allows you to deploy GWM easily in any environment.

Requirements
------------
TODO: List your cookbook requirements. Be sure to include any requirements this cookbook has on platforms, libraries, other cookbooks, packages, operating systems, etc.

- `vagrant-berkshelf` - If deploying to vagrant
- `berkshelf` - If deploying any otherway

Attributes
----------

#### ganeti_webmgr::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['path']</tt></td>
    <td>String</td>
    <td>Full path to the location you want GWM at</td>
    <td><tt>/var/lib/django/ganeti_webmgr</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['owner']</tt></td>
    <td>String</td>
    <td>Owner of the project and its virtual environment</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['group']</tt></td>
    <td>String</td>
    <td>Group of the project and its virtualenv</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['repository']</tt></td>
    <td>String</td>
    <td>Git repository to clone GWM from</td>
    <td><tt>https://github.com/osuosl/ganeti_webmgr</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['revision']</tt></td>
    <td>String</td>
    <td>What branch to checkout GWM on</td>
    <td><tt>develop</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['packages']</tt></td>
    <td>Array of strings</td>
    <td>List of packages to install before setting up GWM</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['pip_packages']</tt></td>
    <td>Array of strings</td>
    <td>List of python packages to install before setting up GWM</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['virtualenv']</tt></td>
    <td>String</td>
    <td>Full path to where you want GWM to store its virtual environment</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['requirements']</tt></td>
    <td>String</td>
    <td>Relative path from ['ganeti_webmgr']['path'] to the requirements file containing pip packages to install GWM</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['debug']</tt></td>
    <td>Boolean</td>
    <td>Whether or not to set the Django debug mode on or off</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['local_settings_file']</tt></td>
    <td>String</td>
    <td>Relative path from ['ganeti_webmgr']['path'] to Ganeti Web Managers settings file.</td>
    <td><tt>ganeti_webmgr/ganeti_web/settings/settings.py</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['settings_template']</tt></td>
    <td>String</td>
    <td>Path to settings.py chef template.</td>
    <td><tt>settings.py.erb</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['overwrite_settings']</tt></td>
    <td>Boolean</td>
    <td>Overwrite existing settings files if it exists when deploying</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['migrate']</tt></td>
    <td>Boolean</td>
    <td>Whether or not to run database migrations</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['settings']</tt></td>
    <td>Hash</td>
    <td>Additional settings to pass to ['ganeti_webmgr']['settings_template']</td>
    <td><tt>{}</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['manage_file']</tt></td>
    <td>String</td>
    <td>Relative path from ['ganeti_webmgr']['path'] to the GWM manage.py file</td>
    <td><tt>ganeti_webmgr/manage.py</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['collectstatic_dir']</tt></td>
    <td>String</td>
    <td>Absolute path to where you want staticfiles to be collected to</td>
    <td><tt>['ganeti_webmgr']['path']/collected_static</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['database']['engine']</tt></td>
    <td>String</td>
    <td>See https://docs.djangoproject.com/en/1.4/ref/settings/#databases</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['database']['name']</tt></td>
    <td>String</td>
    <td>See https://docs.djangoproject.com/en/1.4/ref/settings/#databases</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['database']['user']</tt></td>
    <td>String</td>
    <td>See https://docs.djangoproject.com/en/1.4/ref/settings/#databases</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['database']['password']</tt></td>
    <td>String</td>
    <td>See https://docs.djangoproject.com/en/1.4/ref/settings/#databases</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['database']['host']</tt></td>
    <td>String</td>
    <td>See https://docs.djangoproject.com/en/1.4/ref/settings/#databases</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['database']['port']</tt></td>
    <td>String</td>
    <td>See https://docs.djangoproject.com/en/1.4/ref/settings/#databases</td>
    <td><tt>nil</tt></td>
  </tr>
</table>

#### ganeti_webmgr::proxy
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['host']</tt></td>
    <td>String</td>
    <td>Host GWM is deployed on, for configuring http proxy</td>
    <td><tt>node['fqdn']</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['port']</tt></td>
    <td>Integer</td>
    <td>Port GWM is listening on, for configuring http proxy</td>
    <td><tt>8000</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['http_proxy']['variant']</tt></td>
    <td>String</td>
    <td>Used to specify what to use as an http_proxy. Valid options are "nginx"</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['http_proxy']['host_name']</tt></td>
    <td>String</td>
    <td>Hostname of the http proxy</td>
    <td><tt>node['fqdn']</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['http_proxy']['host_aliases']</tt></td>
    <td>List</td>
    <td>List of hostname aliases</td>
    <td><tt>[]</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['http_proxy']['listen_ports']</tt></td>
    <td>List of integers</td>
    <td>List of ports for the http proxy to listen on</td>
    <td><tt>[ 80 ]</tt></td>
  </tr>
</table>

#### ganeti_webmgr::bootstrap_user
<table>
  <tr>
    <td><tt>['ganeti_webmgr']['bootstrap_user']</tt></td>
    <td>boolean</td>
    <td>**Do not use in production.** Used for boostrapping a Django superuser after deployment.</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['admin_username']</tt></td>
    <td>string</td>
    <td>**Do not use in production.** Username of Django superuser to boostrap after deployment.</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['admin_password']</tt></td>
    <td>string</td>
    <td>**Do not use in production.** Password of Django superuser to boostrap after deployment.</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['admin_email']</tt></td>
    <td>string</td>
    <td>**Do not use in production.** Email of Django superuser to boostrap after deployment.</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['admin_email']</tt></td>
    <td>string</td>
    <td>**Do not use in production.** Email of Django superuser to boostrap after deployment.</td>
    <td><tt>nil</tt></td>
  </tr>
</table>

#### ganeti_webmgr::hosts
<table>
  <tr>
    <td><tt>['ganeti_webmgr']['hostsfile']</tt></td>
    <td>Hash</td>
    <td>A mapping of ips to hostnames to add to `/etc/hosts/`</td>
    <td><tt>{}</tt></td>
  </tr>
</table>

Usage
-----
#### ganeti_webmgr::default or ganeti_webmgr::mysql
Just include `ganeti_webmgr` in your node's `run_list`.
If you want to have it deploy with mysql and bootstrap a database for you use
`ganeti_webmgr::mysql`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ganeti_webmgr]"
  ]
}
```

or

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ganeti_webmgr::mysql]"
  ]
}
```
#### ganeti_webmgr::bootstrap_user
Just include `ganeti_webmgr::bootstrap_user` in addition to one of the previous
recipes in `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ganeti_webmgr::default]"
    "recipe[ganeti_webmgr::bootstrap_user]"
  ]
}
```

#### ganeti_webmgr::hosts

This recipe is used to add hostname aliases in `/etc/hosts`.  In the vagrant
environment, it defaults to adding hostnames to be used with [vagrant-
ganeti](https://github.com/osuosl /vagrant-ganeti).

License and Authors
-------------------
Authors: Chance Zibolski <chance@osuosl.org>
