# Pull base image
FROM python:3.10.2-slim-bullseye

EXPOSE 8000

# Set environment variables
ENV PIP_DISABLE_PIP_VERSION_CHECK 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install dependencies
COPY ./requirements.txt .
RUN python -m pip install -r requirements.txt

# Set work directory
WORKDIR /code
# Copy project
COPY . .

RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /code
USER appuser

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app.wsgi"]