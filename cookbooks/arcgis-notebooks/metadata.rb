name 'arcgis-notebooks'
maintainer 'Esri'
maintainer_email 'contracts@esri.com'
license 'Apache-2.0'
description 'Installs/Configures ArcGIS Notebook Server'
long_description 'Installs/Configures ArcGIS Notebook Server'
version '3.8.0'
chef_version '>= 13.0' if defined? chef_version

depends          'arcgis-enterprise', '~> 3.8'
depends          'arcgis-repository', '~> 3.8'
depends          'docker', '~> 4.9'
depends          'iptables', '~> 7.1'

supports         'ubuntu'
supports         'redhat'
supports         'centos'
supports         'oracle'
supports         'suse'
supports         'windows'

recipe 'arcgis-notebooks::default', 'Installs and configures ArcGIS Notebook Server'
recipe 'arcgis-notebooks::docker', 'Installs Docker engine'
recipe 'arcgis-notebooks::federation', 'Federates ArcGIS Notebook Server with Portal for ArcGIS and enables NotebookServer role'
recipe 'arcgis-notebooks::fileserver', 'Configures shared directories for ArcGIS Notebook Server on file server machine'
recipe 'arcgis-notebooks::install_server', 'Installs ArcGIS Notebook Server'
recipe 'arcgis-notebooks::install_server_wa', 'Installs ArcGIS Web Adaptor for ArcGIS Notebook Server'
recipe 'arcgis-notebooks::iptables', 'Reject Docker containers access to EC2 instance metadata IP address'
recipe 'arcgis-notebooks::samples_data', 'Installs ArcGIS Notebook Server Samples Data'
recipe 'arcgis-notebooks::server', 'Installs and configures ArcGIS Notebook Server'
recipe 'arcgis-notebooks::server_node', 'Joins additional machines to an ArcGIS Notebook Server site'
recipe 'arcgis-notebooks::server_wa', 'Installs and configures ArcGIS Web Adaptor for ArcGIS Notebook Server'
recipe 'arcgis-notebooks::uninstall_server', 'Uninstalls ArcGIS Notebook Server'
recipe 'arcgis-notebooks::uninstall_server_wa', 'Uninstalls ArcGIS Web Adaptor for ArcGIS Notebook Server'
recipe 'arcgis-notebooks::unregister_machine', 'Unregisters server machine from the ArcGIS Notebook Server site'
recipe 'arcgis-notebooks::unregister_server_wa', 'Unregisters all ArcGIS Notebook Server Web Adaptors'

issues_url 'https://github.com/Esri/arcgis-cookbook/issues' if respond_to?(:issues_url)
source_url 'https://github.com/Esri/arcgis-cookbook' if respond_to?(:source_url)
