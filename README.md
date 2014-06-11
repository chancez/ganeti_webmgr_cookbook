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
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['web_mgr_api_key']</tt></td>
    <td>String</td>
    <td>The WEB_MGR_API_KEY for GWM</td>
    <td><tt>nil</tt></td>
  </tr>
</table>

#### ganeti_webmgr::bootstrap_user
<table>
  <tr>
    <td><tt>['ganeti_webmgr']['superusers']</tt></td>
    <td>List</td>
    <td>Takes a list of hashes containing the following keys: username, email and password</td>
    <td><tt>[]</tt></td>
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


#### ganeti_webmgr::apache
<table>
  <tr>
    <td><tt>['ganeti_webmgr']['apache']['application_name']</tt></td>
    <td>String</td>
    <td>Name of vhost file. `.conf` is added to the end automatically.</td>
    <td><tt>ganeti_webmgr</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['apache']['server_name']</tt></td>
    <td>String</td>
    <td>Servername for apache vhost</td>
    <td><tt>node['hostname']</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['apache']['server_aliases']</tt></td>
    <td>List</td>
    <td>A list of server_alises for the apache vhost</td>
    <td><tt>[node['fqdn']]</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['apache']['processes']</tt></td>
    <td>Int</td>
    <td>Number of WSGI processes to run for GWM.</td>
    <td><tt>4</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['apache']['Threads']</tt></td>
    <td>Int</td>
    <td>Number of threads for each WSGI process in GWM.</td>
    <td><tt>1</tt></td>
  </tr>
</table>

#### ganeti_webmgr::database
<table>
  <tr>
    <td><tt>['ganeti_webmgr']['db_server']['user']</tt></td>
    <td>String</td>
    <td>User to login to the database server as when creating a database for GWM.</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['ganeti_webmgr']['db_server']['password']</tt></td>
    <td>String</td>
    <td>Password to login to the database server as when creating a database for GWM.</td>
    <td><tt>nil</tt></td>
  </tr>
</table>

Usage
-----
#### ganeti_webmgr::default or ganeti_webmgr::mysql
Just include `ganeti_webmgr` in your node's `run_list`.
If you want to have it deploy, install mysql server and bootstrap a database for
you use `ganeti_webmgr::mysql`:

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

Only use the mysql recipe if you want mysql server installed. If you simply want
to use GWM with a different mysql server, use the `ganeti_webmgr::default`
recipe and set the appropriate attributes.

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

Then set the attribute `node['ganeti_webmgr']['superusers']` to something like
this:

````json
[
  {
    "username": "foo",
    "password": "bar",
    "email": "foo@bar.com"
  },
  {
    "username": "admin",
    "password": "secret",
    "email": "admin@bar.com"
  }
]
````

#### ganeti_webmgr::hosts

This recipe is used to add hostname aliases in `/etc/hosts`.  In the vagrant
environment, it defaults to adding hostnames to be used with [vagrant-
ganeti](https://github.com/osuosl/vagrant-ganeti).

Databags
--------

The `ganeti_webmgr` cookbook supports loading passwords and secrets using either
attributes or through chef's encrypted databags.

Currently the cookbook expects all secrets to be in a single databag called
`ganeti_webmgr`, and in an item called `passwords`.

Here are the list of values according to their purpose if you wish to use
databags:

* `db_password`: This is used with the `ganeti_webmgr::database` recipe. This is
  what the recipe will set as the password for the user specified in
  `node['ganeti_webmgr']['database']['user']` on the database being created.
* `db_server`: This is a hash which should contain the key `password` and
  optionally `user`, which are the actual credentials needed to login to the
  database application (mysql/postgres) to add a user, and create a database
  for that user. Essentially, this contains the credentials for a db user
  with create database permissions.
* `secret_key` and `web_mgr_api_key`: Each of these correspond directly to the
  settings in GWM's config.yml.
* `superusers`: This should be a list of hashes containing the keys `username`,
  `password`, and `email`. Each item in the list will be added as a superuser to
  GWM.

**Note**: These databag values are only used if the attributes for them **are
not set**

Here's an example databag in unencrypted form for the vagrant environment:

````json
{
    "id": "passwords",
    "db_password": "vagrant",
    "db_server": {
        "password": "rootpass"
    },
    "secret_key": "eo6uuJeegah9vieHahnahriv5noivahT",
    "web_mgr_api_key": "quae5aethaehahCeiquaenahjaice3ei",
    "superusers": [
        {
            "username": "admin",
            "password": "password",
            "email": "admin@example.org"
        }
    ]
}
````


License and Authors
-------------------
Authors: Chance Zibolski <chance@osuosl.org>
