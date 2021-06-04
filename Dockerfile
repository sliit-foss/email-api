FROM ballerina/ballerina

COPY . /app

EXPOSE 9090

CMD ["ballerina", "run", "main.bal"]