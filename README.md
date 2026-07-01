# Team Generator

Base Rails 8 para organizar peladas, cadastrar atletas e gerar times balanceados por nível técnico.

## Stack

- Ruby on Rails 8.1
- PostgreSQL
- Hotwire com Turbo e Stimulus
- Bootstrap via CDN
- Font Awesome via CDN

## Domínio inicial

- `Athlete`: nome, nível de 0 a 5 e flag de convidado
- `PickupGame`: data, horário, duração e participantes
- `TeamGenerator::BalancedTeamsService`: gera times balanceados e bench

## Setup

```bash
bundle install
bin/rails db:prepare
bin/rails server
```

## Deploy na nuvem

A aplicação já está preparada para rodar em container de produção com PostgreSQL.

Variáveis de ambiente necessárias:

- `RAILS_MASTER_KEY`
- `DATABASE_URL`
- `RAILS_HOSTS` com o domínio público da aplicação, separado por vírgula se houver mais de um
- `APP_HOST` com o domínio principal da aplicação
- `APP_PROTOCOL` normalmente `https`
- `RAILS_LOG_LEVEL`, opcional
- `RAILS_MAX_THREADS`, opcional

O `Dockerfile` já executa `db:prepare` no boot do servidor e a rota `/up` pode ser usada como health check.

Fluxo recomendado:

1. Criar um serviço web em um provedor com suporte a Docker.
2. Conectar um PostgreSQL gerenciado.
3. Publicar a imagem a partir deste repositório.
4. Configurar as variáveis de ambiente acima.
5. Abrir a URL pública do serviço no navegador.

Se quiser, eu posso montar o arquivo específico do provedor que você escolher, como Render, Fly.io ou Railway.

## Rotas principais

- `/` dashboard
- `/athletes`
- `/pickup_games`
- `/team_generator/new`

## Seeds

O arquivo `db/seeds.rb` contém exemplos básicos de atletas para acelerar testes manuais.
