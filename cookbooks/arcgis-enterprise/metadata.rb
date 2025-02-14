name             'arcgis-enterprise'
maintainer       'Esri'
maintainer_email 'contracts@esri.com'
license          'Apache 2.0'
description      'Installs and configures ArcGIS Enterprise'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '3.8.0'
chef_version     '>= 13.0' if defined? chef_version

depends          'arcgis-repository', '~> 3.8'
depends          'hostsfile', '~> 3.0'
depends          'limits', '~> 1.0'
depends          'windows', '~> 5.3'
depends          'windows_firewall', '~> 5.0'
depends          'ms_dotnet', '~> 4.2'
depends          'nfs', '~> 2.6'
depends          'java_properties', '~> 0.1'

supports         'windows'
supports         'ubuntu'
supports         'redhat'
supports         'centos'
supports         'oracle'
supports         'suse'

recipe 'arcgis-enterprise::clean', 'Deletes local directories created by ArcGIS software'
recipe 'arcgis-enterprise::datastore', 'Installs and configures ArcGIS Data Store on primary machine'
recipe 'arcgis-enterprise::datastore_standby', 'Installs and configures ArcGIS Data Store on standby machine'
recipe 'arcgis-enterprise::disable_geoanalytics', 'Resets the big data analytics configuration on Portal for ArcGIS'
recipe 'arcgis-enterprise::disable_loopback_check', 'Enables filesharing via a DNS Alias'
recipe 'arcgis-enterprise::disable_rasteranalytics', 'Resets raster analytics configuration on Portal for ArcGIS'
recipe 'arcgis-enterprise::egdb', 'Registers GeoDatabases with server'
recipe 'arcgis-enterprise::enable_geoanalytics', 'Configures the ArcGIS Portal to perform big data analytics'
recipe 'arcgis-enterprise::enable_rasteranalytics', 'Configures the ArcGIS Portal to raster analytics'
recipe 'arcgis-enterprise::enterprise_installed', 'Installs ArcGIS Server, Data Store, Portal, and Web Adaptors for Server and Portals'
recipe 'arcgis-enterprise::enterprise_uninstalled', 'Uninstalls all ArcGIS software of the specified version'
recipe 'arcgis-enterprise::enterprise_validate', 'Checks if ArcGIS Server setups and authorization files exist'
recipe 'arcgis-enterprise::federation', 'Federates ArcGIS Server with Portal for ArcGIS'
recipe 'arcgis-enterprise::fileserver', 'Configures shared directories on file server machine'
recipe 'arcgis-enterprise::hosts', 'Creates entries in /etc/hosts file for the specified hostname to IP address map'
recipe 'arcgis-enterprise::install_datastore', 'Installs ArcGIS Data Store'
recipe 'arcgis-enterprise::install_portal_wa', 'Installs Web Adaptor for Portal for ArcGIS'
recipe 'arcgis-enterprise::install_portal', 'Installs Portal for ArcGIS'
recipe 'arcgis-enterprise::install_server_wa', 'Installs Web Adaptor for ArcGIS Server'
recipe 'arcgis-enterprise::install_server', 'Installs ArcGIS Server'
recipe 'arcgis-enterprise::ip-install', 'Installs language packs for ArcGIS Enterprise software'
recipe 'arcgis-enterprise::patches', 'Installs hot fixes and patches for ArcGIS Enterprise software'
recipe 'arcgis-enterprise::portal', 'Installs and configures Portal for ArcGIS on primary machine'
recipe 'arcgis-enterprise::portal_stanby', 'Installs and configures Portal for ArcGIS on standby machine'
recipe 'arcgis-enterprise::portal_wa', 'Installs Web Adaptor and configures it with Portal for ArcGIS'
recipe 'arcgis-enterprise::post_install', 'Executes custom post-installation script if it exists.'
recipe 'arcgis-enterprise::remove_datastore_machine', 'Removes machine from ArcGIS Data Store'
recipe 'arcgis-enterprise::server', 'Installs and configures ArcGIS Server'
recipe 'arcgis-enterprise::server_data_items', 'Registers data items with ArcGIS Server.'
recipe 'arcgis-enterprise::server_node', 'Installs ArcGIS Server on the machine and joins an existing site'
recipe 'arcgis-enterprise::server_security', 'Configures ArcGIS Server identity stores and assigns privileges to roles.'
recipe 'arcgis-enterprise::server_wa', 'Installs Web Adaptor and configures it with ArcGIS Server'
recipe 'arcgis-enterprise::services', 'Publishes services to ArcGIS Server'
recipe 'arcgis-enterprise::start_datastore', 'Starts ArcGIS Data Store on the machine'
recipe 'arcgis-enterprise::start_portal', 'Starts Portal for ArcGIS on the machine'
recipe 'arcgis-enterprise::start_server', 'Starts ArcGIS Server on the machine'
recipe 'arcgis-enterprise::stop_datastore', 'Stops ArcGIS Data Store on the machine'
recipe 'arcgis-enterprise::stop_portal', 'Stops Portal for ArcGIS on the machine'
recipe 'arcgis-enterprise::stop_server', 'Stops ArcGIS Server on the machine'
recipe 'arcgis-enterprise::stop_machine', 'Stops server machine in the ArcGIS Server site'
recipe 'arcgis-enterprise::system', 'System requirements'
recipe 'arcgis-enterprise::unfederate_server', 'Unfederates server from Portal for ArcGIS'
recipe 'arcgis-enterprise::unregister_machine', 'Unregisters server machine from the ArcGIS Server site'
recipe 'arcgis-enterprise::unregister_machines', 'Unregisters from the ArcGIS Server site all the server machines except for the local machine'
recipe 'arcgis-enterprise::unregister_stopped_machines', 'Unregisters all unavailable server machines in \'default\' cluster from the ArcGIS Server site'
recipe 'arcgis-enterprise::unregister_server_wa', 'Unregisters all ArcGIS Server Web Adaptors'
recipe 'arcgis-enterprise::webstyles', 'Installs Portal for ArcGIS Web Styles'

issues_url 'https://github.com/Esri/arcgis-cookbook/issues' if respond_to?(:issues_url)
source_url 'https://github.com/Esri/arcgis-cookbook' if respond_to?(:source_url)
