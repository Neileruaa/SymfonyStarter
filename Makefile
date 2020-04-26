install:
	docker-compose build
	docker-compose up -d
	docker-compose exec symfony composer install
	docker-compose exec symfony bin/console doc:data:create --if-not-exists
	docker-compose exec symfony bin/console doc:schem:up --force

start:
	docker-compose up -d
	docker-compose exec symfony composer install
	docker-compose exec symfony npm install
	@echo "started on http://127.0.0.1:8000/"
	@echo "PMA on http://127.0.0.1:6034/"

stop:
	docker-compose down --remove-orphans

console:
	docker-compose exec symfony bash

database:
	docker-compose exec symfony  bin/console doc:data:create --if-not-exists
	docker-compose exec symfony  bin/console doc:migrations:migrate --no-interaction

wp-watch:
	docker-compose exec symfony  npm run watch

routes:
	docker-compose exec symfony bin/console fos:js-routing:dump --format=json --target=public/js/fos_js_routes.json

load:
	docker-compose exec symfony bin/console doctrine:fixtures:load -q

ts:
	docker-compose exec symfony bin/phpunit  -v