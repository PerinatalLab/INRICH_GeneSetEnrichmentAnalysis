#!/usr/bin/Rscript

asc_dir="./assoc/"
ref_dir="./refs/gene_sets/"
lst1=list.files(asc_dir,pattern="moms_nonPROM")
lst2=list.files(ref_dir,pattern="PubMed_geneSets_forINRINCH_OBSTETRICSandCONTROL.txt") ##   CAREFUL!  MAKE SURE ALL FILES HAVE THIS SUFFIX
out_dir="./results/"


for (n in c(25,50,100)) {
for (z in c(100,200,300,400)) {
for (i in lst1) {
for (j in lst2) {
txt1=paste(unlist(strsplit(i,"_"))[1:2],collapse="_")
txt2=unlist(strsplit(j,"_"))[4]
cmnd=paste("./1_run_InRich.sh" , paste(asc_dir,i,sep=""), paste(out_dir,txt1,"_",txt2,"_top",z,"_",n,"kb",sep=""), z, paste(ref_dir,j,sep=""),n, sep=" ")
system(cmnd,ignore.stdout=F)
}
}
}
}



