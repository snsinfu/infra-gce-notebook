import os

c.JupyterApp.answer_yes = True

c.NotebookApp.ip = "localhost"
c.NotebookApp.port = 8888
c.NotebookApp.token = ""

c.LabApp.app_dir = os.getenv("HOME") + "/.jupyter/app"
c.NotebookApp.notebook_dir = os.getenv("HOME") + "/storage/notebooks"
