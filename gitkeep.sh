#!/bin/sh -xe
seek(){
	for ELEM in * ; do
		if [ -d "${ELEM}" ]; then
			if [ -z "$(ls -A ${ELEM})" ]
			then
				touch ${ELEM}/.gitkeep
                        else
				(cd $ELEM; seek;)
			fi

		fi
	done
}

for TARG in * ; do
	if [ -d "${TARG}" ]; then
		(cd $TARG; seek;)
	fi
done


		
