FROM python:slim-buster

WORKDIR /app

COPY Pipfile Pipfile.lock ./

RUN pip install pipenv \
  && pipenv install --deploy --system

COPY . /app

WORKDIR /app

ENTRYPOINT ["python"]
CMD ["app.py"]
