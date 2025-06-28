 # Ansible Docker Lab (Advanced)

    Questo repository contiene un laboratorio avanzato per testare Ansible su un cluster simulato di 3 container Docker.  
    È pensato per esercitarsi con ruoli, facts, template Jinja2 e gestione gruppi host.

    ## 🧱 Struttura del progetto

    ```
    ansible_dockerlab_advanced/
    ├── inventory.ini                  # Inventario Ansible con nodi su localhost:porta
    ├── site.yml                       # Playbook principale con 2 ruoli: common e web
    ├── group_vars/
    │   └── webservers.yml             # Variabili specifiche per il gruppo webservers
    ├── roles/
    │   ├── common/
    │   │   ├── tasks/main.yml         # Task comuni per tutti i nodi
    │   │   └── templates/motd.j2      # Template MOTD (opzionale)
    │   └── web/
    │       ├── tasks/main.yml         # Task per nodi webserver
    │       └── templates/index.html.j2 # Pagina HTML dinamica per HTTP
    ├── Makefile                       # Comandi rapidi make
    └── bootstrap.sh                   # Script di provisioning container e rete
    ```

    ## 🚀 Come iniziare

    ### 1. Avvia i container e configura SSH + Python
    ```bash
    make up
    ```

    ### 2. Verifica accesso SSH e Ansible
    ```bash
    make ping
    ```

    ### 3. Esegui il playbook
    ```bash
    make playbook
    ```

    ### 4. Pulisci tutto
    ```bash
    make clean
    ```

    ## 🔍 Dettagli dei ruoli

    ### `common` (tutti i nodi)
    - Installa `curl` e `nano`
    - Crea `/etc/node-info.txt` con hostname, IP e RAM

    ### `web` (solo `node2` e `node3`)
    - Installa `busybox` come HTTP server
    - Crea `/var/www/index.html` dinamico via template
    - Avvia `httpd` su porta 8080

    ## 🌐 Accesso web

    Dopo il playbook, puoi accedere da browser (se esposti):
    ```
    http://localhost:8080
    ```

    ## 🛠 Requisiti

    - Docker + bash
    - Ansible installato su host
    - Chiave SSH pubblica in `~/.ssh/id_rsa.pub`

    ## 📦 Credits

    Creato da Luca Bigoni — esercizio avanzato di laboratorio Ansible + Docker
