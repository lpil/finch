Finch
=====

A nimble content API!

[![Build Status](https://travis-ci.org/lpil/finch.svg?branch=master)](https://travis-ci.org/lpil/finch)

## Setup

```sh
# Install Elixir deps
mix deps.get
# Install Javascript deps
npm install

# Create and migrate database
mix ecto.create
mix ecto.migrate

# Run the server
mix phoenix.server
```

You may need to ensure the `postgres` database user has the password
`postgres`, and that they have the required permissions.

```sql
CREATE ROLE postgres LOGIN;
```
