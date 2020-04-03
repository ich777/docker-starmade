#!/bin/bash
echo "---Checking for 'runtime' folder---"
if [ ! -d ${DATA_DIR}/runtime ]; then
	echo "---'runtime' folder not found, creating...---"
	mkdir ${DATA_DIR}/runtime
else
	echo "---'runtime' folder found---"
fi

echo "---Checking if Runtime is installed---"
if [ -z "$(find ${DATA_DIR}/runtime -name jre*)" ]; then
    if [ "${RUNTIME_NAME}" == "basicjre" ]; then
    	echo "---Downloading and installing Runtime---"
		cd ${DATA_DIR}/runtime
		if wget -q -nc --show-progress --progress=bar:force:noscroll https://github.com/ich777/runtimes/raw/master/jre/basicjre.tar.gz ; then
			echo "---Successfully downloaded Runtime!---"
		else
			echo "---Something went wrong, can't download Runtime, putting server in sleep mode---"
			sleep infinity
		fi
        tar --directory ${DATA_DIR}/runtime -xvzf ${DATA_DIR}/runtime/basicjre.tar.gz
        rm -R ${DATA_DIR}/runtime/basicjre.tar.gz
    else
    	if [ ! -d ${DATA_DIR}/runtime/${RUNTIME_NAME} ]; then
        	echo "---------------------------------------------------------------------------------------------"
        	echo "---Runtime not found in folder 'runtime' please check again! Putting server in sleep mode!---"
        	echo "---------------------------------------------------------------------------------------------"
        	sleep infinity
        fi
    fi
else
	echo "---Runtime found---"
fi
export RUNTIME_NAME="$(ls -la -d ${DATA_DIR}/runtime/* | tail -1 | cut -d '/' -f4)"

echo "---Checking for Starmade Starter executable ---"
if [ ! -f ${DATA_DIR}/StarMade-Starter.jar ]; then
	cd ${DATA_DIR}
	echo "---Downloading Starmade Starter executable---"
	if wget -q -nc --show-progress --progress=bar:force:noscroll -O StarMade-Starter.jar ${DL_URL} ; then
		echo "---Successfully downloaded Starmade Starter executable!---"
	else
		echo "---Something went wrong, can't download Starmade Server executable, putting server in sleep mode---"
		sleep infinity
	fi
	sleep 2
	if [ ! -f ${DATA_DIR}/StarMade-Starter.jar ]; then
		echo "--------------------------------------------------------------------------------------------------------------"
		echo "---Something went wrong, please install Starmade Starter executable manually. Putting server into sleep mode---"
		echo "--------------------------------------------------------------------------------------------------------------"
		sleep infinity
	fi
else
	echo "---Starmade Starter executable found---"
fi

echo "---Checking for Starmade files---"
if [ ! -d ${DATA_DIR}/StarMade ]; then
	cd ${DATA_DIR}
	echo "---Starmade files not found, downlaoding---"
	${DATA_DIR}/runtime/${RUNTIME_NAME}/bin/java -jar ${DATA_DIR}/StarMade-Starter.jar -nogui
	if [ ! -d ${DATA_DIR}/StarMade ]; then
		echo "---Something went wront, can't download Starmade files, putting server into sleep mode---"
		sleep infinity
	fi
else
	echo "---Starmade filese found, checking for updates---"
	cd ${DATA_DIR}
	${DATA_DIR}/runtime/${RUNTIME_NAME}/bin/java -jar ${DATA_DIR}/StarMade-Starter.jar -nogui
fi

echo "---Preparing Server---"
chmod -R ${DATA_PERM} ${DATA_DIR}

echo "---Starting Server---"
cd ${DATA_DIR}/StarMade
${DATA_DIR}/runtime/${RUNTIME_NAME}/bin/java ${EXTRA_JVM_PARAMS} -Xmx${XMX_SIZE}M -Xms${XMS_SIZE}M -jar ${DATA_DIR}/StarMade/StarMade.jar -server ${GAME_PARAMS}