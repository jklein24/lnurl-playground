node_modules: package.json
	npm install
	touch node_modules

static/bundle.js: $(shell find ./client) node_modules
	./node_modules/.bin/rollup -c rollup.config.js

deploy: static/bundle.js
	netlify deploy --prod --dir=static
