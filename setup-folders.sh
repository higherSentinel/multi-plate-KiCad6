#shebang
#!/bin/bash

# check if the path to write was parsed as param 1
if ! [ $# -gt 0 ]; then
    echo "input error!, script requires the output path specified as argument 1. please provide a valid path"
    return -1;
fi

OUTPUT_DIR=$1
CONFIG_FILE="dir.config"

PREFIX=""
SUFFIX=""

# check if the output path is valid
if ! [ -d $OUTPUT_DIR ]; then
    echo "$OUTPUT_DIR is not a valid directory"
    return -1;
fi

# check if the file end contains a new line. if not add one so that the content of the last line is not missed
if ! tail -n -1 $CONFIG_FILE | grep -q "^$"; then
    echo -e "\n" >> $CONFIG_FILE
fi

while read line; do
    # filter the correct line
    if echo $line | grep -v -e "^$" | grep -q "^[a-zA-Z0-9\-]*$"; then
        
        # if the folder exists do not proceed :)
        if [ -d $OUTPUT_DIR/$PREFIX$line$SUFFIX ]; then
            echo "$OUTPUT_DIR/$PREFIX$line$SUFFIX exists."
            continue
        fi

        echo "generating boiler plate for $PREFIX$line$SUFFIX"

        # if not create the directory
        mkdir -p $OUTPUT_DIR/$PREFIX$line$SUFFIX

        # copy files to correct path
        cp -r template/* $OUTPUT_DIR/$PREFIX$line$SUFFIX

        # rename the kicad files
        mv $OUTPUT_DIR/$PREFIX$line$SUFFIX/boiler-plate.kicad_pro $OUTPUT_DIR/$PREFIX$line$SUFFIX/$PREFIX$line$SUFFIX.kicad_pro
        mv $OUTPUT_DIR/$PREFIX$line$SUFFIX/boiler-plate.kicad_sch $OUTPUT_DIR/$PREFIX$line$SUFFIX/$PREFIX$line$SUFFIX.kicad_sch
        mv $OUTPUT_DIR/$PREFIX$line$SUFFIX/boiler-plate.kicad_pcb $OUTPUT_DIR/$PREFIX$line$SUFFIX/$PREFIX$line$SUFFIX.kicad_pcb

    fi 
done < $CONFIG_FILE

# copy over the gitignore
cp gitignore $OUTPUT_DIR/$PREFIX$line$SUFFIX/.gitignore
