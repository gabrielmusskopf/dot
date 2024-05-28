# Ansible Scripts

Scripts para facilitar a instalação de ferramentas que uso no dia a dia. 

## Quickstart

Para executar scripts, é necessário ter o `ansible-core`. Para instalar, pelo menos até o executar o script do [asdf](./02-asdf.yml), é preciso intalar o pipx:

```shell
sudo apt update && sudo apt install pipx
```

Após isso, basta instalar o `ansible-core` e meter bala nos scripts:

```shell
pipx install ansible-core
```

## Usage

Para cada script, executar

```shell
ansible-playbook -vv --ask-become-pass --user <username> <playbook>.yml
```
