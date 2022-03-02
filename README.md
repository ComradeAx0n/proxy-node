# Linode IPv6 proxy server

## Описание

Создание инстансов и дальнейшая настройка прокси на ней

## Инструкция

1. Подготовить окружение.
2. Создать папку в директории terraform с именем учетной записи. Скопировать в нее main.tf из папки Example
3. В веб интерфейсе linode авторизовываемся в учетную запись. Переходим в API Tokens. Создаем Personal Access Tokens, выбираем все права на Read/Write. Полученный токен вписываем значение token в файле main.tf
```token = "123435456"```
4. Изменяем остальные значения по необходимости
5. Переходим в новосозданную папку. Инициализируем terraform, а затем применяем.

``` bash
cd /new/folder
terraform init
terraform apply
```

6. После создания ноды, зайти в настройки созданной ноды в веб-интерфейсе linode. Во вкладке Network нажимаем Add an IP Address, выбираем в IPv6 prefix /56 и жмем Allocate.
7. Делаем export переменных, где IP_ADDRESS - ip созданной ноды, IPV6_SUBNET - подсеть IPv6, которую получили в веб интерфейсе.
```export IP_ADDRESS=66.175.212.197 IPV6_SUBNET=2600:3c03:e001:1b00::/56```
8. Запускаем провижен ansible
```ansible-galaxy install -r ./ansible/requirements.yml && ansible-playbook -u root -i '$IP_ADDRESS,' --private-key ./keys/prvkey -e 'ipv6_subnet_full=$IPV6_SUBNET' ./ansible/main.yml```

### Выбор типа ноды

Для растягивания триал баланса 100$ на 3 месяца использовать ноду shared cpu на 8gb g6-standard-6 ($40/mo).

## Проблемы

1. 04.02.22 почистили все аккаунты

### IPv6

1. IPv6 range не удалось запустить в регионе Atlanta us-central (вроде). Заработал в регионе Newark, NJ us-east
2. Через terraform нет возможности добавлять ipv6/range, приходится руками добавлять.

#### Проверенные регионы, где работают IPv6

1. us-east (USA)
1. ca-central (Canada, Toronto)
1. ap-west (India, Mumbai) - ipv6 заводится долго, сайты могут не отвечать. Примерно через час норм заработало, но еще бы погонять.
1. ap-southeast (Australia, Sydney)
1. ap-south (Singapore, Singapore)
1. ap-northeast (Japan, Tokyo)
1. eu-west (UK, London) - в вебморде пишет, что нужно дать подтверждение. Проверить, не будет ли гасить ноду.
1. eu-central (Germany, Frankfurt) - в вебморде пишет, что нужно дать подтверждение. Проверить, не будет ли гасить ноду.

## Requirements

1. Terraform v1.0.10
2. ansible [core 2.11.6]
3. Python 3.8.10

## TODO

Добавить в /lib/systemd/system/squid.service TimeoutSec=900
<https://unix.stackexchange.com/questions/227017/how-to-change-systemd-service-timeout-value>
