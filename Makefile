build_docs:
	bundle exec rspec --color --format doc --out doc.txt

view_docs:
	cat doc.txt
