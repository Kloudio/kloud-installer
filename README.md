# kloud-installer
The external facing mirror for `kloudio/installer`

## Installation
To install the `kloud-installer` binary you need to run `install.sh` or the following:

```bash
curl -o- https://raw.githubusercontent.com/kloudio/kloud-installer/master/install.sh | sudo sh
```

For specific version:
```bash
curl -o- https://raw.githubusercontent.com/kloudio/kloud-installer/{{version}}/install.sh | sudo sh

```

Or using, `wget`:
```bash
wget -qO- https://raw.githubusercontent.com/kloudio/kloud-installer/{{version}}/install.sh | sudo sh

```

## Usage 
You can always use the `--help` to try to get more information.

```bash
➜ kloud-installer --help 
A set of tools for Kloudio.

Usage:
  kloud-installer [command]

Available Commands:
  help        Help about any command
  install     
  list        list a resource
  version     output the version

Flags:
  -h, --help   help for kloud-installer

Use "kloud-installer [command] --help" for more information about a command.
```

### Listing Services
To list the services that are included with this installer you can run the following:
```bash
➜ kloud-installer list services
db_migrations
frontend
backend
intg_jobs
jobs
integrations
destination_service
usage_analytics
crongjobs
```

### Complete Enterprise Installation
To set up a new enterprise, run the following:
```sh
sudo ./kloud-installer install enterprise \
  --flavor <flavor> \
  --license <license>
```

Optionally, supply the `database` flag to configure a seperate database:
```sh
sudo ./kloud-installer install enterprise \
  --flavor <flavor> \
  --license <license> \
  --database='{"host":"host","port":5432,"database":"kloudio","username":"kloudio","password":"rainbow"}'
```
If not provided, a postgres container will be loaded next to the installation.

Supply the `cleanup=false` flag to keep installation files around.
```sh
sudo ./kloud-installer install enterprise \
  --flavor <flavor> \
  --license <license> \
  --cleanup=false
```

Supply the `verbose=true` and `debug=true` flag for more output.
```sh
sudo ./kloud-installer install enterprise \
  --flavor <flavor> \
  --license <license> \
  --verbose=true \
  --debug=true
```

Supply the `skip-services` flag to skip installing a service.
```sh
sudo ./kloud-installer install enterprise \
  --flavor <flavor> \
  --license <license> \
  --skip=services=backend
```

### Specific Service Installation
To install a specific service, run the following.
```sh
sudo ./kloud-installer install <service-name> \
  --flavor <flavor> \
  --license <license> \
```

**Note: If you're install across multiple instances, please make sure the configurations point to the proper place.**
