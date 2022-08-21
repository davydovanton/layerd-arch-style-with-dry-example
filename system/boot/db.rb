Container.register_provider(:db) do |container|
  prepare do
    require 'sqlite3'

    db = SQLite3::Database.open 'dry_course.db'
    db.results_as_hash = true


    register('persistance.db', db)
  end

  start do
    # -------- Terrible code, don't do it in production. Use regular migration flow ---------

    container['persistance.db'].execute(
      %{
        CREATE TABLE IF NOT EXISTS accounts(
          id      INTEGER PRIMARY KEY,

          name    TEXT,
          email   TEXT,
          address TEXT
        )
      }
    )

    container['persistance.db'].execute(
      %{
        CREATE TABLE IF NOT EXISTS orders(
          id         INTEGER PRIMARY KEY,
          account_id INT,
          status     TEXT DEFAULT 'open',

          FOREIGN KEY(account_id) REFERENCES accounts(id)
        )
      }
    )

    container['persistance.db'].execute(
      %{
        CREATE TABLE IF NOT EXISTS items(
          id       INTEGER PRIMARY KEY,
          order_id INT,
          title    TEXT,
          count    INT,

          FOREIGN KEY(order_id) REFERENCES orders(id)
        )
      }
    )
    
    # ---------------------------------------------------------------------------------------
  end

  stop do
    container['persistance.db'].close
  end
end
