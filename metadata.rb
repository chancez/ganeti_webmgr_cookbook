name             'ganeti_webmgr'
maintainer       'Oregon State University'
maintainer_email 'chance@osuosl.org'
license          'All rights reserved'
description      'Installs/Configures Ganeti Web Manager'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.0'
depends          'python'
depends          'git'
depends          'supervisor'
depends          'gunicorn'
depends          'nginx'
depends          'mysql'
depends          'postgresql'
depends          'sqlite'
depends          'database'
depends          'hostsfile'
