clean:
	rm -f *~ *.aux *.log

pdf:
	for file in *eps;\
	do\
		epstopdf $$file;\
	done

all: clean pdf
