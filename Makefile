build_docs:
	bundle exec rspec --color --format doc --out doc.txt

view_docs:
	cat doc.txt

start_dev:
	bundle exec rackup config.ru -p 80 -o 0.0.0.0

test:
	bundle exec rspec

test-watch:
	find . -name '*.rb' | entr -c bundle exec rspec --fail-fast

audit:
	bundle exec rubocop -P

build:
	docker build . -t collectives

start_prod: build
	docker run -p 80:80 collectives
