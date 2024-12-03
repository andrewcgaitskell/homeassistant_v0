FROM python:3.12.5-bookworm

COPY requirements.txt /tmp
WORKDIR /tmp
RUN pip install -r requirements.txt

WORKDIR /flask

CMD [ "python3", "-m" , "flask", "run", "--debug",  "--host=0.0.0.0"]
