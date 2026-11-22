1) docker build -t v1 . - сборка
docker run -p 127.0.0.1:8080:8000 -e GREETING="meow" v1 - запуск с приветствием через переменную окружения
docker run -p 127.0.0.1:8080:8000 v1 - запуск без переменной
curl http://127.0.0.1:8080/ - без увеличения счётчика
curl -X POST http://127.0.0.1:8080/increment - с увеличением

логи:

2026-11-22 15:20:11,199 listening port=8000 storage=sqlite"
2026-11-22 15:20:23,769 http 172.17.0.1 "GET / HTTP/1.1" 200 -
2026-11-22 15:20:23,856 http 172.17.0.1 "POST /increment HTTP/1.1" 200 -

2) компиляция:
cp .env.example .env
docker compose up -d
проверка:
curl http://127.0.0.1:8081/
вернётся greeting: hello и count: 0
curl -X POST http://127.0.0.1:8081/increment
счётчик становится 1
docker compose down
контейнер останавливается и удаляется
docker compose up -d
создаётся новый
curl http://127.0.0.1:8081/
счётчик вернётся 1
