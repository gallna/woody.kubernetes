
## Zeppelin

https://hub.docker.com/r/apache/zeppelin
docker run -p 8080:8080 --rm
  -v $PWD/logs:/logs
  -v $PWD/notebook:/notebook
  -e ZEPPELIN_LOG_DIR='/logs'
  -e ZEPPELIN_NOTEBOOK_DIR='/notebook'
  --name zeppelin apache/zeppelin:0.7.2

## Zeppelin Notebooks

https://github.com/hortonworks-gallery/zeppelin-notebooks
https://community.hortonworks.com/gallery/list.html?page=2&pageSize=15&sort=active

## Jupyter Notebooks

https://github.com/jupyter/jupyter/wiki/A-gallery-of-interesting-Jupyter-Notebooks
