# 使用するベースイメージ
# FROM --platform=linux/amd64 python:3.9
FROM python:3.9

# 環境変数を設定（Pythonのunbufferedモードを有効にする）
ENV PYTHONUNBUFFERED=1

# 必要なライブラリをインストール
RUN apt-get update && apt-get install -y \
    postgresql-client \
 && apt-get clean

RUN pip install --upgrade pip

COPY ./requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./src /app

EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

