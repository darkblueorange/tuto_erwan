# Adel

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`51.68.126.96:4000`](http://51.68.126.96:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
```

Pour icônes SVG : 
http://svgicons.sparkk.fr/


Insertion de VegaLite, notamment npm :
https://github.com/filipecabaco/vegalite_demo

Formattage dans VSCode : 
https://abletech.nz/resource/how-to-configure-vs-code-to-format-elixir-code/
https://pragmaticstudio.com/tutorials/formatting-heex-templates-in-vscode

https://marketplace.visualstudio.com/items?itemName=phoenixframework.phoenix


Lancement en mode détaché : 
PORT=4000 MIX_ENV=dev elixir --erl "-detached" -S mix phx.server
(si changement de port, il faut aussi modifier à d'autres endroits)

https://hexdocs.pm/phoenix/deployment.html
Pour récupérer le PID de suite : 
elixir --detached -e "File.write! 'pid', :os.getpid" -S mix phoenix.server

Pour le détecter : 
	ss -tulpn | grep :4000
à corréler avec : 
	ps aux | grep elixir



