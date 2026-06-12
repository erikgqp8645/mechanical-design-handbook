FROM python:3.11-slim

WORKDIR /app

RUN pip install --no-cache-dir PyMuPDF

COPY . .

CMD ["python3", "web_ui.py"]
