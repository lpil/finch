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

## Notes

* [Writing a Phoenix blog 1][blog-1]
* [Writing a Phoenix blog 2][blog-2]
* [Testing Validation][testing-validations]

[testing-validations]: https://medium.com/@diamondgfx/testing-validations-in-elixir-and-ecto-677bd8a071a1
[blog-1]: https://medium.com/@diamondgfx/introduction-fe138ac6079d
[blog-2]: https://medium.com/@diamondgfx/writing-a-blog-engine-in-phoenix-part-2-authorization-814c06fa7c0
