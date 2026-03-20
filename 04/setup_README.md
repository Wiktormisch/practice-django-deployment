## CI/CD — Automatyczny deployment

### Wymagane GitHub Secrets

Dodaj je w: **Settings → Secrets and variables → Actions → New repository secret**

| Secret | Opis | Przykład |
|---|---|---|
| `SSH_HOST` | Hostname serwera VPS | `abcd.mikrus.xyz` |
| `SSH_USER` | Użytkownik SSH | `root` |
| `SSH_PORT` | Port SSH (Mikrus używa niestandardowego portu) | `10111` |
| `SSH_PRIVATE_KEY` | Klucz prywatny SSH (zawartość `~/.ssh/id_ed25519`) | `-----BEGIN OPENSSH PRIVATE KEY-----...` |

### Pierwszy deploy

1. Wygeneruj klucz SSH na serwerze VPS:
```bash
   ssh-keygen -t ed25519 -C "vps"
   cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys
```
2. Skopiuj klucz prywatny i dodaj do GitHub Secrets:
```bash
   cat ~/.ssh/id_ed25519
```
3. Dodaj wszystkie Secrets do repozytorium
4. Upewnij się że aplikacja jest ręcznie sklonowana na VPS
5. Zrób push do gałęzi `main` — workflow uruchomi się automatycznie

### Połączenie z serwerem (Mikrus)

Mikrus używa niestandardowego portu SSH — łączysz się przez:
```bash
ssh -p 10111 root@abcd111.mikrus.xyz
```

### Weryfikacja deploymentu

Zaloguj się na VPS i sprawdź:
```bash
# Czy kontenery działają
docker ps

# Logi aplikacji
docker compose logs web

# Logi całego workflow — zakładka Actions na GitHubie
```