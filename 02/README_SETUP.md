# Instrukcja uruchomienia zadania 02

## 1. Przejdź do katalogu projektu
```powershell
cd practice-django-deployment\02
```

## 2. Sprawdź konfigurację Nginx
Plik: `nginx/default.conf`
- Proxy: `http://web:8000`
- Nagłówki:
  - `Host`
  - `X-Real-IP`
  - `X-Forwarded-For`
  - `X-Forwarded-Proto`

## 3. Sprawdź docker-compose.yml
- Usługa `web`:
  - budowana z `Dockerfile`
  - startuje aplikację Django na `0.0.0.0:8000`
  - expose `8000`
- Usługa `nginx`:
  - `image: nginx:alpine`
  - montuje `nginx/default.conf`
  - port `80:80` na hosta
  - brak mapowania `8000` na hosta

## 4. Uruchom aplikację
```powershell
docker compose up --build
```

## 5. Weryfikacja
- Otwórz w przeglądarce: `http://localhost`
- Powinna być dostępna aplikacja Django
- `http://localhost:8000` powinno być niedostępne (tylko Nginx wystawia port)

## 6. Zatrzymanie i debug
- Zatrzymaj: `docker compose down`
- Logi:
  - `docker compose logs -f nginx`
  - `docker compose logs -f web`
