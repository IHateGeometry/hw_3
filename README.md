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

3)

vsevolod@vsevolod-AORUS-15X-ASF:~/hw_3$ curl -fsS http://127.0.0.1:8081/readyz
{"status": "ready", "storage": "redis"}vcurl -fsS -X POST http://127.0.0.1:8081/increment-X POST http://127.0.0.1:8081/increment
{"greeting": "hello", "count": 4, "hostncurl -fsS -X POST http://127.0.0.1:8081/increment@vsevolod-AORUS-15X-ASF:~/hw_3$ curl -fsS -X POST http://127.0.0.1:8081/increment
{"greeting": "hello", "count": 5, "hostname": "353adb9af105", "storage": "redis"}vsevolod@vsevolod-AORUS-15X-ASF:~/hw_3$ docker compose down
[+] down 3/3
 ✔ Container hw_3-app-1   Removed                                                                                                                                                                                                        14.5s
 ✔ Container hw_3-redis-1 Removed                                                                                                                                                                                                         1.0s
 ✔ Network hw_3_default   Removed                                                                                                                                                                                                         0.3s
vsevolod@vsevolod-AORUS-15X-ASF:~/hw_3$ docker compose up -d
WARN[0000] Found orphan containers (hw_3-app-run-a833a1846761) for this project. If you removed or renamed this service in your compose file, you can run this command with the --remove-orphans flag to clean it up. 
[+] up 3/3
 ✔ Network hw_3_default   Created                                                                                                                                                                                                         0.2s
 ✔ Container hw_3-redis-1 Started                                                                                                                                                                                                         1.8s
 ✔ Container hw_3-app-1   Started                                                                                                                                                                                                         2.6s
vsevolod@vsevolod-AORUS-15X-ASF:~/hw_3$ curl -fsS http://127.0.0.1:8081/readyz
{"status": "ready", "storage": "redis"}vsevolod@vsevolod-AORUS-15X-ASF:~/hw_3$ curl -fsS http://127.0.0.1:8081/
{"greeting": "hello", "count": 5, "hostname": "0f29851e1bbf", "storage": "redis"}vsevolod@vsevolod-AORUS-15X-ASF:~/hw_3$ 
 
счётчик остался 5



vsevolod@vsevolod-AORUS-15X-ASF:~/hw_3$ docker compose stop redis
[+] stop 1/1
 ✔ Container hw_3-redis-1 Stopped                                                                                                                                                                                                         0.7s
vsevolod@vsevolod-AORUS-15X-ASF:~/hw_3$ curl -fsS http://127.0.0.1:8081/healthz
{"status": "alive"}vsevolod@vsevolod-AORUS-15X-ASF:~/hw_3$ curl -fsS http://127.0.0.1:8081/readyz
curl: (22) The requested URL returned error: 503
vsevolod@vsevolod-AORUS-15X-ASF:~/hw_3$ curl -fsS -X POST http://127.0.0.1:8081/increment
curl: (22) The requested URL returned error: 503
vsevolod@vsevolod-AORUS-15X-ASF:~/hw_3$ 


вернули 200, 503, 503



vsevolod@vsevolod-AORUS-15X-ASF:~/hw_3$ docker compose start redis
[+] start 1/1
 ✔ Container hw_3-redis-1 Started                                                                                                                                                                                                         0.7s
vsevolod@vsevolod-AORUS-15X-ASF:~/hw_3$ curl -fsS http://127.0.0.1:8081/readyz
{"status": "ready", "storage": "redis"}vsevolod@vsevolod-AORUS-15X-ASF:~/hw_3$ curl -fsS http://127.0.0.1:8081/
{"greeting": "hello", "count": 5, "hostncurl -fsS -X POST http://127.0.0.1:8081/increment@vsevolod-AORUS-15X-ASF:~/hw_3$ curl -fsS -X POST http://127.0.0.1:8081/increment
{"greeting": "hello", "count": 6, "hostname": "0f29851e1bbf", "storage": "redis"}vsevolod@vsevolod-AORUS-15X-ASF:~/hw_3$ 


счётчик снова был 5 а потом увеличился до 6
