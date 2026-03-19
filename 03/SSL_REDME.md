# Generowanie self-signed certyfikatu SSL
 
## Wymagania
 
- Zainstalowany `openssl` (lub Docker)
- Utworzony katalog `nginx/certs/`
 
```bash
mkdir -p nginx/certs
```
 
---
 
## Komenda
 
```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout nginx/certs/key.pem \
  -out nginx/certs/cert.pem
```
 
---
 
## Jak działa komenda
 
| Fragment | Co robi |
|---|---|
| `openssl req` | Tworzy żądanie certyfikatu (Certificate Signing Request) |
| `-x509` | Zamiast wysyłać żądanie do CA, od razu generuje self-signed certyfikat |
| `-nodes` | Klucz prywatny **nie** jest szyfrowany hasłem (potrzebne żeby nginx mógł go czytać automatycznie) |
| `-days 365` | Certyfikat ważny przez 365 dni |
| `-newkey rsa:2048` | Generuje nowy klucz RSA o długości 2048 bitów |
| `-keyout nginx/certs/key.pem` | Zapisuje klucz prywatny do tego pliku |
| `-out nginx/certs/cert.pem` | Zapisuje certyfikat do tego pliku |
 
--- 
## Wynik
 
Po wykonaniu komendy w katalogu `nginx/certs/` pojawią się dwa pliki:
 
- `key.pem` — klucz prywatny (nie udostępniaj!)
- `cert.pem` — certyfikat publiczny
 
---
 
## Uwaga
 
Self-signed certyfikat **nie jest zaufany przez przeglądarki** — zobaczysz ostrzeżenie bezpieczeństwa. To normalne na potrzeby lokalnego developmentu. Na produkcji użyj certyfikatu od zaufanego CA (np. [Let's Encrypt](https://letsencrypt.org/)).