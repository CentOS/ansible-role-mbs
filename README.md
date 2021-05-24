## Ansible Role: mbs
This mbs role is used in the CentOS Infra. ( mbs.stream.rdu2.redhat.com )

Based off of https://pagure.io/fedora-infra/ansible/blob/main/f/roles/mbs/common
etc.

It surely depends (see dependencies below) on some other roles.

See also [ansible-infra-playbooks](https://github.com/CentOS/ansible-infra-playbooks) directory to see how the tree/structure is organized

### Variables
See [defaults variables and explanations](defaults/main.yml)

```
mbs_env: mbs environment, it will try to inherit the value from "centos_infra_env", valud choices: dev, stg and prod.
mbs_import_default_modules: boolean flag to import modules from a local dir
mbs_upgrade_db: boolean flag which defines if `mbs-manager upgrade db` should run during instllation
mbs_num_workers: number of mbs workers added as systemd service
mbs_celery_max_worker_tasks: max of tasks that can be executed per worker
mbs_default_modules_dir: local module dir to import modules from (yaml files)
# postgresql
mbs_postgres_local: boolean flag to determine if mbs role needs to install psql using centos postgresql role
mbs_postgres_hostname: postgresql hostname
mbs_postgres_username: postgresql username
mbs_postgres_password: postgresql password
mbs_postgres_database: potsgresql database
# rabbitmq
rabbitmq_local: boolean flag that wll install a local rabbitmq instance if set to true 
rabbitmq_vhost: rabbitmq vhost to use or create
rabbitmq_username: rabbitmq username to use or create
rabbitmq_password: rabbitmq password to use or create
# kojihub
kojihub_top_url: koji base url
kojihub_use_fast_upload: bool flag to enable/disable koji fast upload mode
kojihub_auth_type: koji authentication type
kojihub_kerberos_rdns: bool flag to enable/disable koji kerberos rdns
#mbs config.py
mbs_config_broker_url: celery broker url to use, defaults to local rabbitmq instance
mbs_config_debug: bool flag that enables/disables mbs debug mode
mbs_config_secret_key: random string to be used by mbs frontend
mbs_config_database_url: mbs postgresql url, it is formed by psql vars: "postgresql://{{ mbs_postgres_username }}:{{ mbs_postgres_password }}@{{ mbs_postgres_hostname }}/{{ mbs_postgres_database }}"
mbs_config_system: mbs build system, defaults to "koji"
mbs_config_messaging: mbs messaging backend type, defaults to "fedmsg"
mbs_config_messaging_topic_prefix: 'org.centos.mbs' #
mbs_config_koji_file: path to the mbs koji conf file, defaulta to  /etc/module-build-service/koji.conf
mbs_config_koji_profile: mbs koji profile to use, defaults to "koji"
mbs_config_arches: a list of supported archs by this mbs instance
mbs_config_koji_proxy_user: boolean flag to tell if mbs needs to proxy mbs username to koji
mbs_config_koji_repository_url: koji repos url
mbs_config_scm_urls: a list of allowed git urls for mbs to pull modules from
mbs_config_polling_interval: mbs polling interval for mbs-poller
mbs_config_default_repository_url: mbs defautl rpm repositories url
mbs_config_allow_rpm_repository: boolean flag to allow rpm repository
mbs_config_rpm_default_cache_url: mbs default rpm cache url
mbs_config_rpm_allow_cache: boolean flag to allow rpm cache
mbs_config_modules_repository_url: 'git+https://src.fedoraproject.org/modules/'
mbs_config_modules_allow_repository: false
mbs_config_log_backend: mbs log backend, defaults to "file"
mbs_config_log_file: mbs log file path, defaults to "/var/log/mbs/module_build_service.log"
mbs_config_log_level: mbs log level, defaults to "info"
mbs_config_logs_build_dir: directory which mbs stores build logs, defaults to /var/tmp
mbs_config_krb_keytab: mbs backend kerberos keytab config
mbs_config_krb_principal: mbs backend kerberos principal
mbs_config_krb_cache: mbs backend kerberos cache
mbs_config_allowed_groups: list of allowed groups to build a moduke
mbs_config_admin_groups: list of admin groups
mbs_config_rebuild_strategy: mbs rebuild strategy, defaults to only-changed
mbs_config_rebuild_strategy_override: boolean flag to enable/disable a user to override the rebuild strategy type 
mbs_config_base_module_names: a list of base module names
mbs_config_koji_build_tag: modular-updates-candidate
mbs_config_koji_tag_prefixes: a list of koji tag prefixes to be used by mbs
mbs_config_koji_tag_extra_opts: extra options set for newly created Koji tags
mbs_config_dist_tag_prefix: mbs koji dist tag preffix to use
mbs_config_koji_delete_time: interval (seconds) to delete module-* targets 
mbs_config_no_auth: boolean flag to enable/disable authentication for mbs end users, defaults to false
mbs_config_yaml_allowed: bool flag to enable/disable direct yaml submission
mbs_config_build_priority: mbs koji build priority to use, defaults to 0
mbs_config_koji_devel_module: bool flag to enable/disable devel modules
mbs_config_modules_allow_scratch: boolean flag to allow scratch builds in mbs
mbs_config_modules_only_compatible: bool flag to enable/disable build requires that are from different platforms, defaults to false
# frontend
mbs_wsgi_procs: max of mbs wsgi processes per thread, defaults to 1
mbs_wsgi_threads: max of mbs frontend wsgi threads, default to 1
mbs_wsgi_log_level: mbs frontend log level, defaults to "DEBUG"
mbs_scheduler_consumer: false
mbs_scheduler_poller: false
mbs_frontend_host: mbs frontend host to be used as "ServerName" in apache
mbs_frontend_https_enabled: bool flag to enable/disable https connections
mbs_frontend_https_port: bs frontend http port, defaults to 443
mbs_frontend_cert_path: apache https cert path
mbs_frontend_key_path: apache https key path
mbs_frontend_ca_path: apache https ca path
mbs_frontend_http_enabled: bool flag to enable/disable http connections
mbs_frontend_http_port: mbs frontend http port, defaults to 80
mbs_frontend_keytab: mbs frontend kerberos keytab, used in apache
```

### Dependencies

This role depends on an existing postgresql instance + fedmsg-hub.

All those roles are declared in our [requirements.yml](https://github.com/CentOS/ansible-infra-playbooks/blob/master/requirements-production.yml) file.

### Development

Molecule tests use vagrant so you need a working vagrant installation in your host machine.

Running molecule tests require the following python libraries:

- molecule
- molecule-vagrant
- python-vagrant

Tests can be executed by running:

```sh
molecule test
```

### License
MIT (see [LICENSE](LICENSE) file)

