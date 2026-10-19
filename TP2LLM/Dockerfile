FROM python:3.14-slim

WORKDIR /app
COPY . /app
RUN chmod -R a+rwX /app
RUN chmod +x /app/run_llm.sh
CMD ["./run_llm.sh"]