# Lint with RuboCop
lint:
	bundle exec rubocop

# Auto-correct lint issues
lint-fix:
	bundle exec rubocop -A

# Run tests
test:
	bundle exec rspec

# Run the app (Sinatra)
run:
	bundle exec ruby app.rb

run-dependencies:
	docker compose up -d

stop-dependencies:
	docker compose down

run-dependencies-with-logs:
	docker compose up -d
	docker compose logs -f

run-migrations:
	bundle exec rake db:migrate
	