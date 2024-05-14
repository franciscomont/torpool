[![Docker Pulls](https://img.shields.io/docker/cloud/build/u1234x1234/torpool.svg?style=flat-square)](https://hub.docker.com/r/u1234x1234/torpool/)
[![Size](https://images.microbadger.com/badges/image/u1234x1234/torpool.svg)](https://hub.docker.com/r/u1234x1234/torpool/)

# torpool

🇧🇷 Um conjunto de contêineres com múltiplas instâncias do Tor, oferecendo balanceamento de carga e proxy HTTP.

## Recursos Principais

- Múltiplas instâncias do Tor com um único ponto de acesso para o usuário final
- Configuração fácil (rotação de IP, seleção de país para o nó de saída, etc.)
- Imagem Docker leve baseada no Alpine
- Proxy HTTP com Privoxy
- Balanceamento de carga HTTP/Socks com HAProxy
- Não utiliza o usuário root dentro do Docker

🇺🇸 A containerized pool of multiple Tor instances offering load balancing and HTTP proxy.

## Key Features

- Multiple Tor instances with a single endpoint for end-users
- Easy configuration (IP rotation, country selection for exit node, etc.)
- Lightweight Alpine-based Docker image
- HTTP proxy with Privoxy
- HTTP/Socks load balancing with HAProxy
- Does not use the root user inside Docker
```
              +-----------------------------------------------+           
              | Docker                                        |           
              |                                               |           
              |                   +-------+            +----+ |           
              |                   |Privoxy|------------|Tor1| |           
              |                   +-------+        |   +----+ |           
+------+      | +-------+         +-------+        |   +----+ |           
|Client|--------|Haproxy|-------- |Privoxy|--------|---|Tor2| |           
+------+      | +-------+         +-------+        |   +----+ |           
              |     |             +-------+        |   +----+ |           
              |     |             |Privoxy|--------|---|Tor3| |           
              |     |             +-------+        |   +----+ |           
              |     |                              |          |           
              |     |                              |          |           
              |     +------------------------------+          |           
              |                                               |           
              +-----------------------------------------------+           
```
### 🇧🇷 Como utilizar?

1. **Instalação do Docker:**
   Antes de tudo, é necessário realizar a instalação do Docker. Você pode encontrar instruções detalhadas em [Instalação do Docker](https://docs.docker.com/engine/install/).

2. **Clonar o repositório:**
   Utilize o comando `git clone` para copiar o repositório do torpool:
   ```bash
   git clone https://github.com/franciscomont/torpool
   ```

4. **Definir usuário / senha para o haproxy:**
   Caso deseje, defina o usuário no arquivo `haproxy_username`.
   ```bash
   nano haproxy_username
   ```

   Caso deseje, defina a senha no arquivo `haproxy_password`.
   ```bash
   nano haproxy_password
   ```

6. **Criar a imagem Docker:**
   Após clonar o repositório e, se necessário, definir a senha do `haproxy_password`, crie a imagem Docker utilizando o comando:
   ```bash
   docker build -t torpool .
   ```

# Uso

Inicie 5 instâncias do Tor:
```bash
docker run -d -p 9200:9200 -p 9300:9300 torpool --Tors=5
```

O proxy HTTP é acessível na porta 9300:
```bash
curl --proxy localhost:9300 http://ipinfo.io/ip
```
O Socks é acessível na porta 9200:
```bash
curl --socks5 localhost:9200 http://ipinfo.io/ip
```

Para fazer as instâncias do Tor rotacionarem:
```bash
docker run -d -p 9200:9200 -p 9300:9300 torpool --MaxCircuitDirtiness 30 --NewCircuitPeriod 30
```
Use apenas nós de saída dos EUA:
```bash
docker run -d -p 9200:9200 -p 9300:9300 torpool --ExitNodes {us}
```
[List of available Tor options](https://www.torproject.org/docs/tor-manual.html.en)


```
Para acessar o HAProxy, abra o navegador e vá para http://localhost:9500/haproxy_stats. Em seguida, insira o nome de usuário e senha. O nome de usuário padrão é `haproxy`, a senha está em branco por padrão.
```

# Gostaria de expressar meu sincero agradecimento ao u1234x1234 pelo incrível projeto original torpool.

### 🇺🇸 How to Use?

1. **Install Docker:**
   First of all, you need to install Docker. You can find detailed instructions at [Docker Installation](https://docs.docker.com/engine/install/).

2. **Clone the Repository:**
   Use the `git clone` command to copy the torpool repository:
   ```bash
   git clone https://github.com/franciscomont/torpool
   ```

4. **Set username/password for haproxy:**
   If desired, set the username in the `haproxy_username` file.
   ```bash
   nano haproxy_username
   ```

   If desired, set the password in the `haproxy_password` file.
   ```bash
   nano haproxy_password
   ```

6. **Build the Docker Image:**
   After cloning the repository and, if necessary, setting the `haproxy_password`, build the Docker image using the command:
   ```bash
   docker build -t torpool .
   ```

# Usage

Start 5 Tor instances:
```bash
docker run -d -p 9200:9200 -p 9300:9300 torpool --Tors=5
```

The HTTP proxy is accessible on port 9300:
```bash
curl --proxy localhost:9300 http://ipinfo.io/ip
```
The Socks proxy is accessible on port 9200:
```bash
curl --socks5 localhost:9200 http://ipinfo.io/ip
```

To make the Tor instances rotate:
```bash
docker run -d -p 9200:9200 -p 9300:9300 torpool --MaxCircuitDirtiness 30 --NewCircuitPeriod 30
```
Use only US exit nodes:
```bash
docker run -d -p 9200:9200 -p 9300:9300 torpool --ExitNodes {us}
```
[List of available Tor options](https://www.torproject.org/docs/tor-manual.html.en)


```
To access the HAProxy, open your browser and go to http://localhost:9500/haproxy_stats. Then, enter the username and password. The default username is `haproxy` and the password is left blank by default.
```

# I would like to express my sincere gratitude to u1234x1234 for the incredible original project torpool.

# Why

There is a lot of great projects on github, but non of them provides all the options listed above. Some of them:

* https://github.com/trimstray/multitor
* https://github.com/evait-security/docker-multitor
* https://github.com/zet4/alpine-tor
* https://github.com/rdsubhas/docker-tor-privoxy-alpine
* https://github.com/Negashev/docker-haproxy-tor
* https://github.com/marcelmaatkamp/docker-alpine-tor
* https://github.com/mattes/rotating-proxy
* https://github.com/srounet/docker-tor
* https://github.com/dperson/torproxy
* https://github.com/srounet/docker-tor
