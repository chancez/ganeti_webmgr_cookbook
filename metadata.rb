name             'ganeti_webmgr'
maintainer       'OSU Open Source Lab'
maintainer_email 'chance@osuosl.org'
license          'All rights reserved'
description      'Installs/Configures Ganeti Web Manager'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.2'
depends          'python'
depends          'supervisor'
depends          'gunicorn'
depends          'nginx'
depends          'mysql'
depends          'database'
