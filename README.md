ganeti_webmgr Cookbook
======================
This cookbook is for easy deployment of ganeti_webmgr. In particular it is
aimed at deployment to Vagrant, but the end goal is to have a general
cookbook that allows you to deploy GWM easily in any environment.

Requirements
------------

For testing you need the following gems:

- `test-kitchen`
- `kitchen-vagrant`

If you use berkshelf, you also will want to install the `berkshelf` gem as well.

To install dependencies run 'bundle install' in the root of the directory.


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
    <td>Full path to the location GWM gets cloned. Note: This is not where it is installed.</td>
    <td><tt>/opt/ganeti_webmgr_src</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['user']</tt></td>
    <td>String</td>
    <td>User to change to when running commands</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['group']</tt></td>
    <td>String</td>
    <td>Group to change to when running commands</td>
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
    <td><tt>['ganeti_webmgr']['install_dir']</tt></td>
    <td>String</td>
    <td>Where to actually install GWM to. This is the location setup.sh will create GWM's virtualenv</td>
    <td><tt>/opt/ganeti_webmgr</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['config_dir']</tt></td>
    <td>String</td>
    <td>Where gwm's config directory goes. This is the directory config.yml will be put into.</td>
    <td><tt>/opt/ganeti_webmgr/config</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['debug']</tt></td>
    <td>Boolean</td>
    <td>Whether or not to set the Django debug mode on or off</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['migrate']</tt></td>
    <td>Boolean</td>
    <td>Whether or not to run database migrations</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['static_root']</tt></td>
    <td>String</td>
    <td>Absolute path to where you want staticfiles to be collected to</td>
    <td><tt>/opt/ganeti_webmgr/collected_static</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['static_url']</tt></td>
    <td>String</td>
    <td>Url to find GWM's static files at.</td>
    <td><tt>/static</tt></td>
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
  <tr>
    <td><tt>['ganeti_webmgr']['haystack_whoosh_path']</tt></td>
    <td>String</td>
    <td>Where to put the search index files</td>
    <td><tt>/opt/ganeti_webmgr/whoosh_index</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['vnc_proxy']</tt></td>
    <td>String</td>
    <td>The host:port pair where to access the VNCAuthProxy</td>
    <td><tt>node['fqdn']:8888</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['secret_key']</tt></td>
    <td>String</td>
    <td>The SECRET_KEY for GWM</td>
    <td><tt>No Default, left unset.</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['web_mgr_api_key']</tt></td>
    <td>String</td>
    <td>The WEB_MGR_API_KEY for GWM</td>
    <td><tt>No Default, left unset.</tt></td>
  </tr>
</table>

#### ganeti_webmgr::bootstrap_user
<table>
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
