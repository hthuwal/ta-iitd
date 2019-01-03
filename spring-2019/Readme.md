## postgreSQL

- Pull Docker

    `sudo dokcer pull postgres`

- Start Docker Image
    
    `make start-postgres` 

    This runs the follwoing command:

    ```bash
    sudo docker run --rm  --name pg-docker -e POSTGRES_PASSWORD=docker \
    -d -p 5432:5432 -v $$HOME/docker/volumes/postgres:/var/lib/postgresql/data \
    -v $$(realpath data):/data postgres

    ```

    Above command is explained [here.](https://hackernoon.com/dont-install-postgres-docker-pull-postgres-bee20e200198)

- Enter Bash of Docker Image

    `make postgres-bash`

    This runs the following command:
        
    ```bash
    sudo docker exec -it $$(sudo docker ps -a -q) bash`
    ```

- Start postgreSQL shell

    `psql -U postgres`

    Type `\connninfo` to check connection to PostgreSQL DB
    
