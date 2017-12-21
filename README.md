[![Build Status](https://travis-ci.org/while-true-do/ansible-role-users.svg?branch=master)](https://travis-ci.org/while-true-do/ansible-role-users)

# Ansible Role: Users
| A role to create/delete users and assign groups.

## Motivation

Having a role to create a bunch of users, defined by variables was mandatory.
Furthermore this role should be used as dependency for other roles, where users are needed.

## Installation

Install from [Ansible Galaxy](https://galaxy.ansible.com/while-true-do/users)

```
ansible-galaxy install while-true-do.users
```

Install from [Github](https://github.com/while-true-do/ansible-role-users)

```
git clone https://github.com/while-true-do/ansible-role-users.git while-true-do.users
```

## Requirements

**Used Modules**

-   [authorized_key_module](http://docs.ansible.com/ansible/latest/authorized_key_module.html)
-   [file_module](http://docs.ansible.com/ansible/latest/file_module.html)
-   [user_module](http://docs.ansible.com/ansible/latest/user_module.html)


## Role Variables

Below you can find the default variables. 

```yaml
wtd_users: []

wtd_users_default_shell: "/bin/bash"
wtd_users_default_home_path: "/home/"
wtd_users_default_state: "present"
wtd_users_default_password_hash: "!!"
wtd_users_default_password_update: "always"

wtd_users_default_system: "no"
wtd_users_default_system_shell: "/sbin/nologin"
wtd_users_default_system_path: "/var/lib/"

wtd_users_default_auth_key_path: ".ssh/"
wtd_users_default_auth_key_exclusive: true
```

## Dependencies

None.

## Example Playbook

You have to generate a hashed password for 'password' below each user item.
For the below example, you have to have passlib installed.

```
# Fedora
sudo dnf install python2-passlib
# CentOS
sudo dnf install python2-passlib
# Debian / Ubuntu
sudo apt get install python-passlib
```

You can generate it. 

```python
python -c "from passlib.hash import sha512_crypt; import getpass; print sha512_crypt.using(rounds=5000).hash(getpass.getpass())"
```

If you want to use multiple ssh keys per user please aggregate them into one file.

Simple Example:

```yaml
- hosts: servers
  roles:
    - { role: while-true-do.users }
  vars:
    wtd_users:
      - name: user01
        password: HASHGOESHERE
      - name: user02
      - name: sysdeamon
        system: yes
```

Advanced Example:

```yaml
- hosts: servers
  roles:
  - { role: while-true-do.users }
  vars:
    wtd_users:
      - name: user01
        state: present
        comment: "Test User 01"
        shell: "/bin/bash"
        home: "/home/custom_path"
        password: HASHGOESHERE
        update_password: "always"
        groups: "wheel,adm"
        keyfile: "~/.ssh/id_rsa.pub"
      - name: user02
        state: absent
      - name: sysdeamon
        system: yes
        keyfile: "~/.deamon/id_rsa.pub"
```

## Testing

This role is currently tested with syntax-checking and linting.
You can find the tests in [./tests](./tests/).

## Contribute / Bugs

Thank you so much for considering to contribute. Every contribution helps us. We are really happy, when somebody is joining the hard work. Please have a look at the links first.

-   [Contribution Guidelines](./docs/CONTRIBUTING.md)
-   [Create an issue or Request](https://github.com/while-true-do/ansible-role-users/issues)
-   [See who was contributing already](https://github.com/while-true-do/ansible-role-users/graphs/contributors)

## License

This work is licensed under a [BSD License](https://opensource.org/licenses/BSD-3-Clause).

## Author Information

Blog: [blog.while-true-do.org](https://blog.while-true-do.org)

Mail: [hello@while-true-do.org](mailto:hello@while-true-do.org)
