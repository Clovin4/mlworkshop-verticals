FROM ghcr.io/mlflow/mlflow:v2.22.0

ARG APP_HOME=/opt/deployment

ENV APP_HOME=${APP_HOME}
COPY *-server.sh ${APP_HOME}/

RUN chmod a+x ${APP_HOME}/start-server.sh

RUN pip install psycopg2-binary

ENTRYPOINT ["/opt/deployment/start-server.sh"]