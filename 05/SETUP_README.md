## Backup bazy danych

### Ręczne uruchomienie
```bash
# Nadaj uprawnienia (tylko raz)
chmod +x backup.sh

# Uruchom backup
./backup.sh
```

Plik backupu pojawi się w katalogu `backups/` w formacie `backup_YYYYMMDD_HHMM.sql`.

### Zmienne środowiskowe

Skrypt czyta zmienne z `.env`:

| Zmienna | Domyślna | Opis |
|---|---|---|
| `DB_NAME` | `mydb` | Nazwa bazy danych |
| `DB_USER` | `admin` | Użytkownik bazy danych |

### Konfiguracja automatycznego backupu (cron)

Aby backup uruchamiał się codziennie o 02:00, dodaj wpis do crontab na VPS:
```bash
crontab -e
```

Dodaj linię (dostosuj ścieżkę do projektu):
```
0 2 * * * cd /root/practice-django-deployment/05 && ./backup.sh >> /var/log/backup.log 2>&1
```

Sprawdź czy cron działa:
```bash
# Lista aktywnych zadań cron
crontab -l

# Logi backupu
cat /var/log/backup.log
```

### Przywracanie backupu
```bash
docker compose exec -T db psql -U admin -d mydb < backups/backup_YYYYMMDD_HHMM.sql
```