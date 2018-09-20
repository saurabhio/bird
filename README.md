# bird

The default password for user ubu (a sudo user) is ubu

##### For Beginners:
* To run container, type following command:
`docker run -it -p 8000:8000 -v ${pwd}:/home/ubu/vol1 --name cntnrName --rm saurabhio/bird`

**_Make sure, Docker has permission to access drive or directory in $pwd_**

* To use Jupyter Notebook, type following command inside container:
`jupyter notebook --ip=0.0.0.0 --port=8000 --no-browser`

* To use JupyterHub, type following command inside container:
`jupyterhub`
