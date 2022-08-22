# Example of layered architecture style builded with dry-rb libs

This repository contain source code with explain how to build [Layered Architecture Style](https://www.oreilly.com/library/view/software-architecture-patterns/9781491971437/ch01.html) in ruby with [dry-rb](https://dry-rb.org/) libs

App call:

```
be ruby apps/in_memory/app.rb
```

FitnessFunctions call

```
be ruby fitness_functions/cross_context_calls_checker.rb
```

HTTP server call

```
be rackup apps/http/config.ru
```
