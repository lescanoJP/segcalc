# segcalc

## Dependências

- Ruby v3.0.0
- Rails v7.1.3
- MySQL v8.0.26-0

# Atualizando gems

Para atualizar as gems do projeto vamos usar a gem chamada `bundler`

Para instala-la execute o comando no seu terminal:

```bash
gem install bundler
```

Logo em seguida, execute o seguinte comando:

```bash
bundle
```
# Configuração do database.yml

Primeiramente é necessário criar o arquivo para 0 banco de dados criando o arquivo abaixo:
`config/database.yml`

Cole nele o seguinte contéudo:

```
default: &default
  adapter: mysql2
  encoding: utf8mb4
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: nome-do-seu-usuario-do-bd
  password: sua-senha-do-bd
  host: localhost

development:
  <<: *default
  database: segcalc_development

test:
  <<: *default
  database: segcalc_test
```

Depois de feito isso, rode no seu console o seguinte comando:

```bash
rails db:create db:migrate
```

# Testes
Os testes da aplicação foram feitos usando Cucumber

Para executar os testes, rode no seu console o seguinte comando:

```bash
cucumber
```