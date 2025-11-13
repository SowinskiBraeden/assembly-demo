FROM ubuntu:latest

RUN apt-get update && apt-get install -y nasm gcc gdb vim

COPY main.asm /app/main.asm

WORKDIR /app
RUN nasm -f elf64 main.asm -o main.o
RUN ld main.o -o main

CMD ["./main"]
