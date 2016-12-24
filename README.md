# middleman-ruby_yaml

Use .yaml files to define models.

You can do things like:

## YAML Example:
data/heroe.yml
```
name: <%= Faker::Superhero.name %>
powers:
  - <%= Faker::Superhero.power %>
  - <%= Faker::Superhero.power %>
  - <%= Faker::Superhero.power %>
got_characters:
  - name: <%= Faker::GameOfThrones.character %>
    color: <%= Faker::Color.color_name %>
  - name: <%= Faker::GameOfThrones.character %>
    color: <%= Faker::Color.color_name %>

```

## Ruby Usage:
middleman/Gemfile
```
gem 'faker'
gem 'middleman-ruby_yaml', git: 'https://github.com/dvdgs88/middleman-ruby_yaml.git'
```
middleman/config.rb
```
activate :ruby_yaml
```
middleman/source/file.html.erb
```
<div>
	<ul>
	<% o(data.heroe, 5).each do |heroe| %>
		<li>
			<%= heroe.name %>
			<ul>
				<% heroe.powers.each do |power| %>
					<li>
						<%= power %>
					</li>
				<% end %>
			</ul>
			<ul>
				<% heroe.got_characters.each do |character| %>
					<li>
						<%= character.name %> (color: <%= character.color %>)
					</li>
				<% end %>
			</ul>
		</li>
	<% end %>
</div>

```
