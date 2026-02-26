-- Database URL snippets for LuaSnip
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
-- local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

-- Helper function to get current filetype or environment
-- local function get_db_type()
--   -- You can customize this based on your project
--   return "postgresql" -- default
-- end

-- PostgreSQL connection string
local postgres_snippet = s(
  { trig = "pgurl", name = "PostgreSQL URL", dscr = "Generate PostgreSQL connection URL" },
  fmt([[{}://{}:{}@{}:{}/{}?sslmode={}]], {
    t("postgresql"),
    i(1, "username"),
    i(2, "password"),
    i(3, "localhost"),
    i(4, "5432"),
    i(5, "database"),
    c(6, { t("disable"), t("require"), t("verify-ca"), t("verify-full") }),
  })
)

-- MySQL connection string
local mysql_snippet = s(
  { trig = "mysqlurl", name = "MySQL URL", dscr = "Generate MySQL connection URL" },
  fmt([[{}://{}:{}@{}:{}/{}?charset={}]], {
    t("mysql"),
    i(1, "username"),
    i(2, "password"),
    i(3, "localhost"),
    i(4, "3306"),
    i(5, "database"),
    i(6, "utf8mb4"),
  })
)

-- SQLite connection string
local sqlite_snippet = s(
  { trig = "sqliteurl", name = "SQLite URL", dscr = "Generate SQLite connection URL" },
  fmt([[{}://{}/{}]], {
    t("sqlite"),
    i(1, "/path/to/database"),
    i(2, "database.db"),
  })
)

-- MongoDB connection string
local mongodb_snippet = s(
  { trig = "mongourl", name = "MongoDB URL", dscr = "Generate MongoDB connection URL" },
  fmt([[{}://{}:{}@{}:{}/{}?authSource={}]], {
    t("mongodb+srv"),
    i(1, "username"),
    i(2, "password"),
    i(3, "cluster.mongodb.net"),
    t("27017"),
    i(4, "database"),
    i(5, "admin"),
  })
)

-- Redis connection string
local redis_snippet = s(
  { trig = "redisurl", name = "Redis URL", dscr = "Generate Redis connection URL" },
  fmt([[{}://{}:{}@{}:{}/{}]], {
    t("redis"),
    i(1, "default"),
    i(2, "password"),
    i(3, "localhost"),
    i(4, "6379"),
    i(5, "0"),
  })
)

-- Generic database URL with choice
local generic_db_snippet = s(
  { trig = "dburl", name = "Generic DB URL", dscr = "Generate any database URL" },
  fmt([[{}://{}:{}@{}:{}/{}]], {
    c(1, {
      t("postgresql"),
      t("mysql"),
      t("mongodb"),
      t("redis"),
      t("sqlite"),
      t("cockroachdb"),
      t("oracle"),
      t("mssql"),
    }),
    i(2, "username"),
    i(3, "password"),
    i(4, "localhost"),
    i(5, "5432"),
    i(6, "database"),
  })
)

-- Connection string with environment variables
local env_db_snippet = s(
  { trig = "envdb", name = "Environment DB URL", dscr = "Database URL using env vars" },
  fmt([[{}://${{{}}}:${{{}}}@${{{}}}:${{{}}}/${{{}}}?sslmode={}]], {
    c(1, {
      t("postgresql"),
      t("mysql"),
      t("mongodb"),
      t("redis"),
    }),
    i(2, "DB_USER"),
    i(3, "DB_PASS"),
    i(4, "DB_HOST"),
    i(5, "DB_PORT"),
    i(6, "DB_NAME"),
    c(7, { t("disable"), t("require") }),
  })
)

-- Connection string parser (reverse engineer)
local function parse_url(args)
  -- This function could parse existing URLs and reformat them
  -- For now, it just returns a template
  return "{{ parsed_url }}"
end

local parse_db_snippet =
  s({ trig = "parsedb", name = "Parse DB URL", dscr = "Parse and format database URL" }, f(parse_url, {}))

-- Docker database URLs
local docker_postgres_snippet = s(
  { trig = "dockerpg", name = "Docker PostgreSQL", dscr = "PostgreSQL URL for Docker" },
  fmt([[{}://{}:{}@{}:{}/{}?sslmode={}]], {
    t("postgresql"),
    t("postgres"),
    i(1, "postgres"),
    t("postgres"),
    t("5432"),
    i(2, "postgres"),
    t("disable"),
  })
)

-- Railway.app style URL (just the database part)
local railway_db_snippet = s(
  { trig = "railwaydb", name = "Railway DB URL", dscr = "Database URL for Railway.app" },
  fmt([[${{{{{}}}}}]], {
    i(1, "DATABASE_URL"),
  })
)

-- Heroku style URL
local heroku_db_snippet = s(
  { trig = "herokudb", name = "Heroku DB URL", dscr = "Database URL for Heroku" },
  fmt([[${{{{{}}}}}]], {
    i(1, "DATABASE_URL"),
  })
)

-- Return all snippets
local db_snippets = {
  postgres_snippet,
  mysql_snippet,
  sqlite_snippet,
  mongodb_snippet,
  redis_snippet,
  generic_db_snippet,
  env_db_snippet,
  parse_db_snippet,
  docker_postgres_snippet,
  railway_db_snippet,
  heroku_db_snippet,
}

-- Load all database snippets
for _, snippet in ipairs(db_snippets) do
  ls.add_snippets("all", { snippet })
end
