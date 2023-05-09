#!/usr/bin/bash
for x in *.JPG
do
    echo "working on ${x}"
    docname=$(echo ${x}|cut -d"." -f1).tex
    metadatatxt=$(echo ${x}|cut -d"." -f1).meta
    echo ${docname}
    echo '\begin{tabbing}' > ${metadatatxt}
    echo '\hspace{5cm}\= \kill' >> ${metadatatxt}
    exiftool ${x} | tail -n 14 | sed 's#$#\\\\#g' |sed 's#:# \\> #' >> $(echo ${metadatatxt})
    cat template > ${docname}
    sed -i "s#IMAGETOPUT#${x}#g" ${docname}
    echo '\end{tabbing}' >> ${metadatatxt}
    sed -i "/end{center}/r ${metadatatxt}" ${docname}
    #$(pdflatex --shell-escape $(echo ${docname}))
done
#rm *.tex
#rm *.meta
