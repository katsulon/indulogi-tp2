FROM python:3.9

# Create a non-root user
RUN useradd -m app

WORKDIR /code

COPY ./setup.py /code/setup.py

COPY ./requirements.txt /code/requirements.txt

COPY ./README.md /code/README.md

COPY ./src /code/src

RUN pip install /code

COPY ./controller /code/controller

# Change ownership of the /code directory
RUN chown -R appuser:appuser /code

# Switch to the non-root user
USER appuser

# Run the application (use port 8000 instead of 80, as non-root users can't bind to ports <1024)
CMD ["uvicorn", "controller.controller:app", "--host", "0.0.0.0", "--port", "8000"]
