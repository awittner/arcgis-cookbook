# arcgis-mission-server Deployment Template

The template contains Chef Zero JSON files with sample recipes and attributes for different ArcGIS Mission Server machine roles.

## System Requirements

Consult the ArcGIS Mission Server 10.9 system requirements documentation for the required/recommended hardware specification.

### Recommended Chef Client Versions

* Chef Client 16, or
* Cinc Client 16

### Recommended ArcGIS Chef Cookbooks versions

* 3.8.0

### Supported Platforms

* Windows
  * Windows Server 2016 Standard and Datacenter
  * Windows Server 2019 Standard and Datacenter
  * Windows Server 2022 Standard and Datacenter
* Linux
  * Ubuntu Server 18.04 LTS
  * Ubuntu Server 20.04 LTS
  * Red Hat Enterprise Linux Server 7
  * Red Hat Enterprise Linux Server 8
  * CentOS Linux 7
  * CentOS Linux 8

Enable running sudo without password for the user running the Chef client.

### Required ArcGIS Software Repository Content

The following ArcGIS setup archives must be available in the ArcGIS software repository directory for both initial deployments and upgrades:

Windows

* ArcGIS_Mission_Server_Windows_1091_180092.exe

Linux

* ArcGIS_Mission_Server_Linux_1091_180227.tar.gz

> ArcGIS software repository directory is specified by arcgis.repository.archives attribute. By default it is set to local directory C:\Software\Archives on Windows and /opt/software/archives on Linux. However, it is recommended to create an ArcGIS software repository located on a separate file server that is accessible from all the machines in the deployment for the user account used to run Chef client.

> Ensure that the directory specified by arcgis.repository.setups attribute has enough space for setups extracted from the setup archives.

## Initial Deployment Workflow

The recommended initial deployment workflow for the template machine roles:

1. Install the recommended version of [Chef Client](https://docs.chef.io/chef_install_script/) or [Cinc Client](https://cinc.sh/start/client/).
2. Download and extract [ArcGIS Chef cookbooks](https://github.com/Esri/arcgis-cookbook/releases) into the Chef workspace directory.
3. Update the required attributes within the template JSON files.
4. Run Chef client on machines as administrator/superuser using the json files specific to the machine roles (one machine can be used in multiple roles).

> For additional customization options see the list of supported attributes described in arcgis-mission cookbook README file.

### File Server Machine

```shell
chef-client -z -j mission-server-fileserver.json
```

### First ArcGIS Mission Server Machine

```shell
chef-client -z -j mission-server.json
```

### Additional ArcGIS Mission Server Machines

```shell
chef-client -z -j mission-server-node.json
```

After all the server machines are configured federate ArcGIS Mission Server with Portal for ArcGIS.

```
chef-client -z -j mission-server-federation.json
```

### ArcGIS Web Adaptor Machine

If ArcGIS Web Adaptor is required, use arcgis-webadaptor deployment template to install and configure it.

## Upgrade Workflow

> It's not recommended to use the templates for upgrades if the sites were not initially deployed using the templates.

To upgrade ArcGIS Mission Server deployed using arcgis-mission-server deployment template to 10.9.1 version you will need:

* ArcGIS Mission Server 10.9.1 setup archive,
* ArcGIS Web Adaptor 10.9.1 setup archive, if Web Adaptors were installed in the initial deployment,
* ArcGIS Mission Server 10.9 software authorization file,
* The original JSON files used for the initial deployment or the last upgrade.

### General Upgrade Notes

Upgrade of ArcGIS Mission Server deployment may take several hours, during that time the server will be unavailable to the users.

Before you upgrade, it's recommended that you make backups of your deployment. To prevent operating system updates during the upgrade process it's recommended to install all the recommended/required OS updates before upgrading ArcGIS Mission Server.

The attributes defined in the upgrade JSONs files must match the actual deployment configuration. To make upgrade JSON files, update the 10.9.1 template JSON files by copying the attribute values from the JSON files used for the initial deployment or the last upgrade.

> In some cases the difference between the original and the new deployment template JSON files will be just in the value of arcgis.version attribute. In those cases the easiest way to make the upgrade JSON files is just to change arcgis.version attribute values to the new version. But the new deployment templates might change recipes in the run_list, add new attributes, and introduce other significant changes. To keep the upgrade JSON files in sync with the new deployment templates version it's recommended to update the new deployment templates instead of the original JSON files.

Tool copy_attributes.rb can be used to copy attributes values from one JSON file to another. The tool copies only attibutes present in the destination template JSON file. The tool is located in templates/tools directory in the ArcGIS cookbooks archive. To execute copy_attributes.rb use chef-apply command that comes with Chef/Cinc Client.

```shell
chef-apply ./templates/tools/copy_attributes.rb <source JSON file path> <destination template JSON file path>
```

After executing the tool, update the destination JSON file attributes specific to the new JSON file template and attributes specific to the new ArcGIS Mission Server version, such as software authorization files.

On each deployment machine, before upgrading the ArcGIS Enterprise software, upgrade the configuration management subsystem components:

1. Backup the original JSON files used for the initial deployment or the last upgrade into a local directory.
2. Upgrade [Chef Client](https://docs.chef.io/chef_install_script/) or [Cinc Client](https://cinc.sh/start/client/) to the recommended version.
3. Empty the Chef/Cinc workspace directory.
4. Download and extract the recommended version of [ArcGIS Chef cookbooks](https://github.com/Esri/arcgis-cookbook/releases) into the Chef/Cinc workspace directory.

### Upgrade from 10.8 or 10.8.1

Upgrading ArcGIS Mission Server deployments to 10.9.1 requires upgrading all ArcGIS Mission Server machines.

> Note that in 10.9.1 ArcGIS Web Adaptor is installed using new arcgis-webadaptor deployment template.

1. Upgrade first ArcGIS Mission Server machine
  
   Copy attributes from the original `mission-server-primary.json` JSON file created from 10.8/10.8.1 arcgis-mission-server template to `mission-server.json` of 10.9.1 arcgis-mission-server template.

   ```shell
   chef-apply ./templates/tools/copy_attributes.rb <original JSON files>/mission-server-primary.json <arcgis-mission-server 10.9.1 template>/mission-server.json
   ```

   Verify that attributes are correct in `mission-server.json`.

   On the ArcGIS Mission Server machine execute the following command:

   ```shell
   chef-client -z -j <arcgis-mission-server 10.9.1 template>/mission-server.json
   ```

2. Upgrade ArcGIS Mission Server Web Adaptor

   Copy attributes from the original `mission-server-primary.json` JSON file created from 10.8/10.8.1 arcgis-mission-server template to `arcgis-mission-server-webadaptor.json` of 10.9.1 arcgis-webadaptor template.

   ```shell
   chef-apply ./templates/tools/copy_attributes.rb <original JSON files>/mission-server-primary.json <arcgis-webadaptor 10.9.1 template>/arcgis-mission-server-webadaptor.json
   ```

   Verify that attributes are correct in `arcgis-mission-server-webadaptor.json`.

   Execute the following command on the ArcGIS Mission Server machine to upgrade ArcGIS Web Adaptor:

   ```shell
   chef-client -z -j <arcgis-webadaptor 10.9.1 template>/arcgis-mission-server-webadaptor.json
   ```

### Upgrade from 10.9

Upgrading ArcGIS Mission Server deployments from 10.9 to 10.9.1 requires upgrading all ArcGIS Mission Server machines. The file server machine does not require any changes.

> Note that in 10.9.1 ArcGIS Web Adaptor is installed using new arcgis-webadaptor deployment template.

1. Upgrade first ArcGIS Mission Server machine
  
   Copy attributes from the original `mission-server.json` JSON file created from 10.9 arcgis-mission-server template to `mission-server.json` of 10.9.1 arcgis-mission-server template.

   ```shell
   chef-apply ./templates/tools/copy_attributes.rb <original 10.9 JSON files>/mission-server.json <arcgis-mission-server 10.9.1 template>/mission-server.json
   ```

   Verify that attributes are correct in `mission-server.json`.

   On the first ArcGIS Server machine execute the following command:

   ```shell
   chef-client -z -j <arcgis-mission-server 10.9.1 template>/mission-server.json
   ```

2. Upgrade additional ArcGIS Mission Server machines

   Copy attributes from the original `mission-server-node.json` JSON file created from 10.9 arcgis-mission-server template to `mission-server-node.json` of 10.9.1 arcgis-mission-server template.

   ```shell
   chef-apply ./templates/tools/copy_attributes.rb <original 10.9 JSON files>/mission-server-node.json <arcgis-server 10.9.1 template>/mission-server-node.json
   ```

   Verify that attributes are correct in `mission-server-node.json`.

   On each additional ArcGIS Mission Server machine execute the following command to upgrade ArcGIS Mission Server:

   ```shell
   chef-client -z -j <arcgis-server 10.9.1 template>/mission-server-node.json
   ```

3. Upgrade ArcGIS Mission Server Web Adaptors

   Copy attributes from the original `mission-server-webadaptor.json` JSON file created from 10.9 arcgis-mission-server template to `arcgis-mission-server-webadaptor.json` of 10.9.1 arcgis-webadaptor template.

   ```shell
   chef-apply ./templates/tools/copy_attributes.rb <original 10.9 JSON files>/mission-server-webadaptor.json <arcgis-webadaptor 10.9.1 template>/arcgis-mission-server-webadaptor.json
   ```

   Verify that attributes are correct in `arcgis-mission-server-webadaptor.json`.

   On each ArcGIS Mission Server Web Adaptor machine execute the following command to upgrade ArcGIS Web Adaptor:

   ```shell
   chef-client -z -j <arcgis-webadaptor 10.9.1 template>/arcgis-mission-server-webadaptor.json
   ```

## Machine Roles

The JSON files included in the template provide recipes for the deployment machine roles and the most important attributes used by the recipes.  

### mission-server-fileserver

Installs NFS and configures shares for ArcGIS Mission Server config store and server directories.

Required attributes changes:

* arcgis.run_as_password - (Windows only) password of 'arcgis' windows user account

### mission-sever-install

Installs ArcGIS Mission Server without authorizing or configuring it.

Required attributes changes:

* arcgis.run_as_password - (Windows only) password of 'arcgis' windows user account

### mission-server

Installs ArcGIS Mission Server, authorizes the software, and creates site.

Required attributes changes:

* arcgis.run_as_password - (Windows only) password of 'arcgis' windows user account
* arcgis.mission_server.admin_username - Specify primary site administrator account user name.
* arcgis.mission_server.admin_password - Specify primary site administrator account password.
* arcgis.mission_server.authorization_file - Specify path to the ArcGIS Mission Server role software authorization file.
* arcgis.mission_server.directories_root - Replace 'FILESERVER' by the file server machine hostname or static IP address.
* arcgis.mission_server.config_store_connection_string - Replace 'FILESERVER' by the file server machine hostname or static IP address.

### mission-server-node

Installs ArcGIS Mission Server, authorizes the software, and joins the machine to existing site.

Required attributes changes:

* arcgis.run_as_password - (Windows only) password of 'arcgis' windows user account
* arcgis.mission_server.admin_username - Specify primary site administrator account user name.
* arcgis.mission_server.admin_password - Specify primary site administrator account password.
* arcgis.mission_server.authorization_file - Specify path to the ArcGIS Mission Server role software authorization file.
* arcgis.server.primary_server_url - Specify URL of the ArcGIS Mission Server site to join.

### mission-server-unregister-machine

* Unregisters the machine form ArcGIS Mission Server site.

### mission-server-federation

* Federates ArcGIS Mission Server with Portal for ArcGIS and enables MissionServer role.

Required attributes changes:

* arcgis.mission_server.admin_username - Specify ArcGIS Server primary site administrator account user name.
* arcgis.mission_server.admin_password- Specify ArcGIS Server primary site administrator account password.
* arcgis.mission_server.private_url - Specify ArcGIS Server private URL that will be used as the admin URL during federation.
* arcgis.mission_server.web_context_url - Specify ArcGIS Server Web Context URL that be used as the services URL during federation..
* arcgis.portal.admin_username - Specify Portal for ArcGIS administrator user name.
* arcgis.portal.admin_password - Specify Portal for ArcGIS administrator password.
* arcgis.portal.private_url - Specify Portal for ArcGIS private URL.

### mission-server-s3files

The role downloads ArcGIS Mission Server setups archives from S3 bucket specified by arcgis.repository.server.s3bucket attribute to the local ArcGIS software repository.

The role requires AWS Tools for PowerShell to be installed on Windows machines and AWS Command Line Interface on Linux machines.  

The following attributes are required unless the machine is an AWS EC2 instance with a configured IAM Role:

* arcgis.repository.server.aws_access_key - AWS account access key id
* arcgis.repository.server.aws_secret_access_key - AWS account secret access key
