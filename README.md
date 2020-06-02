# kloud-installer
The enmterprise installer for :cloud: [kloud.io](https://kloud.io)

**Please note that this tool is in beta. Feel free to contribute by filing issues and bugs [here](https://github.com/Kloudio/kloud-installer/issues).**

## Installation
To install the `kloud-installer` binary you need to run `install.sh` or the following:

```bash
curl -o- https://raw.githubusercontent.com/kloudio/kloud-installer/master/install.sh | sudo sh
```

Verify installation worked
```bash
kloud-installer version
```

## Usage 
To verify your installation worked, run the following:
```bash
kloud-installer version
```

You can always use the `--help` to try to get more information.

```bash
➜ ./kloud-installer --help
A set of tools for Kloudio.

Usage:
  kloud-installer [command]

Available Commands:
  help        Help about any command
  install     Install the whole kloud or just a piece of it
  list        list a resource
  version     Output the version

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

1. Install the CORE services, including backend, clients, and the database on 1 instance.
```sh
sudo kloud-installer install core \
  --license 'license-key' \
  --database '{"host":"<rds-host>","port":5432,"dialect":"postgres","database":"kloudio","username":"kloudio","password":"<rsd-password>"}' \
  --host 'http://<ec2-host>'
```

2. Install the other services on the second instances.
```sh
sudo kloud-installer install \
  --license 'license-key' \
  --database '{"host":"<rds-host>","port":5432,"dialect":"postgres","database":"kloudio","username":"kloudio","password":"<rsd-password>"}' \
  --host 'http://<ec2-host>'
```

#### Optional Arguments
Supply the `cleanup=false` flag to keep installation files around.
```sh
sudo kloud-installer install \
  --cleanup=false
```

Supply the `verbose=true` and `debug=true` flag for more output.
```sh
sudo kloud-installer install \
  --verbose=true \
  --debug=true
```
