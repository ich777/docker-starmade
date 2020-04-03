# StarMade Server in Docker optimized for Unraid
This container will download and install a StarMade Dedicated Server.
It will also install a basic server.cfg at the first startup.

UPDATE: The container will check on every restart if there is a newer version of StarMade available.


## Env params
| Name | Value | Example |
| --- | --- | --- |
| DATA_DIR | Folder for gamefile | /starmade |
| RUNTIME_NAME | Enter your extracted Runtime folder name. Don't change unless you are knowing what you are doing! | basicjre |
| GAME_PARAMS | Extra startup Parameters if needed (leave empty if not needed) | |
| XMX_SIZE | Enter your XMX size in MB (XMX=The maximum heap size. The performance will decrease if the max heap value is set lower than the amount of live data. It will force frequent garbage collections in order to free up space). | 1024 |
| XMS_SIZE | Enter your XMS size in MB (XMS=The initial and minimum heap size. It is recommended to set the minimum heap size equivalent to the maximum heap size in order to minimize the garbage collection). | 1024 |
| EXTRA_JVM_PARAMS | Extra JVM startup Parameters if needed (leave empty if not needed) | |
| STARTER_PARAMS | Only change if you know what you are doing! | -nogui |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| UMASK | User file permission mask for newly created files | 000 |
| DATA_PERM | Data permissions for main storage folder | 770 |

## Run example
```
docker run --name StarMade -d \
	-p 4343:4343 \
	--env 'RUNTIME_NAME=basicjre' \
	--env 'XMX_SIZE=1024' \
    --env 'XMS_SIZE=1024' \
    --env 'STARTER_PARAMS=-nogui' \
	--env 'UID=99' \
	--env 'GID=100' \
	--env 'UMASK=000' \
	--env 'DATA_PERM=770' \
	--volume /mnt/user/appdata/starmade:/starmade \
	ich777/starmade-server
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/