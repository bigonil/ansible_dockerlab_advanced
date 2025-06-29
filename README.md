# 🐳 Ansible Docker Lab (Advanced)

Questo repository contiene un laboratorio avanzato per testare **Ansible** su un cluster simulato di **3 container Docker**.  
È pensato per esercitarsi con:

- Ruoli (`roles`)
- Variabili per gruppo (`group_vars`)
- Template Jinja2
- Gestione gruppi host e facts

---

## 🧱 Struttura del progetto

```

ansible\_dockerlab\_advanced/
├── inventory.ini                  # Inventario Ansible con nodi su localhost\:porta
├── site.yml                       # Playbook principale con 2 ruoli: common e web
├── group\_vars/
│   └── webservers.yml             # Variabili specifiche per il gruppo webservers
├── roles/
│   ├── common/
│   │   ├── tasks/main.yml         # Task comuni per tutti i nodi
│   │   └── templates/motd.j2      # Template MOTD (opzionale)
│   └── web/
│       ├── tasks/main.yml         # Task per nodi webserver
│       └── templates/index.html.j2 # Pagina HTML dinamica per HTTP
├── Makefile                       # Comandi rapidi con `make`
└── bootstrap.sh                   # Script di provisioning container e rete

````

---

## 🚀 Come iniziare

### 1️⃣ Avvia i container e configura SSH + Python

```bash
make up
````

### 2️⃣ Verifica accesso Ansible via SSH

```bash
make ping
```

### 3️⃣ Esegui il playbook

```bash
make playbook
```

### 4️⃣ Pulisci l'ambiente

```bash
make clean
```

---

## 🔍 Dettagli dei ruoli

### 📁 `common` (per tutti i nodi)

* Installa `curl`, `nano` e `python3`
* Crea `/etc/node-info.txt` con hostname, indirizzo IP e RAM

### 🌐 `web` (solo `node2` e `node3`)

* Installa `lighttpd` come server HTTP
* Crea una pagina dinamica `/var/www/index.html` via Jinja2
* Avvia `lighttpd` sulla porta 80 (esposta tramite 808X)

---

## 🌐 Accesso Web

Dopo il playbook, puoi testare i webserver da browser o `curl`:

```bash
curl http://localhost:8081
curl http://localhost:8082
curl http://localhost:8083
```

---

## 🛠 Requisiti

* Docker e bash
* Ansible installato su host (`pip install ansible`)
* Chiave SSH pubblica in `~/.ssh/id_rsa.pub`
  (usata per autenticazione nei container)

---

## 📦 Credits

Creato da **Luca Bigoni**
*Esercizio avanzato per laboratorio Ansible + Docker*

```
