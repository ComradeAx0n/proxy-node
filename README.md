# Linode IPv6 proxy server

## Описание

Создание инстансов и дальнейшая настройка прокси на ней

## Инструкция

1. Подготовить окружение.
2. terraform apply
3. После создания ноды, зайти в настройки созданной ноды в веб-интерфейсе linode. Во вкладке Network нажимаем Add an IP Address, выбираем в IPv6 prefix /56 и жмем Allocate.
4. Делаем export переменных, где IP_ADDRESS - ip созданной ноды, IPV6_SUBNET - подсеть IPv6, которую получили в веб интерфейсе.
```export IP_ADDRESS=66.175.212.197 IPV6_SUBNET=2600:3c03:e001:1b00::/56```
5. Запускаем провижен ansible
```ansible-galaxy install -r ./ansible/requirements.yml && ansible-playbook -u root -i '$IP_ADDRESS,' --private-key ./keys/prvkey -e 'ipv6_subnet_full=$IPV6_SUBNET' ./ansible/main.yml```

## Проблемы

### IPv6

1. IPv6 range не удалось запустить в регионе Atlanta us-central (вроде). Заработал в регионе Newark, NJ us-east
2. Через terraform нет возможности добавлять ipv6/range, приходится руками добавлять.

## Requirements

1. Terraform v1.0.10
2. ansible [core 2.11.6]
3. Python 3.8.10

## TODO

Добавить в /lib/systemd/system/squid.service TimeoutSec=900
https://unix.stackexchange.com/questions/227017/how-to-change-systemd-service-timeout-value 