#!/bin/bash

toolfolder="c:/d/Project/tool_proj/"
xdriver="x:/"

display_help() {
    echo "Usage: $0 [option...] { }" >&2
    echo
    echo " -c    command:  
  lsvtree : ls version tree     , -v -l
  fpy     : find file in py     , -v -f
  ffl     : find file in list   , -v -f, -p: list file property
  lview   : cleartool lsview    , -v
  stview  : cleartool startview , -v "
    echo " -l    label included string  "
    echo " -v    view    "
    echo
    # echo some stuff here for the -a or --add-options 
    exit 1
}
#declare -i index=0
#for i in $*
#do
#  index=`expr $index + 1`
#  echo $index
#  echo $i
#done
lsview_cc(){
  cleartool lsview | grep $1 | awk '{if($1=="*") {print $2 "  --->  OPEN";}else{print $1}}' 
  cleartool lsview | grep $1
}
startview_cc(){
  #cleartool lsview | grep $1 | awk '{if($1=="*") {print $2;}else{print "startview  " $1;View=$2;}}' 
  eval $(cleartool lsview | grep $1 | awk '{if($1=="*") {print "view="$2;print "open="$1;}else{print "view="$1;}}')
  if [ "${open}" != "*" ]; then
    echo "starting view: "${view}
    cleartool startview ${view} 
  else
    echo ${view}" has started"
  fi
  cleartool lsview | grep $1 
}

# a: means -a need a parameter
while getopts "c:l:v:f:hpd" arg
do
        case $arg in
             c)
                echo "cmd is $OPTARG"
                CMD=$OPTARG
                ;;
             l)
                echo "label is $OPTARG"
                LABEL=$OPTARG
                ;;
             v)
                cleartool lsview | grep $OPTARG | awk '{if($1=="*") {print $2;}else{print $1}}'>tmp.txt 
                VIEW=$OPTARG
                echo "view  is $OPTARG"
                rm tmp.txt
                ;;
             f)
                echo "file  is $OPTARG"
                FILE=$OPTARG
                ;;
             p)
                echo "property  is true"
                PROPERTY=true
                ;;
             d)
                echo "cleartool describe"
                DESCRIBE=true
                ;;
             h)
                display_help
                ;;
             ?)  #当有不认识的选项的时候arg为?
            echo "unkonw argument"
        exit 1
        ;;
        esac
done
if [ "$VIEW" ]; then
  gvfolder_path=`find $xdriver -maxdepth 1 -name "*$VIEW*" `
  gvfolder_path=`echo ${gvfolder_path} | awk '{print $1}' `
  echo $gvfolder_path
  if [ ${gvfolder_path} ]; then
    build_path=$gvfolder_path"/gill_vob/6_coding"
    echo "BUILD PATH:"$build_path
#    gvpath_win=${gvfolder_path//\//\\}
    echo ${gvpath_win}
    buildpath_win=${build_path//\//\\}
    echo "BUILD PATH WIN: "${buildpath_win}
    filelist=${build_path}"/FileList.txt"
    filelist_win=${filelist//\//\\}
  else
    echo "no view name found"
  fi
fi

echo "FILE LIST: "${filelist}
pyfile=${build_path}"/config_sg7557.py"
echo ${pyfile}
pyfile_win=${pyfile_path//\//\\}
if [ "${VIEW}" ]&&[ ${filelist} ]&&[ -f ${filelist} ]; then
  echo "file list exist"
elif [ "${VIEW}" ]; then
  echo "file list not exist, touch it"
  echo ${pyfile}
  echo ${filelist}
  if [ -f ${pyfile} ]; then
    grep -o 'SourceFile\((.*)\)' ${pyfile}| cut -d\' -f 2 > ${filelist}
    grep -o 'HeaderFile\((.*)\)' ${pyfile}| cut -d\' -f 2 >> ${filelist}
    grep -o 'T55File\((.*\.t55.*)\)' ${pyfile}| cut -d\' -f 2 >> ${filelist}
    grep -o 'ProjectFile\('.*'\)' ${pyfile}| cut -d\' -f 2 >> ${filelist}
    echo "sed -i "s/^/${build_path}\//g" ${filelist}"
    sed -i "s/^/${build_path//\//\\\/}\//g" ${filelist}
    echo "created FileList.txt"
  else
    echo "NO py file"
  fi
fi

tmpfile=${build_path}"/tmp.txt"
tmpfile_win=${tmpfile_path//\//\\}
echo ${tmpfile_win}
echo "-------------------------------------CMD OUTPUT------------------------------"

if [ -n "$CMD" ]; then
  case $CMD in
          lsvtree)
                  grep ${FILE} ${filelist} | while read line
                  do
                    file=${line}
                    echo "FILE: ${file}"
                    if [ -f "${file}" ]&&[ ${LABEL} ]; then
                      cleartool lsvtree ${file} | grep ${LABEL}   
                    else
                      echo "FILE: not exist or input label"
                    fi
                  done
#                  cleartool lsvtree   
                  ;;
          fpy)
                  if [ -f "${pyfile}" ]&&[ "${VIEW}" ]; then
                    echo "CMD:  grep ${FILE} ${pyfile}"
                    grep ${FILE} ${pyfile}
                  else
                    echo "py file missing or input view"
                  fi
                  ;; 
          ffl)
                  if [ -f "${filelist}" ]&&[ "${VIEW}" ]; then
                    echo "CMD:  grep ${FILE} ${filelist}"
                    grep ${FILE} ${filelist} | tee tmp.txt
                    if [ ${PROPERTY} ]; then
                      while IFS= read -r line
                      do
                        cleartool describe ${line}
                      done < tmp.txt
                    fi
                    rm tmp.txt
                  else
                    echo "filelist file missing or input view"
                  fi
                  ;; 
          lview)
                  if [ "${VIEW}" ]; then
                    lsview_cc $VIEW
                  else
                    echo "input view"
                  fi
                  ;; 
          find_filename)
                  if [ -f "${filelist}" ]&&[ "${VIEW}" ]; then
                    echo "CMD:  grep ${FILE} ${filelist}"
                    grep ${FILE} ${filelist} | tee -a gvfile.txt
                  else
                    echo "filelist file missing or input view"
                  fi
                  ;; 
          find_filelabel)
            # -v view    -f the target file list, mklabel on these files  -label: find corresponding file version by label
                  if [ -f "${filelist}" ]&&[ "${VIEW}" ]; then
                    while read -r line
                    do
                      if [ -f ${line} ];then
                        echo ${line} 
                        #cleartool mklabel -r ${label}  ${line}
                        cleartool lsvtree ${line} | grep -e "[ (]${LABEL}"| awk '{print $1}'|tee -a find_filelabel.txt 
                      else
                        echo "------------------------------"                        | tee -a find_filelabel.txt
                        echo "# CMD NO no this file: ${line##*/}                   " | tee -a find_filelabel.txt
                        echo "cleartool checkout -nc ${line%/*}"                     | tee -a find_filelabel.txt
                        echo "touch ${line}"                                         | tee -a find_filelabel.txt
                        echo "cleartool mkelem -nc ${line}"                              | tee -a find_filelabel.txt
                        echo "cd /d  ${line%/*}"                                     | tee -a find_filelabel.txt
                        echo "cleartool ln  src@@\\main\\${line##*/}  src\\${line##*/}"   | tee -a find_filelabel.txt
                        echo "cleartool lsvtree  ${line} | grep -e \"[ (]${LABEL}\" "   | tee -a find_filelabel.txt
                        echo "------------------------------"                        | tee -a find_filelabel.txt
                        #cleartool checkout -nc ${line%/*}
                      fi
                    done < ${FILE}
                  else
                    echo "filelist file missing or input view"
                  fi
                  ;;
          find_spec_name)
                  if [ -f "${filelist}" ]&&[ "${VIEW}" ]; then
                    while read -r line
                    do
                      if [ -f ${line} ];then
                        echo ${line} 
                        #cleartool mklabel -r ${label}  ${line}
                        cleartool describe ${line} | grep -f "./tmp/speclist.txt" 
                      else
                        echo "-----------------------------"
                        #cleartool checkout -nc ${line%/*}
                      fi
                    done < ${FILE}
                  fi
                  ;; 
          stview)
                  if [ "${VIEW}" ]; then
                    startview_cc $VIEW
                  else
                    echo "input view"
                  fi
                  ;; 
          *)
                  echo "No this Command"
                  ;;
  esac
else 
  echo "no command found, please type -h for help"
fi
